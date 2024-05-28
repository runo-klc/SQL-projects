-- QUERIES

-- 5 simple queries

-- 1.
select IME, PREZIME , DAT_ROD, NACIONALNOST from SKIJAS
order by PREZIME asc;

-- 2.

select IME_SKIJALISTA, BROJ_STAZA from SKIJALISTE
where LOKACIJA = 'Alpe'
order by BROJ_STAZA desc;

-- 3.

select IME_UTRKE, DAT_UTRKE, KATEG from UTRKA
order by DAT_UTRKE asc;

-- 4.

select PROIZVODAC from SKIJE;

-- 5.

select IME_DRZAVE, BR_STAN, BDP from DRZAVA
where BR_STAN > 5000000;




-- 5 more complex queries (with joins)

-- 1.

select IME || ' ' || PREZIME "Ime i prezime", BODOVI, IME_UTRKE from SKIJAS 
inner join REZULTAT using (SKIJAS_ID)
inner join UTRKA using (UTRKA_ID)
where SKIJAS.NACIONALNOST = 'CRO'
order by BODOVI desc;

-- 2.

select COUNT(REZ_ID) BROJ_POSTOLJA, IME_DISCIPLINE from REZULTAT
inner join SKIJAS USING (SKIJAS_ID)
inner join UTRKA USING (UTRKA_ID)
inner join DISCIPLINA USING (DISCIPLINA_ID)
where SKIJAS.IME = 'Mikaela' and SKIJAS.PREZIME = 'Shiffrin' and (PLASMAN = 1 or PLASMAN = 2 or PLASMAN = 3)
group by IME_DISCIPLINE;


-- 3.

select PROIZVODAC, SUM(BODOVI) as BODOVI from 
SKIJE inner join IMA_SKIJE using (SKIJE_ID)
inner join SKIJAS using (SKIJAS_ID)
inner join REZULTAT using (SKIJAS_ID)
group by PROIZVODAC
order by BODOVI desc;


-- 4.

select IME_DRZAVE, COUNT(UTRKA_ID) as BR_UTRKA from DRZAVA
inner join SKIJALISTE using (DRZAVA_ID)
inner join UTRKA using (SKIJALISTE_ID)
group by IME_DRZAVE
order by BR_UTRKA desc;


-- 5.

select ROUND(AVG(VRIJEME_UK),2) PROSJ_VR, IME_UTRKE, IME_SKIJALISTA, IME_DISCIPLINE from REZULTAT
inner join UTRKA using (UtRKA_ID)
inner join SKIJALISTE USING (SKIJALISTE_ID)
inner join DISCIPLINA using (DISCIPLINA_ID)
where DISCIPLINA.KATEGORIJA = 'Brza'
group by IME_UTRKE, IME_SKIJALISTA, IME_DISCIPLINE;



-- 5 queries with aggregating functions 

-- 1.

select AVG(BR_STAN) PROSJ_BR_STAN , MEDIAN(BDP) MEDIJAN_BDP from DRZAVA;


-- 2.

select ROUND(AVG(FLOOR((TO_DATE('27-AUG-2023') - DAT_ROD)/365.25)),2) "Prosječna dob", SPOL from SKIJAS
group by SPOL;


-- 3.

select SUM(zarada) UK_ZARADA_ZEMLJE, NACIONALNOST from REZULTAT
inner join SKIJAS using(SKIJAS_ID)
group by NACIONALNOST
order by UK_ZARADA_ZEMLJE desc;


-- 4.

select ROUND(AVG(BODOVI),2) AVG_BODOVI from REZULTAT
inner join SKIJAS using (SKIJAS_ID)
inner join UTRKA using (UTRKA_ID)
inner join DISCIPLINA using (DISCIPLINA_ID)
where IME = 'Marco' and PREZIME = 'Odermatt';


-- 5.

select AVG(NMV_START) PROSJ_NMV_START, AVG(NMV_CILJ) PROSJ_NMV_CILJ from UTRKA;




-- subqueries, nested queries, rest

-- 1.

-- prosjecan broj bodova hrvatskih skijasa
select bodovi from REZULTAT
inner join skijas using (skijas_id)
where NACIONALNOST = 'CRO';



select ROUND(AVG(BODOVI),2) AVG_BODOVI, NACIONALNOST from REZULTAT
inner join SKIJAS using (SKIJAS_ID)
having AVG(BODOVI) > (
    select AVG(BODOVI) from REZULTAT
    inner join SKIJAS using (SKIJAS_ID)
    where NACIONALNOST = 'CRO'
)
group by NACIONALNOST
order by AVG(BODOVI) desc;


-- 2.


select skijas_id, ime, prezime from SKIJAS
inner join REZULTAT using (skijas_id)
inner join utrka using (utrka_id)
inner join DISCIPLINA using (disciplina_id)
where VRIJEME_DV is NULL and KATEGORIJA = 'Tehnicka';

--
select IME, PREZIME, SUM(BODOVI) UK_BODOVI from REZULTAT 
inner join SKIJAS using (SKIJAS_ID)
where SKIJAS_ID in (
    select SKIJAS_ID from SKIJAS
    inner join REZULTAT using (SKIJAS_ID)
    inner join UTRKA using (UTRKA_ID)
    inner join DISCIPLINA using (DISCIPLINA_ID)
    where VRIJEME_DV is NULL and KATEGORIJA = 'Tehnicka'
)
group by IME, PREZIME
order by UK_BODOVI desc;



-- 3.

select skijaliste_id from SKIJALISTE
where NADM_VISINA BETWEEN 1500 and 2200;

--

select IME_UTRKE, IME_DRZAVE from UTRKA
inner join SKIJALISTE using(SKIJALISTE_ID)
inner join DRZAVA using (DRZAVA_ID)
where SKIJALISTE_ID in (
    select SKIJALISTE_ID from SKIJALISTE
    where NADM_VISINA BETWEEN 1500 and 2200
);


-- 4.

select skijas_id, ime, prezime from SKIJAS
inner join ima_skije using (skijas_id)
inner join skije using(skije_id)
where PROIZVODAC = 'Voelkl';

--

select distinct(IME_UTRKE), IME_DISCIPLINE from UTRKA
inner join REZULTAT using (UTRKA_ID)
inner join DISCIPLINA using (DISCIPLINA_ID)
inner join SKIJAS using (SKIJAS_ID)
where SKIJAS_ID in (
    select SKIJAS_ID from SKIJAS
    inner join IMA_SKIJE using (SKIJAS_ID)
    inner join SKIJE using(SKIJE_ID)
    where PROIZVODAC = 'Voelkl'
);



-- 5.

select IME || ' ' || PREZIME "Ime i prezime" from SKIJAS
inner join REZULTAT using (SKIJAS_ID)
inner join UTRKA using (UTRKA_ID)
inner join DISCIPLINA using (DISCIPLINA_ID)
where IME_DISCIPLINE = 'Slalom'
intersect
select IME || ' ' || PREZIME "Ime i prezime" from SKIJAS
inner join REZULTAT using (SKIJAS_ID)
inner join UTRKA using (UTRKA_ID)
inner join DISCIPLINA using (DISCIPLINA_ID)
where IME_DISCIPLINE = 'Spust'
intersect
select IME || ' ' || PREZIME "Ime i prezime" from SKIJAS
inner join REZULTAT using (SKIJAS_ID)
inner join UTRKA using (UTRKA_ID)
inner join DISCIPLINA using (DISCIPLINA_ID)
where IME_DISCIPLINE = 'Veleslalom'
intersect
select IME || ' ' || PREZIME "Ime i prezime" from SKIJAS
inner join REZULTAT using (SKIJAS_ID)
inner join UTRKA using (UTRKA_ID)
inner join DISCIPLINA using (DISCIPLINA_ID)
where IME_DISCIPLINE = 'Super G';


-- DEFAULT VALUES, COMMENTS, CONDITIONS

-- default values
-- 1.
alter table UTRKA 
modify NAGRADNI_FOND default 120000;


-- 2.

alter table REZULTAT
MODIFY PLASMAN default 0;

-- CONDITIONS

-- 1.
alter table DISCIPLINA add CONSTRAINT PROV_DISC check (IME_DISCIPLINE in ('Slalom', 'Veleslalom', 'Spust', 'Super G'));


alter table UTRKA add CONSTRAINT PROM_FONDA check (NAGRADNI_FOND >= 120000);

-- comments

-- on tables
comment on table SPONZOR is 'Tablica individualnih sponzora skijasa';
comment on table REZULTAT is 'Tablica svih rezultata u svim utrkama';
comment on table SKIJAS is 'Tablica svih skijasa';

-- on rows
comment on column UTRKA.KATEG is 'Je li odrzana utrka u muskoj ili u zenskoj konkurenciji';
comment on column DISCIPLINA.KATEGORIJA is 'Za lakse razlikovanje brzih i tehnickih disciplina';



-- PROCEDURES

-- 1.

create or replace procedure SKIJASI_IN_UP(
    SK_ID in SKIJAS.SKIJAS_ID%TYPE,
    SK_IME in SKIJAS.IME%TYPE,
    SK_PREZ in SKIJAS.PREZIME%TYPE,
    SK_SPOL in SKIJAS.SPOL%TYPE,
    SK_D_R in SKIJAS.DAT_ROD%TYPE,
    SK_NAC in SKIJAS.NACIONALNOST%TYPE
)
as
    BROJ_SKIJASA integer;
begin
    select COUNT(*) into BROJ_SKIJASA from SKIJAS where SKIJAS_ID = SK_ID;
    IF BROJ_SKIJASA = 0 THEN
        insert into SKIJAS values (SK_ID, SK_IME, SK_PREZ, SK_SPOL, SK_D_R, SK_NAC);
        DBMS_OUTPUT.PUT_LINE('Dodan je skijas s id-jem ' || SK_ID);
        commit;
    ELSE 
        update SKIJAS set IME = SK_IME, PREZIME = SK_PREZ, SPOL = SK_SPOL, DAT_ROD = SK_D_R, NACIONALNOST = SK_NAC where SK_ID = SKIJAS_ID;
        DBMS_OUTPUT.PUT_LINE('Napravljena je izmjena kod skijasa s id-jem ' || SK_ID);
        commit;
    END IF;
end;
/

-- Napravimo unos skijasa kojeg nemamo u bazi... Pietro Zazzi, 22-07-1994, ITA te unesimo namjerno krivi datum rodenja
call SKIJASI_IN_UP(223, 'Pietro', 'Zazzi', 'M', TO_DATE('21-07-1994', 'dd-MM-yyyy'), 'ITA');

select * from skijas Where skijas_id = 223;

-- ako sada opet pozovemo proceduru samo s tocnim datumom 
call SKIJASI_IN_UP(223, 'Pietro', 'Zazzi', 'M', TO_DATE('22-07-1994', 'dd-MM-yyyy'), 'ITA');

select * from skijas Where skijas_id = 223;

delete from skijas where skijas_id = 223;




-- 2.

select ime, prezime, sum(bodovi) uk_bodovi from skijas
inner join rezultat using (skijas_id)
inner join utrka using (utrka_id)
inner join disciplina using (disciplina_id)
where ime_discipline = 'Spust' and spol = 'F'
group by ime, prezime
order by uk_bodovi desc
fetch first 10 rows only;
-- ovo gore treba spremiti u neki kursor zato sto zelimo dohvatiti te retke iz tablice, ali da prima bilo koju vrijednost discipline i spola


create or replace procedure TOP_TEN(
    DISC in DISCIPLINA.IME_DISCIPLINE%type,
    SP in SKIJAS.SPOL%type
)
as
    cursor T_TEN is
        select IME, PREZIME, SUM(BODOVI) UK_BODOVI from SKIJAS
        inner join REZULTAT using (SKIJAS_ID)
        inner join UTRKA using (UTRKA_ID)
        inner join DISCIPLINA using (DISCIPLINA_ID)
        where IME_DISCIPLINE = DISC and SPOL = SP
        group by IME, PREZIME
        order by UK_BODOVI desc
        fetch first 10 rows only;
    T_TEN_DVA T_TEN%rowtype;
BEGIN
    open T_TEN;
    LOOP
        fetch T_TEN into T_TEN_DVA;
        EXIT WHEN T_TEN%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(T_TEN_DVA.IME || ' ' || T_TEN_DVA.PREZIME || ' je ostvario/la ' || T_TEN_DVA.UK_BODOVI || ' bodova.');
    END LOOP;
    close T_TEN;
end;
/


call TOP_TEN('Slalom', 'F');



-- INDEXES

-- 1.

create index SKIJAS_INDEX on SKIJAS(IME, PREZIME);


-- 2.

create index NAC_INDEX on SKIJAS(NACIONALNOST);

-- 3.

create index PLANINA_INDEX on SKIJALISTE(LOKACIJA);

-- bitmap indeks kako bismo olaksali pretrazivanje skija pojedinog skijasa jer imamo preko 200 skijasa, a samo 12 vrsta skija tj. prozivodaca

-- 4.

create BITMAP index SPOL_SKIJAS_INDEX on SKIJAS(SPOL);


-- TRIGGERS

-- 1.

create or replace TRIGGER NEG_BOD_TRIGGER
before update or insert of BODOVI on REZULTAT 
for each row
when (new.BODOVI < 0)
begin
    raise_application_error(-20111, 'Broj bodova ne moze biti negativan');
end;
/

-- PR
-- pokusajmo promijeniti bodove Filipu Zubcicu u veleslalomu u Adelbodenu, to je rezultat s id-jem 0112
select ime, prezime, bodovi from SKIJAS
inner join rezultat using (skijas_id)
where rez_id = 0112;
-- ima 22 boda

update rezultat set bodovi = -10 where rez_id = 0112;


--s obzirom na raspodjelu financijskih nagrada na pojedinoj utrci nije moguce da skijas zaradi manje od 550 franaka pa neka to bude donja granica, a ako netko pokusa unjeti manje aktivirat ce se okidac

create or replace TRIGGER ZARADA_TRIGGER
before update or insert of ZARADA on REZULTAT 
for each row
when (new.ZARADA < 550 or new.ZARADA > 98000)
begin
    raise_application_error(-20110, 'Nije moguce zaraditi toliko novca');
end;
/

-- pokusajmo promijeniti zaradu za isti primjer kao i malo prije. Dakle, pokusat cemo promijeniti zaradu Filipu Zubcicu na utrci u Adelbodenu, id rezultata je 0112, zarada 1600CHF

update rezultat set zarada = 400 where rez_id = 0112;











-- sve iz seminara

-- jednostavni upiti

select ime, prezime, DAT_ROD, NACIONALNOST from skijas
order by prezime asc;

select ime_skijalista, broj_staza from SKIJALISTE
where lokacija = 'Alpe'
order by broj_staza desc;

select ime_utrke, dat_utrke, kateg from UTRKA
order by dat_utrke desc;

select PROIZVODAC from skije;

select ime_drzave, br_stan, bdp from DRZAVA
where br_stan > 5000000;


-- upiti nad vise tablica

select ime, prezime, ime_utrke, bodovi from SKIJAS
inner join rezultat using (skijas_id)
inner join utrka using (utrka_id) 
where nacionalnost = 'CRO'
order by bodovi desc;

select count(distinct(rez_id)), IME_DISCIPLINE from utrka
inner join rezultat using (utrka_id)
inner join skijas using (skijas_id)
inner join disciplina using (DISCIPLINA_id)
where skijas.IME = 'Mikaela' and skijas.PREZIME = 'Shiffrin' and (REZULTAT.PLASMAN = 1 or plasman = 2 or plasman = 3)
group by IME_DISCIPLINE;

select sum(bodovi) sum_bodovi, PROIZVODAC from SKIJE
inner join IMA_SKIJE using (skije_id)
inner join skijas using (skijas_id)
inner join rezultat using (skijas_id)
group by PROIZVODAC
ORDER by sum_bodovi desc;

select count(distinct(utrka_id)) br_utrka, ime_drzave from utrka 
inner join skijaliste using (skijaliste_id)
inner join drzava using (drzava_id)
group by IME_DRZAVE
order by br_utrka desc;

select round(avg(VRIJEME_UK),2) avg_vr, ime_utrke, ime_skijalista, ime_discipline from REZULTAT
inner join utrka using (utrka_id)
inner join skijaliste using (skijaliste_id)
inner join disciplina using (DISCIPLINA_id)
where DISCIPLINA.KATEGORIJA = 'Brza'
group by ime_utrke, ime_skijalista, IME_DISCIPLINE
order by avg_vr asc;


-- agregirajuce funkije

select avg(BR_STAN), median(bdp) from drzava;

select round(avg(floor((to_date('27-AUG-2023') - DAT_ROD)/365.25)),2) avg_dob, spol from SKIJAS
group by spol;

select sum(zarada) uk_z, NACIONALNOST from REZULTAT
inner join skijas using (skijas_id)
group by NACIONALNOST
order by uk_z desc;

select round(avg(bodovi),2), IME_DISCIPLINE from REZULTAT
inner join skijas using (skijas_id)
inner join utrka using (utrka_id)
inner join disciplina using (disciplina_id)
where ime = 'Marco' and prezime = 'Odermatt'
group by IME_DISCIPLINE;

select avg(NMV_START), avg(NMV_CILJ) from utrka;


-- podupiti

select avg(BODOVI) from rezultat 
inner join skijas using (skijas_id)
where nacionalnost = 'CRO';

select round(avg(bodovi),2), nacionalnost from REZULTAT
inner join skijas using (skijas_id)
having avg(bodovi) > (
    select avg(BODOVI) from rezultat 
    inner join skijas using (skijas_id)
    where nacionalnost = 'CRO'
)
group by NACIONALNOST
order by avg(bodovi) desc;

--

select skijas_id from SKIJAS
inner join rezultat using (skijas_id)
inner join utrka using (utrka_id)
inner join disciplina using (disciplina_id)
where KATEGORIJA = 'Tehnicka' and vrijeme_dv is null;


select ime, prezime, sum(bodovi) from SKIJAS
inner join rezultat using (skijas_id)
where skijas_id in (
    select skijas_id from SKIJAS
    inner join rezultat using (skijas_id)
    inner join utrka using (utrka_id)
    inner join disciplina using (disciplina_id)
    where KATEGORIJA = 'Tehnicka' and vrijeme_dv is null
)
group by ime, PREZIME
order by sum(bodovi) desc;


--

select skijaliste_id from SKIJALISTE
where NADM_VISINA between 1500 and 2100;

select ime_utrke, ime_skijalista, IME_DRZAVE from UTRKA
inner join skijaliste using (skijaliste_id)
inner join drzava using (drzava_id)
where skijaliste_id in (
    select skijaliste_id from SKIJALISTE
    where NADM_VISINA between 1500 and 2100
)
group by ime_utrke, ime_skijalista, ime_drzave;


--
select skijas_id from SKIJAS
inner join ima_skije using (skijas_id)
inner join skije using (skije_id)
where PROIZVODAC = 'Voelkl';

select ime_utrke, IME_DISCIPLINE from UTRKA
inner join disciplina using (disciplina_id)
inner join rezultat using (utrka_id)
inner join skijas using (skijas_id)
where skijas_id in (
    select skijas_id from SKIJAS
    inner join ima_skije using (skijas_id)
    inner join skije using (skije_id)
    where PROIZVODAC = 'Voelkl'
)
group by ime_utrke, ime_discipline;


-- zadane vrijednosti

alter table utrka modify nagradni_fond default 120000;

alter table rezultat modify plasman default 0;

alter table disciplina add constraint prov_disc check (IME_DISCIPLINE in ('slalom', 'veleslalom', ''))


create index skijas_index on skijas(ime,prezime);
create index nac_index on skijas(nacionalnost);

create bitmap index spol_index on skijas(spol);

-- procedure


create or replace procedure unos_skijasa(
    sk_id in skijas.skijas_id%type,
    ...
)
as
    broj_skijasa integer;
begin
    select count(*) into broj_skijasa from skijas where skijas_id = sk_id;
    if br_skijasa = 0 then
        insert into skijas values() ;
        commit;
    else
        update skijas set where ;
        commit;
    end if;

end;
/


--

select ime, prezime, sum(bodovi) uk_bodovi from skijas
inner join rezultat using (skijas_id)
inner join utrka using (utrka_id)
inner join disciplina using (disciplina_id)
where disciplina = and spol = 
group by ime, prezime
order by uk_bodovi desc
fetch frist 10 rows only;

create or replace procedure top_ten(
    disc
    spol
)
as cursor c_skijasi is 
    select ime, prezime, sum(bodovi) uk_bodovi from skijas
    inner join rezultat using (skijas_id)
    inner join utrka using (utrka_id)
    inner join disciplina using (disciplina_id)
    where disciplina = and spol = 
    group by ime, prezime
    order by uk_bodovi desc
    fetch frist 10 rows only;  
    r_skijasi c_skijasi%rowtype;
begin
    open c_skijasi;
    loop
        fetch c_skijasi into r_skijasi;
        exit when c_skijasi%notfound;
        dbms_output.put_line();
    end loop;
    close c_skijasi
end;
/














create or replace procedure ime_procedure(
    nest ime_tablice.atribut%type,
    nest2 ime_tablice.atrbut%type
)
as
    brojac integer;
begin
    select count(*) into brojac from tablica where id = id;
    if brojac = 0 then
        insert into tablica values ();
        commit;
    else
        update table tablica set ..., where id = id;
    commit;
    end if;
end;




create or replace procedure(

)
as cursor c_kursor is
    upit;
    r_cursor c_cursor%rowtype;
begin
    open c_kursor;
    loop
        fetch r_cursor into c_cursor;
        exit when r_cursor%notfound;
        dbms_output.put_line;
    end loop;
    close c_kursor;
end;
/




create or replace function ime_funkcije(
    stoprima tablica.redak%type,
    ...
)
return integer
    is broj_necega;
begin
    select...;
    return broj_necega;
end funkcija;
/























































































