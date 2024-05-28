-- TABLICE I UNOS PODATAKA

-- u ovom file-u cemo napraviti tablice do kojih smo dosli pretvorbom MEV-a u relacijski model.
-- nakon toga cemo sve tablice popuniti podacima

-- TABLICE

drop table SKIJAS CASCADE CONSTRAINT;
drop table SKIJE CASCADE CONSTRAINT;
drop table IMA_SKIJE CASCADE CONSTRAINT;
drop table SPONZOR CASCADE CONSTRAINT;
drop table IMA_SPONZORA CASCADE CONSTRAINT;
drop table DISCIPLINA CASCADE CONSTRAINT;
drop table DRZAVA CASCADE CONSTRAINT;
drop table SKIJALISTE CASCADE CONSTRAINT;
drop table UTRKA CASCADE CONSTRAINT;
drop table REZULTAT CASCADE CONSTRAINT;


create table SKIJAS (
    SKIJAS_ID INTEGER CONSTRAINT SKIJAS_ID_PK PRIMARY KEY,
    IME VARCHAR2(30) NOT NULL,
    PREZIME VARCHAR2(30) NOT NULL,
    SPOL VARCHAR2(1) NOT NULL,
    DAT_ROD DATE NOT NULL,
    NACIONALNOST VARCHAR2(3) NOT NULL
);

CREATE TABLE SKIJE (
    SKIJE_ID INTEGER CONSTRAINT SKIJE_ID_PK PRIMARY KEY,
    PROIZVODAC VARCHAR2(10) NOT NULL
);

CREATE TABLE IMA_SKIJE (
    SKIJAS_ID INTEGER NOT NULL,
    SKIJE_ID INTEGER NOT NULL,
    CONSTRAINT IMA_SKIJE_PK PRIMARY KEY (SKIJE_ID, SKIJAS_ID)
);

CREATE TABLE SPONZOR (
    SPONZOR_ID INTEGER CONSTRAINT SPONZOR_ID_PK PRIMARY KEY,
    IME_SPONZORA VARCHAR2(30) NOT NULL
);

CREATE TABLE IMA_SPONZORA (
    SKIJAS_ID INTEGER NOT NULL,
    SPONZOR_ID INTEGER NOT NULL,
    CONSTRAINT IMA_SPONZORA_PK PRIMARY KEY (SPONZOR_ID, SKIJAS_ID)
);

CREATE TABLE DISCIPLINA (
    DISCIPLINA_ID INTEGER CONSTRAINT DISCIPLINA_ID_PK PRIMARY KEY,
    IME_DISCIPLINE VARCHAR2(15) NOT NULL,
    KATEGORIJA VARCHAR(10) NOT NULL
);

CREATE TABLE DRZAVA (
    DRZAVA_ID INTEGER CONSTRAINT DRZAVA_ID_PK PRIMARY KEY,
    IME_DRZAVE VARCHAR2(15) NOT NULL,
    BR_STAN INTEGER NOT NULL,
    BDP INTEGER NOT NULL
);


CREATE TABLE SKIJALISTE (
    SKIJALISTE_ID INTEGER CONSTRAINT SKIJALISTE_ID_PK PRIMARY KEY,
    IME_SKIJALISTA VARCHAR2(40) NOT NULL,
    LOKACIJA VARCHAR2(20) NOT NULL,
    NADM_VISINA INTEGER,
    BROJ_STAZA INTEGER,
    DRZAVA_ID INTEGER NOT NULL CONSTRAINT DRZAVA_SKIJALISTE_FK REFERENCES "DRZAVA" (DRZAVA_ID)
);


CREATE TABLE UTRKA (
    UTRKA_ID INTEGER CONSTRAINT UTRKA_ID_PK PRIMARY KEY,
    IME_UTRKE VARCHAR2(30) NOT NULL,
    DAT_UTRKE TIMESTAMP NOT NULL,
    KATEG VARCHAR2(1),
    NMV_START INTEGER,
    NMV_CILJ INTEGER,
    NAGRADNI_FOND INTEGER,
    DISCIPLINA_ID INTEGER NOT NULL CONSTRAINT UTRKA_DISCIPLINA_FK REFERENCES "DISCIPLINA" (DISCIPLINA_ID),
    SKIJALISTE_ID INTEGER NOT NULL CONSTRAINT UTRKA_SKIJALISTE_FK REFERENCES "SKIJALISTE" (SKIJALISTE_ID) 
);

CREATE TABLE REZULTAT (
    REZ_ID INTEGER CONSTRAINT REZ_ID_PK PRIMARY KEY,
    PLASMAN INTEGER NOT NULL,
    VRIJEME_PV NUMBER(5,2),
    VRIJEME_DV NUMBER(5,2),
    VRIJEME_UK NUMBER(5,2),
    BODOVI INTEGER NOT NULL,
    ZARADA INTEGER,
    SKIJAS_ID INTEGER NOT NULL CONSTRAINT REZULTAT_SKIJAS_FK REFERENCES "SKIJAS" (SKIJAS_ID),
    UTRKA_ID INTEGER NOT NULL CONSTRAINT REZULTAT_UTRKA_FK REFERENCES "UTRKA" (UTRKA_ID)
);



-- UNOS PODATAKA
-- iako sama skijaska sezona ima preko 50 utrka, radi jednostavnosti odabrat cemo 20 utrka (10-muskarci, 10-zene) za koje cemo unositi odgovarajuce podatke o skijalistima, utrkama i skijasima koji su ih vozili

-- SPONZORI


INSERT INTO SPONZOR VALUES (1,'Adidas');
INSERT INTO SPONZOR VALUES (2, 'Land Rover');
INSERT INTO SPONZOR VALUES (3, 'Barilla');
INSERT INTO SPONZOR VALUES (4, 'Visa');
INSERT INTO SPONZOR VALUES (5, 'Oakley');
INSERT INTO SPONZOR VALUES (6, 'UNIQA');
INSERT INTO SPONZOR VALUES (7, 'Audi');
INSERT INTO SPONZOR VALUES (8, 'Peta');
INSERT INTO SPONZOR VALUES (9, 'Helevita');
INSERT INTO SPONZOR VALUES (10, 'Red Bull');
INSERT INTO SPONZOR VALUES (11, 'Helly Hansen');
INSERT INTO SPONZOR VALUES (12, 'EA7');
INSERT INTO SPONZOR VALUES (13, 'Spar');
INSERT INTO SPONZOR VALUES (14, 'Colmar');
INSERT INTO SPONZOR VALUES (15, 'Leki');
INSERT INTO SPONZOR VALUES (16, 'HEP');
INSERT INTO SPONZOR VALUES (17, 'Argeta');
INSERT INTO SPONZOR VALUES (18, 'Garmin');
INSERT INTO SPONZOR VALUES (19, 'DNB');
INSERT INTO SPONZOR VALUES (20, 'A1');
INSERT INTO SPONZOR VALUES (21, 'Longines');
INSERT INTO SPONZOR VALUES (22, 'Poc');
INSERT INTO SPONZOR VALUES (23, 'Nocco');
INSERT INTO SPONZOR VALUES (24, 'Komperdell');
INSERT INTO SPONZOR VALUES (25, 'Reusch');
INSERT INTO SPONZOR VALUES (26, 'Bolle');
INSERT INTO SPONZOR VALUES (27, 'Petrol');
INSERT INTO SPONZOR VALUES (28, 'Uvex');
INSERT INTO SPONZOR VALUES (29, 'Targa');



-- SKIJE
-- najpoznatiji proizvodaci skija

INSERT INTO SKIJE VALUES (1, 'Head');
INSERT INTO SKIJE VALUES (2, 'Atomic');
INSERT INTO SKIJE VALUES (3, 'Rossignol');
INSERT INTO SKIJE VALUES (4, 'Stoeckli');
INSERT INTO SKIJE VALUES (5, 'Fischer');
INSERT INTO SKIJE VALUES (6, 'Voelkl');
INSERT INTO SKIJE VALUES (7, 'Van Deer');
INSERT INTO SKIJE VALUES (8, 'Dynastar');
INSERT INTO SKIJE VALUES (9, 'Nordica');
INSERT INTO SKIJE VALUES (10, 'Salomon');
insert into skije values (11, 'Blizzard');
insert into skije values (12, 'Kaestle');


-- DRZAVA
-- drzave u kojima su u sezoni 22/23 odrzane utrke koje smo odabrali

-- BDP cemo izraziti u milijunima USD tako ce primjerice BDP SAD-a jednak 26854599 milijuna dolara (milijun milijuna = bilijun), gledamo podatak za 2022.

insert into drzava values (1, 'Austrija', 9129091, 471400000000);
insert into drzava values (2, 'Svicarska', 8865270, 807706000000);
insert into drzava values (3, 'Italija', 58803163, 2010432000000);
insert into drzava values (4, 'SAD', 333287000, 25462700000000);
insert into drzava values (5, 'Kanada', 40173200, 2139840000000);
insert into drzava values (6, 'Francuska', 68042591, 2782905000000);
insert into drzava values (7, 'Njemacka', 84358845,4072192000000);
insert into drzava values (8, 'Hrvatska', 3888529, 70965000000);
insert into drzava values (9, 'Slovenija', 2117674, 62118000000);
insert into drzava values (10, 'Ceska', 10827529, 290924000000);
insert into drzava values (11, 'Norveska', 5504329, 579267000000);
insert into drzava values (12, 'Andora', 83523, 3352000000);


-- DISCIPLINA
-- unjet cemo samo discipline u kojima su vozene utrke u sezoni 22/23

insert into disciplina values (1, 'Spust', 'Brza');
insert into disciplina values (2, 'Super G', 'Brza');
insert into disciplina values (3, 'Slalom', 'Tehnicka');
insert into disciplina values (4, 'Veleslalom', 'Tehnicka');


-- SKIJALISTE
-- unosimo podatke o skijalistima na kojima su vozene utrke svjetskog kupa
-- pod lokacija se smatra na kojoj planini se nalazi skijaliste, a radi jednostavnosti cemo razlicite planine unutar veceg lanca smatrati kao taj lanac (npr Otzalske Alpe i Juzne Alpe ce biti samo Alpe)

insert into SKIJALISTE values (1, 'Soelden', 'Alpe', 1368, 144, 1);
insert into SKIJALISTE values (2, 'Lake Louise', 'Rocky Mountains' , 1646, 145, 5);
insert into skijaliste values (3, 'Killington', 'Green Mountains', 1289, 155, 4);
insert into skijaliste values (4, 'Beaver Creek', 'Beaver Creek', 2470, 167, 4);
insert into skijaliste values (5, 'Val Gardena', 'Alpe', 1563, 117, 3);
insert into skijaliste values (6, 'St. Moritz', 'Alpe', 1800, 87, 2);
insert into skijaliste values (7, 'Alta Badia', 'Alpe', 1324, 103, 3);
insert into skijaliste values (8, 'Garmisch-Partenkirchen', 'Alpe', 720, 31, 7);
insert into skijaliste values (9, 'Sljeme', 'Medvednica', 1033, 5, 8);
insert into skijaliste values (10, 'Adelboden', 'Alpe', 1350, 177, 2);
insert into skijaliste values (11, 'Kranjska Gora', 'Alpe', 806, 16, 9);
insert into skijaliste values (12, 'Wengen', 'Alpe', 1275, 55, 2);
insert into skijaliste values (13, 'St. Anton', 'Alpe', 1304, 66, 1);
insert into skijaliste values (14, 'Kitzbuehel', 'Alpe', 762, 92, 1);
insert into skijaliste values (15, 'Spindlruv Mlyn', 'Medvedin', 718, 7, 10);
insert into skijaliste values (16, 'Chamonix', 'Alpe', 1035, 492, 6);
insert into skijaliste values (17, 'Cortina d Ampezzo', 'Alpe', 1224, 73, 3);
insert into skijaliste values (18, 'Aspen', 'Rocky Mountains', 2438, 76, 4);
insert into skijaliste values (19, 'Kvitfjell', 'Kvitfjell', 854, 23, 11);
insert into skijaliste values (20, 'Soldeu', 'Pireneji', 1710, 186, 12);



-- UTRKA
-- unosimo podatke o svim utrkama odrzanim u sezoni 22/23 (napomena: necemo ukljuciti utrke svjetskog prvenstva jer se te utrke ne boduju za svjetski kup)

-- nakon datuma stavi kategoriju M-muski F-zene
-- sto ovdje ozacava ID prva dva broja su broj utrke u sezoni prva, druga, treca... ,a treci broj predstavlja je li to prva ili druga voznja

select dat_utrke from utrka;

insert into UTRKA values (001, 'Soelden Ski World Cup', TO_TIMESTAMP('23-10-2022 10:00:00', 'dd-MM-yyyy HH24:MI::SS'), 'M', 3040, 2670, 132000, 4, 1);
insert into utrka values (002, 'The Killington Cup', TO_TIMESTAMP('26-11-2022 16:00:00', 'dd-MM-yyyy HH24:MI:SS'), 'F', 1066, 782, 132000, 4, 3);
insert into UTRKA values (003, 'Xfinity Birds of Pray', TO_TIMESTAMP('04-12-2022 18:00:00', 'dd-MM-yyyy HH24:MI:SS'), 'M', 3337, 2730, 132000, 2, 4);
insert into utrka values (004, 'Lake Louise Alpine World Cup', TO_DATE('02-12-2022 20:00:00', 'dd-MM-yyyy HH24:MI:SS'), 'F', 2469, 1680, 132000, 1, 2);
insert into utrka values (005, '55. Saslong Classic', TO_TIMESTAMP('17-12-2022 11:45:00', 'dd-MM-yyyy HH24:MI:SS'), 'M', 2249, 1410, 132000, 1, 5);
insert into utrka values (006, 'Alpine Skiing Competitions', TO_TIMESTAMP('17-12-2022 10:30:00', 'dd-MM-yyyy HH24:MI:SS'), 'F', 2590, 2040, 132000, 1, 6);
insert into utrka values (007, 'Audi FIS Ski World Cup', TO_TIMESTAMP('18-12-2022 10:00:00', 'dd-MM-yyyy HH24:MI:SS'), 'M', 1868, 1420, 132000, 4, 7);
insert into utrka values (008, 'Ski Welt Cup Garmisch', TO_TIMESTAMP('04-01-2023 15:40', 'dd-MM-yyyy HH24:MI:SS'), 'M', 942, 735, 132000, 3, 8);
insert into utrka values (009, 'Snow Queen Trophy 2023', TO_TIMESTAMP('04-01-2023 12:30:00', 'dd-MM-yyyy HH24:MI:SS'), 'F', 950, 768, 132000, 3, 9);
insert into utrka values (010, 'Alpine Skiing Competitions', TO_TIMESTAMP('07-01-2023 10:30:00', 'dd-MM-yyyy HH24:MI:SS'), 'M', 1730, 1310, 132000, 4, 10);
insert into utrka values (011, '59. Zlata lisica', TO_TIMESTAMP('08-01-2023 09:30:00', 'dd-MM-yyyy HH24:MI:SS'), 'F', 1175, 855, 132000, 4, 11);
insert into utrka values (012, 'Alpine Skiing Competitions', TO_TIMESTAMP('15-01-2023 10:15:00', 'dd-MM-yyyy HH24:MI:SS'), 'M', 1475, 1281, 132000, 3, 12);
insert into utrka values (013, 'Alpine Skiing Competitions', TO_TIMESTAMP('14-01-2023 11:00:00', 'dd-MM-yyyy HH24:MI:SS'), 'F', 1835, 1355, 132000, 2, 13);
insert into utrka values (014, 'Hahnenkamm Races', TO_TIMESTAMP('20-01-2023 11:30:00', 'dd-MM-yyyy HH24:MI:SS'), 'M', 1665, 805, 333200, 1, 14);
insert into utrka values (015, 'Spindl World Cup 2023', TO_TIMESTAMP('29-01-2023 09:15:00', 'dd-MM-yyyy HH24:MI:SS'), 'F', 944, 757, 132000, 3, 15);
insert into utrka values (016, 'Coupe du Monde', TO_TIMESTAMP('04-02-2023 09:30:00', 'dd-MM-yyyy HH24:MI:SS'), 'M', 1169, 985, 132000, 3, 16);
insert into utrka values (017, 'Audi FIS Ski World Cup', TO_TIMESTAMP('22-01-2023 11:10:00', 'dd-MM-yyyy HH24:MI:SS'), 'F', 2160, 1560, 132000, 2, 17);
insert into utrka values (018, 'Aspen World Cup', TO_TIMESTAMP('05-03-2023 18:00:00', 'dd-MM-yyyy HH24:MI:SS'), 'M', 3058, 2484, 132000, 2, 18);
insert into utrka values (019, 'World Cup Kvitfjell', TO_TIMESTAMP('04-03-2023 11:00:00', 'dd-MM-yyyy HH24:MI:SS'), 'F', 890, 182, 132000, 1, 19);
insert into utrka values (020, 'World Cup Finals', TO_DATE('18-03-2023 10:30:00', 'dd-MM-yyyy HH24:MI:SS'), 'F', 2047, 1837, 132000, 3, 20);



-- SKIJAS
-- dalje unosimo podatke o skijasima
-- ukljucit cemo samo one koji su ostvarili barem jedan bod u ukupnom poretku (127 muskaraca i 132 zene)

-- MUSKARCI

insert into SKIJAS values (001, 'Marco', 'Odermatt', 'M', TO_DATE('08-10-1997', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (002, 'Aleksander', 'Aamodt Kilde', 'M', TO_DATE('21-09-1992', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (003, 'Henrik', 'Kristoffersen', 'M', TO_DATE('02-07-1994', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (004, 'Marco', 'Schwarz', 'M', TO_DATE('16-08-1995', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (005, 'Alexis', 'Pinturault', 'M', TO_DATE('20-03-1991', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (006, 'Loic', 'Meillard', 'M', TO_DATE('29-10-1996', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (007, 'Vincent', 'Kriechmyer', 'M', TO_DATE('01-10-1991', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (008, 'Lucas', 'Braathen', 'M', TO_DATE('19-04-2000', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (009, 'James', 'Crawford', 'M', TO_DATE('03-05-1997', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (010, 'Manuel', 'Feller', 'M', TO_DATE('13-10-1992', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (011, 'Zan', 'Kranjec', 'M', TO_DATE('15-11-1992', 'dd-MM-yyyy'), 'SLO');
insert into SKIJAS values (012, 'Ramon', 'Zenhaeusern', 'M', TO_DATE('04-05-1992', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (013, 'Gino', 'Caviezel', 'M', TO_DATE('23-06-1992', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (014, 'Mattia', 'Casse', 'M', TO_DATE('19-02-1990', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (015, 'Daniel', 'Hemetsberger', 'M', TO_DATE('23-05-1991', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (016, 'Andreas', 'Sander', 'M', TO_DATE('13-06-1989', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (017, 'Atle Lie', 'McGrath', 'M', TO_DATE('21-04-2000', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (018, 'Dominik', 'Paris', 'M', TO_DATE('14-04-1989', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (019, 'Daniel', 'Yule', 'M', TO_DATE('18-02-1993', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (020, 'Raphael', 'Haaser', 'M', TO_DATE('17-09-1997', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (021, 'Alexander', 'Steen Olsen', 'M', TO_DATE('18-08-2001', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (022, 'Johan', 'Clarey', 'M', TO_DATE('08-01-1981', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (023, 'Linus', 'Strasser', 'M', TO_DATE('06-11-1992', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (024, 'Filip', 'Zubcic', 'M', TO_DATE('27-01-1993', 'dd-MM-yyyy'), 'CRO');
insert into SKIJAS values (025, 'Clement', 'Noel', 'M', TO_DATE('03-05-1997', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (026, 'Niels', 'Hintermann', 'M', TO_DATE('05-05-1995', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (027, 'Justin', 'Murisier', 'M', TO_DATE('08-01-1992', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (028, 'Romed', 'Baumann', 'M', TO_DATE('14-01-1986', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (029, 'Stefan', 'Rogentin', 'M', TO_DATE('16-05-1994', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (030, 'Ryan', 'Cochran-Siegle', 'M', TO_DATE('27-03-1992', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (031, 'Alexander', 'Schmid', 'M', TO_DATE('09-06-1994', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (032, 'Timon', 'Haugan', 'M', TO_DATE('27-12-1996', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (033, 'Rasmus', 'Windingstad', 'M', TO_DATE('31-10-1993', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (034, 'Florian', 'Schieder', 'M', TO_DATE('26-12-1995', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (035, 'Matthias', 'Mayer', 'M', TO_DATE('09-06-1990', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (036, 'Stefan', 'Brennsteiner', 'M', TO_DATE('03-10-1991', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (037, 'Nils', 'Allegre', 'M', TO_DATE('02-01-1994', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (038, 'Adrian Smiseth', 'Sejersted', 'M', TO_DATE('16-07-1994', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (039, 'Alex', 'Vinatzer', 'M', TO_DATE('22-09-1999', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (040, 'Filippo', 'Della Vite', 'M', TO_DATE('04-10-2001', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (041, 'Beat', 'Feuz', 'M', TO_DATE('11-02-1987', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (042, 'Adrian', 'Pertl', 'M', TO_DATE('22-04-1996', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (043, 'Tommaso', 'Sala', 'M', TO_DATE('06-09-1995', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (044, 'Otmar', 'Striedinger', 'M', TO_DATE('14-04-1991', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (045, 'River', 'Radamus', 'M', TO_DATE('12-02-1998', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (046, 'Dave', 'Ryding', 'M', TO_DATE('05-12-1986', 'dd-MM-yyyy'), 'GBR');
insert into SKIJAS values (047, 'Travis', 'Ganong', 'M', TO_DATE('14-07-1988', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (048, 'Stefan', 'Babinsky', 'M', TO_DATE('02-04-1996', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (049, 'Fabio', 'Gstrein', 'M', TO_DATE('14-06-1997', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (050, 'Albert', 'Popov', 'M', TO_DATE('08-08-1997', 'dd-MM-yyyy'), 'BUL');
insert into SKIJAS values (051, 'Jeffrey', 'Read', 'M', TO_DATE('01-10-1997', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (052, 'Luca', 'De Aliprandini', 'M', TO_DATE('01-09-1990', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (053, 'Cameron', 'Alexander', 'M', TO_DATE('31-05-1997', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (054, 'AJ', 'Ginnis', 'M', TO_DATE('17-11-1994', 'dd-MM-yyyy'), 'GRE');
insert into SKIJAS values (055, 'Marc', 'Rochat', 'M', TO_DATE('18-12-1992', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (056, 'Erik', 'Read', 'M', TO_DATE('31-05-1991', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (057, 'Kristoffer', 'Jakobsen', 'M', TO_DATE('09-09-1994', 'dd-MM-yyyy'), 'SWE');
insert into SKIJAS values (058, 'Cyprien', 'Sarrazin', 'M', TO_DATE('13-10-1994', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (059, 'Sebastian', 'Foss-Solevaag', 'M', TO_DATE('13-07-1991', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (060, 'Josef', 'Ferstl', 'M', TO_DATE('29-12-1988', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (061, 'Brodie', 'Seger', 'M', TO_DATE('28-12-1995', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (062, 'Jared', 'Goldberg', 'M', TO_DATE('17-06-1991', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (063, 'Adrien', 'Theaux', 'M', TO_DATE('18-09-1984', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (064, 'Joan', 'Verdu', 'M', TO_DATE('23-05-1995', 'dd-MM-yyyy'), 'AND');
insert into SKIJAS values (065, 'Matteo', 'Marsaglia', 'M', TO_DATE('05-10-1985', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (066, 'Gilles', 'Roulin', 'M', TO_DATE('14-05-1994', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (067, 'Christof', 'Innerhofer', 'M', TO_DATE('17-12-1984', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (068, 'Thomas', 'Tumler', 'M', TO_DATE('05-11-1989', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (069, 'Sebastian', 'Holzmann', 'M', TO_DATE('22-03-1993', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (070, 'Miha', 'Hrobat', 'M', TO_DATE('03-02-1995', 'dd-MM-yyyy'), 'SLO');
insert into SKIJAS values (071, 'Sam', 'Maes', 'M', TO_DATE('07-06-1998', 'dd-MM-yyyy'), 'BEL');
insert into SKIJAS values (072, 'Guglielmo', 'Bosca', 'M', TO_DATE('05-06-1993', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (073, 'Daniel', 'Danklmaier', 'M', TO_DATE('24-04-1993', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (074, 'Thomas', 'Dressen', 'M', TO_DATE('24-04-1993', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (075, 'Stefano', 'Gross', 'M', TO_DATE('04-09-1986', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (076, 'Samuel', 'Kolega', 'M', TO_DATE('15-01-1999', 'dd-MM-yyyy'), 'CRO');
insert into SKIJAS values (077, 'Alexis', 'Monney', 'M', TO_DATE('08-01-2000', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (078, 'Giovanni', 'Borsotti', 'M', TO_DATE('18-12-1990', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (079, 'Erik', 'Arvidsson', 'M', TO_DATE('03-09-1996', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (080, 'Luca', 'Aerni', 'M', TO_DATE('27-03-1993', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (081, 'Tommy', 'Ford', 'M', TO_DATE('20-03-1989', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (082, 'Victor', 'Muffat-Jeandet', 'M', TO_DATE('05-03-1989', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (083, 'Michael', 'Matt', 'M', TO_DATE('13-05-1993', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (084, 'Martin', 'Cater', 'M', TO_DATE('20-12-1992', 'dd-MM-yyyy'), 'SLO');
insert into SKIJAS values (085, 'Patrick', 'Feurstein', 'M', TO_DATE('01-12-1996', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (086, 'Blaise', 'Giezendanner', 'M', TO_DATE('29-11-1991', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (087, 'Stefan', 'Hadalin', 'M', TO_DATE('06-06-1995', 'dd-MM-yyyy'), 'SLO');
insert into SKIJAS values (088, 'Broderick', 'Thompson', 'M', TO_DATE('19-04-1994', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (089, 'Bryce', 'Bennett', 'M', TO_DATE('14-07-1992', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (090, 'Sam', 'Morse', 'M', TO_DATE('27-05-1996', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (091, 'Urs', 'Kryenbuehl', 'M', TO_DATE('28-01-1994', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (092, 'Leif Kristian', 'Nestvold-Haugen', 'M', TO_DATE('29-11-1987', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (093, 'Hannes', 'Zingerle', 'M', TO_DATE('11-04-1995', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (094, 'Mathieu', 'Faivre', 'M', TO_DATE('18-01-1992', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (095, 'Luke', 'Winters', 'M', TO_DATE('02-04-1997', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (096, 'Riley', 'Seger', 'M', TO_DATE('21-04-1997', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (097, 'Johannes', 'Strolz', 'M', TO_DATE('12-09-1992', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (098, 'Simon', 'Maurberger', 'M', TO_DATE('20-02-1995', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (099, 'Henrik', 'Von Appen', 'M', TO_DATE('15-12-1994', 'dd-MM-yyyy'), 'CHI');
insert into SKIJAS values (100, 'Thibaut', 'Favrot', 'M', TO_DATE('22-12-1994', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (101, 'Trevor', 'Philp', 'M', TO_DATE('01-05-1992', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (102, 'Nico', 'Gauer', 'M', TO_DATE('09-04-1996', 'dd-MM-yyyy'), 'LIE');
insert into SKIJAS values (103, 'Joaquim', 'Salarich', 'M', TO_DATE('02-01-1994', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (104, 'Julian', 'Schuetter', 'M', TO_DATE('14-03-1998', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (105, 'Jett', 'Seymour', 'M', TO_DATE('5-11-1998', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (106, 'Livio', 'Simonet', 'M', TO_DATE('24-08-1998', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (107, 'Roland', 'Leitinger', 'M', TO_DATE('18-01-1992', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (108, 'Sandro', 'Simonet', 'M', TO_DATE('05-07-1995', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (109, 'Adam', 'Zampa', 'M', TO_DATE('13-09-1990', 'dd-MM-yyyy'), 'SVK');
insert into SKIJAS values (110, 'Giuliano', 'Razzoli', 'M', TO_DATE('18-12-1984', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (111, 'Marco', 'Pfiffner', 'M', TO_DATE('25-03-1994', 'dd-MM-yyyy'), 'LIE');
insert into SKIJAS values (112, 'Daniele', 'Sette', 'M', TO_DATE('28-02-1992', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (113, 'Fadri', 'Janutin', 'M', TO_DATE('16-01-2000', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (114, 'Stefan', 'Luitz', 'M', TO_DATE('26-03-1992', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (115, 'Anton', 'Grammel', 'M', TO_DATE('24-07-1998', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (116, 'Leo', 'Anguenot', 'M', TO_DATE('25-08-1998', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (117, 'Laurie', 'Taylor', 'M', TO_DATE('10-02-1996', 'dd-MM-yyyy'), 'GBR');
insert into SKIJAS values (118, 'Benjamin', 'Ritchie', 'M', TO_DATE('05-09-2000', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (119, 'Tanguy', 'Nef', 'M', TO_DATE('19-11-1996', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (120, 'Christopher', 'Neumayer', 'M', TO_DATE('29-04-1992', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (121, 'Fabian Wilkens', 'Solheim', 'M', TO_DATE('10-04-1996', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (122, 'Josua', 'Mettler', 'M', TO_DATE('30-06-1998', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (123, 'Lars', 'Roesti', 'M', TO_DATE('19-01-1998', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (124, 'David', 'Ketterer', 'M', TO_DATE('22-06-1993', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (125, 'Henrik', 'Roea', 'M', TO_DATE('05-08-1995', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (126, 'Samu', 'Torsti', 'M', TO_DATE('05-09-1991', 'dd-MM-yyyy'), 'FIN');
insert into SKIJAS values (127, 'Yohei', 'Koyama', 'M', TO_DATE('31-05-1998', 'dd-MM-yyyy'), 'JPN');



-- ZENE

insert into SKIJAS values (128, 'Mikaela', 'Shiffrin', 'F',TO_DATE('13-03-1995', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (129, 'Lara', 'Gut-Behrami', 'F',TO_DATE('27-04-1991', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (130, 'Federica', 'Brignone', 'F',TO_DATE('14-07-1990', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (131, 'Petra', 'Vlhova', 'F',TO_DATE('13-06-1995', 'dd-MM-yyyy'), 'SVK');
insert into SKIJAS values (132, 'Ragnhild', 'Mowinckel', 'F',TO_DATE('12-09-1992', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (133, 'Wendy', 'Holdener', 'F',TO_DATE('12-05-1993', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (134, 'Sofia', 'Goggia', 'F',TO_DATE('15-11-1992', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (135, 'Marta', 'Bassino', 'F',TO_DATE('27-02-1996', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (136, 'Elena', 'Curtoni', 'F',TO_DATE('03-02-1991', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (137, 'Sara', 'Hector', 'F',TO_DATE('04-09-1992', 'dd-MM-yyyy'), 'SWE');
insert into SKIJAS values (138, 'Ilka', 'Stuhec', 'F',TO_DATE('26-10-1990', 'dd-MM-yyyy'), 'SLO');
insert into SKIJAS values (139, 'Corinne', 'Suter', 'F',TO_DATE('28-09-1994', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (140, 'Cornelia', 'Huetter', 'F',TO_DATE('29-10-1992', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (141, 'Michelle', 'Gisin', 'F',TO_DATE('05-12-1993', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (142, 'Lena', 'Duerr', 'F',TO_DATE('04-08-1991', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (143, 'Tessa', 'Worley', 'F',TO_DATE('04-10-1989', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (144, 'Thea Louise', 'Stjernesund', 'F',TO_DATE('24-11-1996', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (145, 'Franziska', 'Gritsch', 'F',TO_DATE('15-03-1997', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (146, 'Mirjam', 'Puchner', 'F',TO_DATE('18-05-1992', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (147, 'Paula', 'Moltzan', 'F',TO_DATE('07-04-1994', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (148, 'Anna', 'Swenn Larsson', 'F',TO_DATE('18-06-1991', 'dd-MM-yyyy'), 'SWE');
insert into SKIJAS values (149, 'Jasmine', 'Flury', 'F',TO_DATE('16-09-1993', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (150, 'Ana', 'Bucik', 'F',TO_DATE('21-07-1993', 'dd-MM-yyyy'), 'SLO');
insert into SKIJAS values (151, 'Nina', 'Ortlieb', 'F',TO_DATE('02-04-1996', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (152, 'Joana', 'Haehlen', 'F',TO_DATE('23-01-1992', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (153, 'Valerie', 'Grenier', 'F',TO_DATE('30-10-1996', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (154, 'Ramona', 'Siebenhofer', 'F',TO_DATE('29-07-1991', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (155, 'Alice', 'Robinson', 'F',TO_DATE('01-12-2001', 'dd-MM-yyyy'), 'NZL');
insert into SKIJAS values (156, 'Mina Fuerst', 'Holtman', 'F',TO_DATE('17-07-1995', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (157, 'Leona', 'Popovic', 'F',TO_DATE('13-11-1997', 'dd-MM-yyyy'), 'CRO');
insert into SKIJAS values (158, 'Laura', 'Gauche', 'F',TO_DATE('04-03-1995', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (159, 'Stephanie', 'Venier', 'F',TO_DATE('19-12-1993', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (160, 'Maria Therese', 'Tviberg', 'F',TO_DATE('07-04-1994', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (161, 'Maryna', 'Gasienica-Daniel', 'F',TO_DATE('19-02-1994', 'dd-MM-yyyy'), 'POL');
insert into SKIJAS values (162, 'Hanna', 'Aronsson Elfman', 'F',TO_DATE('29-12-2002', 'dd-MM-yyyy'), 'SWE');
insert into SKIJAS values (163, 'Romane', 'Miradoli', 'F',TO_DATE('10-03-1994', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (164, 'Katharina', 'Truppe', 'F',TO_DATE('15-01-1996', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (165, 'Laurence', 'St-Germain', 'F',TO_DATE('30-05-1994', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (166, 'Emma', 'Aicher', 'F',TO_DATE('13-11-2003', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (167, 'Breezy', 'Johnson', 'F',TO_DATE('19-01-1996', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (168, 'Katharina', 'Liensberger', 'F',TO_DATE('01-04-1997', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (169, 'Priska', 'Nufer', 'F',TO_DATE('11-02-1992', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (170, 'Laura', 'Pirovano', 'F',TO_DATE('20-11-1997', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (171, 'Zrinka', 'Ljutic', 'F',TO_DATE('26-01-2004', 'dd-MM-yyyy'), 'CRO');
insert into SKIJAS values (172, 'Isabella', 'Wright', 'F',TO_DATE('10-02-1997', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (173, 'Camille', 'Rast', 'F',TO_DATE('09-07-1999', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (174, 'Ali', 'Nullmeyer', 'F',TO_DATE('21-08-1998', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (175, 'Martina', 'Dubovska', 'F',TO_DATE('27-02-1992', 'dd-MM-yyyy'), 'CZE');
insert into SKIJAS values (176, 'Tamara', 'Tippler', 'F',TO_DATE('09-04-1991', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (177, 'Nicole', 'Schmidhofer', 'F',TO_DATE('15-03-1989', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (178, 'Jessica', 'Hilzinger', 'F',TO_DATE('26-05-1997', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (179, 'Christina', 'Ager', 'F',TO_DATE('11-11-1995', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (180, 'Amelia', 'Smart', 'F',TO_DATE('08-01-1998', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (181, 'Nicol', 'Delago', 'F',TO_DATE('05-01-1996', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (182, 'Andrea', 'Ellenberger', 'F',TO_DATE('22-03-1993', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (183, 'Aline', 'Danioth', 'F',TO_DATE('12-03-1998', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (184, 'Marie-Michele', 'Gagnon', 'F',TO_DATE('25-04-1989', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (185, 'Katharina', 'Huber', 'F',TO_DATE('03-10-1995', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (186, 'Nastasia', 'Noens', 'F',TO_DATE('12-09-1988', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (187, 'Elena', 'Stoffel', 'F',TO_DATE('27-05-1996', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (188, 'Neja', 'Dvornik', 'F',TO_DATE('06-01-2001', 'dd-MM-yyyy'), 'SLO');
insert into SKIJAS values (189, 'Stephanie', 'Brunner', 'F',TO_DATE('20-02-1994', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (190, 'Julia', 'Scheib', 'F',TO_DATE('12-05-1998', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (191, 'Roberta', 'Melesi', 'F',TO_DATE('18-07-1996', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (192, 'Ariane', 'Raedler', 'F',TO_DATE('20-01-1995', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (193, 'Estelle', 'Alphand', 'F',TO_DATE('23-04-1995', 'dd-MM-yyyy'), 'SWE');
insert into SKIJAS values (194, 'Melanie', 'Meillard', 'F',TO_DATE('23-09-1998', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (195, 'Andrea', 'Filser', 'F',TO_DATE('25-03-1993', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (196, 'Stephanie', 'Jenal', 'F',TO_DATE('09-03-1998', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (197, 'Marta', 'Rossetti', 'F',TO_DATE('25-03-1999', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (198, 'Lara', 'Colturi', 'F',TO_DATE('15-11-2006', 'dd-MM-yyyy'), 'ALB');
insert into SKIJAS values (199, 'Lara', 'Della Mea', 'F',TO_DATE('10-01-1999', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (200, 'Delia', 'Durrer', 'F',TO_DATE('14-11-2002', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (201, 'Juliana', 'Suter', 'F',TO_DATE('23-04-1998', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (202, 'Moa', 'Bostroem Mussner', 'F',TO_DATE('02-08-2001', 'dd-MM-yyyy'), 'SWE');
insert into SKIJAS values (203, 'Keely', 'Cashman', 'F',TO_DATE('04-04-1999', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (204, 'Nadia', 'Delago', 'F',TO_DATE('12-11-1997', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (205, 'Clara', 'Direz', 'F',TO_DATE('05-04-1995', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (206, 'Nadine', 'Fest', 'F',TO_DATE('28-06-1998', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (207, 'Stefanie', 'Fleckenstein', 'F',TO_DATE('06-09-1997', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (208, 'Anita', 'Gulli', 'F',TO_DATE('26-06-1998', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (209, 'Ricarda', 'Haaser', 'F',TO_DATE('10-09-1993', 'dd-MM-yyyy'), 'AUT');
insert into SKIJAS values (210, 'Katie', 'Hensien', 'F',TO_DATE('01-12-1999', 'dd-MM-yyyy'), 'USA');
insert into SKIJAS values (211, 'Kajsa Vickhoff', 'Lie', 'F',TO_DATE('20-06-1998', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (212, 'Kristin', 'Lysdahl', 'F',TO_DATE('29-06-1996', 'dd-MM-yyyy'), 'NOR');
insert into SKIJAS values (213, 'Cande', 'Moreno', 'F',TO_DATE('30-10-2000', 'dd-MM-yyyy'), 'AND');
insert into SKIJAS values (214, 'Karloine', 'Pichler', 'F',TO_DATE('30-10-1994', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (215, 'Elisa', 'Platino', 'F',TO_DATE('08-01-1999', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (216, 'Britt', 'Richardson', 'F',TO_DATE('25-05-2003', 'dd-MM-yyyy'), 'CAN');
insert into SKIJAS values (217, 'Tina', 'Robnik', 'F',TO_DATE('30-07-1991', 'dd-MM-yyyy'), 'SLO');
insert into SKIJAS values (218, 'Karen', 'Smadja Clement', 'F',TO_DATE('29-01-1999', 'dd-MM-yyyy'), 'FRA');
insert into SKIJAS values (219, 'Vera', 'Tschurtschenthaler', 'F',TO_DATE('30-03-1997', 'dd-MM-yyyy'), 'ITA');
insert into SKIJAS values (220, 'Simone', 'Wild', 'F',TO_DATE('07-12-1993', 'dd-MM-yyyy'), 'SUI');
insert into SKIJAS values (221, 'Kira', 'Weidle', 'F',TO_DATE('24-02-1996', 'dd-MM-yyyy'), 'GER');
insert into SKIJAS values (222, 'Nina', 'O Brien', 'F', TO_DATE('29-11-1997', 'dd-MM-yyyy'), 'USA');




-- IMA SKIJE 
--u ovu tablicu biljezimo koji skijas/skijasica koristi koju marku skija



insert into IMA_SKIJE values (001, 4);
insert into IMA_SKIJE values (002, 2);
insert into IMA_SKIJE values (003, 7);
insert into IMA_SKIJE values (004, 2);
insert into IMA_SKIJE values (005, 1);
insert into IMA_SKIJE values (006, 3);
insert into IMA_SKIJE values (007, 1);
insert into IMA_SKIJE values (008, 2);
insert into IMA_SKIJE values (009, 1);
insert into IMA_SKIJE values (010, 2);
insert into IMA_SKIJE values (011, 3);
insert into IMA_SKIJE values (012, 3);
insert into IMA_SKIJE values (013, 8);
insert into IMA_SKIJE values (014, 3);
insert into IMA_SKIJE values (015, 5);
insert into IMA_SKIJE values (016, 2);
insert into IMA_SKIJE values (017, 1);
insert into IMA_SKIJE values (018, 9);
insert into IMA_SKIJE values (019, 5);
insert into IMA_SKIJE values (020, 5);
insert into IMA_SKIJE values (021, 3);
insert into IMA_SKIJE values (022, 1);
insert into IMA_SKIJE values (023, 3);
insert into IMA_SKIJE values (024, 2);
insert into IMA_SKIJE values (025, 8);
insert into IMA_SKIJE values (026, 2);
insert into IMA_sKIJE values (027, 1);
insert into IMA_SKIJE values (028, 10);
insert into IMA_SKIJE values (029, 5);
insert into IMA_SKIJE values (030, 1);
insert into IMA_SKIJE values (031, 1);
insert into IMA_SKIJE values (032, 7);
insert into IMA_SKIJE values (033, 4);
insert into IMA_SKIJE values (034, 2);
insert into IMA_SKIJE values (035, 1);
insert into IMA_SKIJE values (036, 5);
insert into IMA_SKIJE values (037, 10);
insert into IMA_SKIJE values (038, 2);
insert into IMA_SKIJE values (039, 2);
insert into iMA_SKIJE values (040, 3);
insert into IMA_SKIJE values (041, 1);
insert into IMA_SKIJE values (042, 6);
insert into IMA_SKIJE values (043, 8);
insert into IMA_SKIJE values (044, 10);
insert into IMA_SKIJE values (045, 3);
insert into IMA_SKIJE values (046, 5);
insert into IMA_SKIJE values (047, 1);
insert into IMA_SKIJE values (048, 1);
insert into IMA_SKIJE values (049, 2);
insert into ima_skije values (050, 1);
insert into IMA_SKIJE values (051, 2);
insert into IMA_SKIJE values (052, 10);
insert into IMA_SKIJE values (053, 3);
insert into IMA_SKIJE values (054, 5);
insert into IMA_SKIJE values (055, 9);
insert into IMA_SKIJE values (056, 2);
insert into IMA_SKIJE values (057, 5);
insert into IMA_SKIJE values (058, 3);
insert into IMA_SKIJE values (059, 6);
insert into IMA_skije values (060, 1);
insert into ima_SKIJE values (061, 2);
insert into IMA_SKIJE values (062, 3);
insert into IMA_SKIJE values (063, 1);
insert into IMA_SKIJE values (064, 1);
insert into IMA_SKIJE values (065, 5);
insert into IMA_Skije values (066, 1);
insert into ima_skije values (067, 3);
insert into ima_skije values (068, 4);
insert into ima_skije values (069, 6);
insert into ima_skije values (070, 2);
insert into ima_skije values (071, 6);
insert into ima_skije values (072, 1);
insert into ima_skije values (073, 2);
insert into ima_skije values (074, 3);
insert into ima_skije values (075, 6);
insert into ima_skije values (076, 3);
insert into ima_skije values (077, 4);
insert into ima_skije values (078, 3);
insert into ima_skije values (079, 1);
insert into ima_skije values (080, 5);
insert into ima_skije values (081, 1);
insert into ima_skije values (082, 10);
insert into ima_skije values (083, 11);
insert into ima_skije values (084, 10);
insert into ima_skije values (085, 1);
insert into ima_skije values (086, 2);
insert into ima_skije values (087, 3);
insert into ima_skije values (088, 1);
insert into ima_skije values (089, 5);
insert into ima_Skije values (090, 5);
insert into ima_skije values (091, 5);
insert into ima_skije values (092, 1);
insert into ima_skije values (093, 3);
insert into ima_skije values (094, 1);
insert into ima_skije values (095, 3);
insert into ima_skije values (096, 3);
insert into ima_skije values (097, 1);
insert into ima_skije values (098, 5);
insert into ima_skije values (099, 1);
insert into ima_skije values (100, 8);
insert into ima_skije values (101, 3);
insert into ima_skije values (102, 10);
insert into ima_skije values (103, 3);
insert into ima_skije values (104, 2);
insert into ima_skije values (105, 5);
insert into ima_skije values (106, 3);
insert into ima_skije values (107, 10);
insert into ima_skije values (108, 3);
insert into ima_skije values (109, 10);
insert into ima_skije values (110, 5);
insert into ima_skije values (111, 10);
insert into ima_skije values (112, 5);
insert into ima_skije values (113, 5);
insert into ima_skije values (114, 1);
insert into ima_skije values (115, 1);
insert into ima_skije values (116, 3);
insert into ima_skije values (117, 1);
insert into ima_skije values (118, 8);
insert into ima_Skije values (119, 2);
insert into ima_skije values (120, 2);
insert into ima_skije values (121, 1);
insert into ima_skije values (122, 8);
insert into ima_skije values (123, 4);
insert into ima_skije values (124, 2);
insert into ima_skije values (125, 9);
insert into ima_skije values (126, 1);
insert into ima_skije values (127, 1);
insert into ima_skije values (128, 2);
insert into ima_skije values (129, 1);
insert into ima_skije values (130, 3);
insert into ima_skije values (131, 3);
insert into ima_skije values (132, 1);
insert into ima_skije values (133, 1);
insert into ima_skije values (134, 2);
insert into ima_skije values (135, 10);
insert into ima_skije values (136, 1);
insert into ima_skije values (137, 1);
insert into ima_skije values (138, 12);
insert into ima_skije values (139, 1);
insert into ima_skije values (140, 1);
insert into ima_skije values (141, 10);
insert into ima_skije values (142, 1);
insert into ima_skije values (143, 3);
insert into ima_skije values (144, 3);
insert into ima_skije values (145, 1);
insert into ima_skije values (146, 2);
insert into ima_skije values (147, 3);
insert into ima_skije values (148, 1);
insert into ima_skije values (149, 12);
insert into ima_skije values (150, 10);
insert into ima_skije values (151, 1);
insert into ima_skije values (152, 2);
insert into ima_skije values (153, 3);
insert into ima_skije values (154, 5);
insert into ima_skije values (155, 10);
insert into ima_skije values (156, 2);
insert into ima_skije values (157, 6);
insert into ima_skije values (158, 1);
insert into ima_skije values (159, 1);
insert into ima_skije values (160, 1);
insert into ima_skije values (161, 2);
insert into ima_skije values (162, 3);
insert into ima_skije values (163, 8);
insert into ima_skije values (164, 6);
insert into ima_skije values (165, 3);
insert into ima_skije values (166, 1);
insert into ima_skije values (167, 2);
insert into ima_skije values (168, 3);
insert into Ima_skije values (169, 8);
insert into ima_skije values (170, 1);
insert into ima_skije values (171, 3);
insert into ima_skije values (172, 2);
insert into ima_skije values (173, 1);
insert into ima_skije values (174, 2);
insert into ima_skije values (175, 12);
insert into ima_skije values (176, 10);
insert into ima_skije values (177, 5);
insert into ima_skije values (178, 1);
insert into ima_skije values (179, 2);
insert into ima_skije values (180, 2);
insert into ima_skije values (181, 2);
insert into ima_Skije values (182, 9);
insert into ima_skije values (183, 4);
insert into ima_skije values (184, 1);
insert into ima_skije values (185, 5);
insert into ima_skije values (186, 10);
insert into ima_skije values (187, 8);
insert into ima_skije values (188, 5);
insert into ima_skije values (189, 2);
insert into ima_skije values (190, 3);
insert into ima_skije values (191, 8);
insert into ima_skije values (192, 1);
insert into ima_skije values (193, 1);
insert into ima_skije values (194, 3);
insert into ima_skije values (195, 6);
insert into ima_skije values (196, 2);
insert into ima_skije values (197, 1);
insert into ima_skije values (198, 11);
insert into ima_skije values (199, 5);
insert into ima_skije values (200, 1);
insert into ima_skije values (201, 2);
insert into ima_skije values (202, 3);
insert into ima_skije values (203, 3);
insert into ima_skije values (204, 2);
insert into ima_skije values (205, 8);
insert into ima_skije values (206, 10);
insert into ima_Skije values (207, 3);
insert into ima_skije values (208, 6);
insert into ima_skije values (209, 5);
insert into ima_skije values (210, 3);
insert into ima_skije values (211, 1);
insert into ima_skije values (212, 3);
insert into ima_skije values (213, 1);
insert into ima_skije values (214, 1);
insert into ima_skije values (215, 1);
insert into ima_Skije values (216, 8);
insert into ima_skije values (217, 6);
insert into ima_skije values (218, 1);
insert into ima_skije values (219, 3);
insert into ima_skije values (220, 5);
insert into ima_skije values (221, 3);
insert into ima_skije values (222, 3);



-- IMA_SPONZORA
-- u ovu tablicu unosimo podatke o tome koliko i koje sponzore ima koji skijas
-- napomenimo da svaki skijas ima barem jednog sponzora jer reprezentacije imaju svoje sponzore, a neki skijasi imaju i individualno svoje sponzore
-- radi jednostavnosti u ovoj tablici ce biti sadrzani samo oni skijasi koji imaju svoje individualne sponzore


insert into IMA_SPONZORA values (001, 10);
insert into IMA_SPONZORA values (001, 21);
insert into IMA_sponzora values (001, 7);
insert into ima_sponzora values (001, 15);
insert into ima_sponzora values (001, 22);
insert into ima_sponzora values (001, 9);

insert into ima_sponzora values (002, 5);
insert into ima_sponzora values (002, 11);
insert into ima_sponzora values (002, 23);
insert into ima_sponzora values (002, 19);
insert into ima_sponzora values (002, 15);

insert into ima_sponzora values (003, 11);
insert into ima_sponzora values (003, 19);
insert into ima_sponzora values (003, 24);
insert into ima_sponzora values (003, 25);

insert into ima_sponzora values (004, 7);
insert into ima_sponzora values (004, 25);
insert into ima_sponzora values (004, 6);
insert into ima_sponzora values (004, 24);

insert into ima_sponzora values (005, 15);
insert into ima_sponzora values (005, 10);
insert into ima_sponzora values (005, 14);
insert into ima_sponzora values (005, 26);
insert into ima_sponzora values (005, 7);

insert into ima_sponzora values (006, 26);
insert into ima_sponzora values (006, 25);
insert into ima_sponzora values (006, 10);
insert into ima_sponzora values (006, 9);
insert into ima_sponzora values (006, 21);

insert into ima_sponzora values (007, 20);
insert into ima_sponzora values (007, 7);
insert into ima_sponzora values (007, 24);

insert into ima_sponzora values (008, 11);
insert into ima_sponzora values (008, 10);
insert into ima_sponzora values (008, 5);
insert into ima_sponzora values (008, 25);
insert into ima_sponzora values (008, 19);
insert into ima_sponzora values (008, 24);

insert into ima_sponzora values (009, 11);
insert into ima_sponzora values (009, 25);
insert into ima_sponzora values (009, 24);

insert into ima_sponzora values (010, 15);
insert into ima_sponzora values (010, 7);

insert into ima_sponzora values (011, 17);
insert into ima_sponzora values (011, 27);
insert into ima_sponzora values (011, 25);

insert into ima_sponzora values (012, 15);

insert into ima_sponzora values (014, 12);
insert into ima_sponzora values (014, 7);

insert into ima_sponzora values (017, 11);
insert into ima_sponzora values (017, 15);

insert into ima_sponzora values (018, 10);
insert into ima_sponzora values (018, 15);
insert into ima_sponzora values (018, 28);

insert into ima_sponzora values (019, 9);
insert into ima_sponzora values (019, 26);
insert into ima_sponzora values (019, 15);

insert into ima_sponzora values (023, 28);

insert into ima_sponzora values (024, 16);
insert into ima_sponzora values (024, 17);
insert into ima_sponzora values (024, 18);

insert into ima_sponzora values (025, 26);
insert into ima_sponzora values (025, 10);

insert into ima_sponzora values (030, 25);
insert into ima_sponzora values (030, 4);

insert into ima_sponzora values (32, 11);
insert into ima_sponzora values (32, 24);

insert into ima_sponzora values (34, 26);
insert into ima_sponzora values (34, 15);

insert into ima_sponzora values (39, 21);
insert into ima_sponzora values (39, 15);
insert into ima_sponzora values (39, 10);

insert into ima_sponzora values (45, 29);

insert into ima_sponzora values (52, 9);
insert into ima_sponzora values (52, 23);
insert into ima_sponzora values (52, 15);

insert into ima_sponzora values (70, 15);
insert into ima_sponzora values (70, 26);
insert into ima_sponzora values (70, 27);

insert into ima_sponzora values (80, 9);
insert into ima_sponzora values (80, 24);

insert into ima_sponzora values (82, 14);
insert into ima_sponzora values (82, 28);

insert into ima_sponzora values (83, 13);
insert into ima_sponzora values (83, 15);

insert into ima_sponzora values (87, 26);
insert into ima_sponzora values (87, 27);
insert into ima_sponzora values (87, 17);

insert into ima_sponzora values (97, 7);
insert into ima_sponzora values (97, 28);
insert into ima_sponzora values (97, 15);

insert into ima_sponzora values (98, 12);
insert into ima_sponzora values (98, 7);
insert into ima_sponzora values (98, 24);

insert into ima_sponzora values (128, 1);
insert into ima_sponzora values (128, 2);
insert into ima_sponzora values (128, 3);
insert into ima_sponzora values (128, 4);
insert into ima_sponzora values (128, 5);
insert into ima_sponzora values (128, 25);
insert into ima_sponzora values (128, 21);
insert into ima_sponzora values (128, 15);

insert into ima_sponzora values (129, 15);
insert into ima_sponzora values (129, 25);
insert into ima_sponzora values (129, 7);
insert into ima_sponzora values (129, 9);

insert into ima_sponzora values (130, 1);
insert into ima_sponzora values (130, 12);
insert into ima_sponzora values (130, 25);
insert into ima_sponzora values (130, 15);

insert into ima_sponzora values (131, 1);
insert into ima_sponzora values (131, 8);
insert into ima_sponzora values (131, 7);
insert into ima_sponzora values (131, 6);

insert into ima_sponzora values (132, 15);
insert into ima_sponzora values (132, 19);
insert into ima_sponzora values (132, 11);

insert into ima_sponzora values (133, 15);
insert into ima_sponzora values (133, 7);
insert into ima_sponzora values (133, 9);

insert into ima_sponzora values (134, 10);
insert into ima_sponzora values (134, 12);
insert into ima_sponzora values (134, 7);

insert into ima_sponzora values (135, 9);
insert into ima_sponzora values (135, 12);
insert into ima_sponzora values (135, 15);

insert into ima_sponzora values (138, 25);
insert into ima_sponzora values (138, 24);

insert into ima_sponzora values (141, 9);
insert into ima_sponzora values (141, 22);
insert into ima_sponzora values (141, 15);
insert into ima_sponzora values (141, 23);

insert into ima_sponzora values (143, 7);
insert into ima_sponzora values (143, 26);
insert into ima_sponzora values (143, 25);
insert into ima_sponzora values (143, 15);

insert into ima_sponzora values (147, 15);
insert into ima_sponzora values (147, 22);

insert into ima_sponzora values (152, 9);
insert into ima_sponzora values (152, 28);
insert into ima_sponzora values (152, 7);

insert into ima_Sponzora values (155, 10);
insert into ima_sponzora values (155, 14);
insert into ima_sponzora values (155, 29);

insert into ima_sponzora values (157, 13);
insert into ima_sponzora values (157, 18);
insert into ima_sponzora values (157, 28);

insert into ima_sponzora values (163, 14);
insert into ima_sponzora values (163, 15);
insert into ima_sponzora values (163, 25);
insert into ima_sponzora values (163, 28);

insert into ima_sponzora values (166, 10);

insert into ima_sponzora values (171, 18);
insert into ima_sponzora values (171, 29);
insert into ima_sponzora values (171, 26);

insert into ima_sponzora values (176, 28);
insert into ima_sponzora values (176, 24);

insert into ima_sponzora values (183, 9);
insert into ima_sponzora values (183, 22);
insert into ima_sponzora values (183, 15);

insert into ima_sponzora values (188, 15);
insert into ima_sponzora values (188, 26);

insert into ima_sponzora values (194, 21);
insert into ima_sponzora values (194, 15);
insert into ima_sponzora values (194, 26);
insert into ima_sponzora values (195, 9);

insert into ima_sponzora values (198, 10);
insert into ima_sponzora values (198, 26);

insert into ima_sponzora values (209, 26);
insert into ima_sponzora values (209, 24);

insert into ima_sponzora values (220, 9);
insert into ima_sponzora values (220, 15);
insert into ima_sponzora values (220, 22);



-- REZULTAT 
-- u ovu tablicu cemo unjeti rezultate skijasa u utrkama koje smo ranije odabrali
-- napomena: vremena cemo unositi u sekundama kao decimalne brojeve (za vremena iznad 60 sekundi samo nastavimo bez minuta)

-- SOELDEN (M1, veleslalom)

insert into REZULTAT values (0101, 1, 59.88, 64.84, 124.72, 100, 50000, 001, 001);
insert into REZULTAT values (0102, 2, 60.57, 64.91, 125.48, 80, 22000, 011, 001);
insert into REZULTAT values (0103, 3, 60.83, 64.86, 125.69, 60, 11000, 003, 001);
insert into REZULTAT values (0104, 4, 60.29, 65.53, 125.82, 50, 7500, 008, 001);
insert into REZULTAT values (0105, 5, 61.36, 64.47, 125.83, 45, 5500, 033, 001);
insert into REZULTAT values (0106, 6, 62.26, 63.62, 125.88, 40, 4500, 081, 001);
insert into rezultat values (0107, 7, 60.69, 65.22, 125.91, 36, 3500, 006, 001);
insert into rezultat values (0108, 8, 61.21, 64.88, 126.09, 32, 2600, 031, 001);
insert into rezultat values (0109, 9, 62.43, 63.67, 126.10, 29, 2200, 087, 001);
insert into rezultat values (0110, 10, 61.70, 64.42, 126.12, 26, 2000, 100, 001);
insert into rezultat values (0111, 11, 62.12, 64.22, 126.34, 24, 1800, 082, 001);
insert into rezultat values (0112, 12, 61.16, 65.23, 126.39, 22, 1600, 024, 001);
insert into rezultat values (0113, 13, 61.39, 65.01, 126.40, 20, 1500, 004, 001);
insert into rezultat values (0114, 14, 62.32, 64.19, 126.51, 18, 1400, 092, 001);
insert into rezultat values (0115, 15, 62.52, 64.00, 126.52, 16, 1350, 101, 001);
insert into rezultat values (0116, 16, 60.77, 65.76, 126.53, 15, 1300, 010, 001);
insert into rezultat values (0117, 17, 61.37, 65.22, 126.59, 14, 1200, 056, 001);
insert into rezultat values (0118, 18, 60.85, 65.85, 126.70, 13, 1150, 017, 001);
insert into rezultat values (0119, 19, 61.68, 65.07, 126.75, 12, 1100, 021, 001);
insert into rezultat values (0120, 20, 60.90, 65.91, 126.81, 11, 1050, 005, 001);
insert into rezultat values (0121, 21, 61.68, 65.27, 126.85, 10, 1000, 013, 001);
insert into rezultat values (0122, 22, 61.53, 65.35, 126.88, 9, 950, 085, 001);
insert into rezultat values (0123, 23, 61.74, 65.27 , 127.01, 8, 900, 109, 001);
insert into rezultat values (0124, 24, 61.96, 65.12, 127.08, 7, 850, 094, 001);
insert into rezultat values (0125, 25, 62.49, 64.79, 127.28, 6, 800, 106, 001);
insert into rezultat values (0126, 26, 61.25, 66.36, 127.61, 5, 750, 045, 001);  
insert into rezultat values (0127, 27, 62.14, 66.70, 128.84, 4, 700, 007, 001);
insert into rezultat values (0128, 28, 62.10, 68.37, 130.47, 3, 650, 078, 001);
insert into rezultat values (0129, 0, 62.07, NULL, NULL, 0, 0, 002, 001);
insert into rezultat values (0130, 0, 61.94, NULL, NULL, 0, 0, 064, 001);



-- KILLINGTON (F1, veleslalom)

insert into rezultat values (0201, 1, 52.72, 51.36, 104.08, 100, 50000, 129, 002);
insert into rezultat values (0202, 2, 52.88, 51.27, 104.15, 80, 22000, 135, 002);
insert into rezultat values (0203, 3, 52.29, 51.99, 104.28, 60, 11000, 137, 002);
insert into rezultat values (0204, 4, 52.75, 51.79, 104.54, 50, 7500, 131, 002);
insert into rezultat values (0205, 5, 53.23, 51.40, 104.63, 45, 5500, 168, 002);
insert into rezultat values (0206, 6, 52.67, 51.79, 104.69, 40, 4500, 132, 002);
insert into rezultat values (0207, 7, 53.48, 51.44, 104.92, 36, 3500, 143, 002);
insert into rezultat values (0208, 8, 54.12, 50.86, 104.98, 32, 2600, 161, 002);
insert into rezultat values (0209, 9, 53.88, 51.15, 105.03, 29, 2200, 130, 002);
insert into rezultat values (0210, 10, 53.78, 51.44, 105.22, 26, 2000, 144, 002);
insert into rezultat values (0211, 11, 54.91, 50.42, 105.33, 24, 1800, 191, 002);
insert into rezultat values (0212, 12, 53.93, 51.53, 105.46, 22, 1600, 154, 002);
insert into rezultat values (0213, 13, 53.65, 51.83, 105.48, 20, 1500, 128, 002);
insert into rezultat values (0214, 14, 54.42, 51.10, 105.52, 18, 1400, 155, 002);
insert into rezultat values (0215, 15, 53.49, 52.12, 105.61, 16, 1350, 209, 002);
insert into rezultat values (0216, 16, 53.96, 51.89, 105.85, 15, 1300, 133, 002);
insert into rezultat values (0217, 17, 54.83, 51.13, 105.96, 14, 1200, 198, 002);
insert into rezultat values (0218, 18, 54.01, 52.01, 106.02, 13, 1150, 147, 002);
insert into rezultat values (0219, 19, 54.58, 51.63, 106.21, 12, 1100, 182, 002);
insert into rezultat values (0220, 20, 54.85, 51.55, 106.40, 11, 1050, 145, 002);
insert into rezultat values (0221, 21, 54.93, 51.48, 106.41, 10, 1000, 173, 002);
insert into rezultat values (0222, 22, 54.06, 52.47, 106.53, 9, 950, 164, 002);
insert into rezultat values (0223, 23, 54.75, 51.92, 106.67, 8, 900, 222, 002);
insert into rezultat values (0224, 24, 54.55, 52.16, 106.71, 7, 850, 185, 002);
insert into rezultat values (0225, 25, 54.05, 52.70, 106.75, 6, 800, 141, 002);
insert into rezultat values (0226, 26, 54.39, 52.44, 106.83, 5, 750, 193, 002);
insert into rezultat values (0227, 27, 54.74, 52.80, 107.54, 4, 700, 210, 002);
insert into rezultat values (0228, 28, 54.05, 54.26, 108.31, 3, 650, 220, 002);
insert into rezultat values (0229, 0, 53.52, NULL, NULL, 0, 0, 150, 002);
insert into rezultat values (0230, 0, 53.72, NULL, NULL, 0, 0, 205, 002);



-- BEAVER CREEK (M2, super G)

insert into rezultat values (0301, 1, 70.73, NULL, 70.73, 100, 50000, 002, 003);
insert into rezultat values (0302, 2, 70.93, NULL, 70.93, 80, 22000, 001, 003);
insert into rezultat values (0303, 3, 71.03, NULL, 71.03, 60, 11000, 005, 003);
insert into rezultat values (0304, 4, 71.28, NULL, 71.28, 50, 7500, 013, 003);
insert into rezultat values (0305, 5, 71.30, NULL, 71.30, 45, 5500, 017, 003);
insert into rezultat values (0306, 6, 71.47, NULL, 71.47, 40, 4500, 020, 003);
insert into rezultat values (0307, 7, 71.52, NULL, 71.52, 36, 3500, 008, 003);
insert into rezultat values (0308, 8, 71.53, NULL, 71.53, 32, 2600, 028, 003);
insert into rezultat values (0309, 9, 71.54, NULL, 71.54, 29, 2200, 007, 003);
insert into rezultat values (0310, 10, 71.76, NULL, 71.76, 26, 2000, 035, 003);
insert into rezultat values (0311, 11, 71.86, NULL, 71.86, 24, 1800, 009, 003);
insert into rezultat values (0312, 12, 71.91, NULL, 71.91, 22, 1550, 058, 003);
insert into rezultat values (0313, 12, 71.91, NULL, 71.91, 22, 1550, 016, 003);
insert into rezultat values (0314, 14, 72.05, NULL, 72.05, 18, 1400, 099, 003);
insert into rezultat values (0315, 15, 72.17, NULL, 72.17, 16, 1350, 029, 003);
insert into rezultat values (0316, 16, 72.24, NULL, 72.24, 15, 1300, 045, 003);
insert into rezultat values (0317, 17, 72.26, NULL, 72.26, 14, 1200, 027, 003);
insert into rezultat values (0318, 18, 72.31, NULL, 72.31, 13, 1150, 104, 003);
insert into rezultat values (0319, 19, 72.32, NULL, 72.32, 12, 1100, 014, 003);
insert into rezultat values (0320, 20, 72.38, NULL, 72.38, 11, 1050, 051, 003);
insert into rezultat values (0321, 21, 72.47, NULL, 72.47, 10, 1000, 048, 003);
insert into rezultat values (0322, 22, 72.54, NULL, 72.54, 9, 950, 084, 003);
insert into rezultat values (0323, 23, 72.55, NULL, 72.55, 8, 900, 037, 003);
insert into rezultat values (0324, 24, 72.56, NULL, 72.57, 7, 850, 004, 003);
insert into rezultat values (0325, 25, 72.59, NULL, 72.59, 6, 800, 041, 003);
insert into rezultat values (0326, 26, 72.61, NULL, 72.61, 5, 750, 044, 003);
insert into rezultat values (0327, 27, 72.66, NULL, 72.66, 4, 700, 101, 003);
insert into rezultat values (0328, 28, 72.67, NULL, 72.67, 3, 650, 088, 003);
insert into rezultat values (0329, 29, 72.68, NULL, 72.68, 2, 600,  015, 003);
insert into rezultat values (0330, 30, 72.72, NULL, 72.72, 1, 550, 072, 003);


-- LAKE LOUISE (F2, spust)

insert into rezultat values (0401, 1, 107.81, NULL, 107.81, 100, 50000, 134, 004);
insert into rezultat values (0402, 2, 107.85, NULL, 107.81, 80, 22000, 139, 004);
insert into rezultat values (0403, 3, 107.87, NULL, 107.87, 60, 11000, 140, 004);
insert into rezultat values (0404, 4, 108.16, NULL, 108.16, 50, 7500, 146, 004);
insert into rezultat values (0405, 5, 108.23, NULL, 108.23, 45, 5500, 138, 004);
insert into rezultat values (0406, 6, 108.76, NULL, 108.76, 40, 4500, 151, 004);
insert into rezultat values (0407, 7, 108.78, NULL, 108.78, 36, 3500, 221, 004);
insert into rezultat values (0408, 8, 108.85, NULL, 108.85, 32, 2600, 136, 004);
insert into rezultat values (0409, 9, 108.87, NULL, 108.87, 29, 2200, 152, 004);
insert into rezultat values (0410, 10, 108.99, NULL, 108.99, 26, 2000, 149, 004);
insert into rezultat values (0411, 11, 109.09, NULL, 109.09, 24, 1800, 163, 004);
insert into rezultat values (0412, 12, 109.24, NULL, 109.24, 22, 1600, 181, 004);
insert into rezultat values (0413, 13, 109.29, NULL, 109.29, 20, 1500, 172, 004);
insert into rezultat values (0414, 14, 109.43, NULL, 109.43, 18, 1400, 201, 004);
insert into rezultat values (0415, 15, 109.47, NULL, 109.47, 16, 1350, 192, 004);
insert into rezultat values (0416, 16, 109.58, NULL, 109.58, 15, 1250, 179, 004);
insert into rezultat values (0417, 16, 109.58, NULL, 109.58, 15, 1250, 167, 004);
insert into rezultat values (0418, 18, 109.68, NULL, 109.68, 13, 1150, 129, 004);
insert into rezultat values (0419, 19, 109.74, NULL, 109.74, 12, 1100, 177, 004);
insert into rezultat values (0420, 20, 109.84, NULL, 109.84, 11, 1050, 200, 004);
insert into rezultat values (0421, 21, 109.85, NULL, 109.85, 10, 1000, 135, 004);
insert into rezultat values (0422, 22, 110.01, NULL, 110.01, 9, 950, 141, 004);
insert into rezultat values (0423, 23, 110.13, NULL, 110.13, 8, 900, 170, 004);
insert into rezultat values (0424, 24, 110.20, NULL, 110.20, 7, 850, 184, 004);
insert into rezultat values (0425, 25, 110.28, NULL, 110.28, 6, 800, 132, 004);
insert into rezultat values (0426, 26, 110.32, NULL, 110.32, 5, 750, 158, 004);
insert into rezultat values (0427, 27, 110.37, NULL, 110.37, 4, 700, 204, 004);
insert into rezultat values (0428, 28, 110.46, NULL, 110.46, 3, 650, 154, 004);
insert into rezultat values (0429, 29, 110.66, NULL, 110.66, 2, 600,  169, 004);
insert into rezultat values (0430, 30, 110.71, NULL, 110.71, 1, 550, 211, 004);


-- VAL GARDENA (3M, spust)

insert into rezultat values (0501, 1, 122.35, NULL, 122.35, 100, 50000, 002, 005);
insert into rezultat values (0502, 2, 122.70, NULL, 122.70, 80, 22000, 022, 005);
insert into rezultat values (0503, 3, 122.77, NULL, 122.77, 60, 11000, 014, 005);
insert into rezultat values (0504, 4, 123.02, NULL, 123.02, 50, 7500, 063, 005);
insert into rezultat values (0505, 5, 123.04, NULL, 71.30, 45, 5500, 009, 005);
insert into rezultat values (0506, 6, 123.22, NULL, 123.22, 40, 4500, 058, 005);
insert into rezultat values (0507, 7, 123.27, NULL, 123.27, 36, 3050, 001, 005);
insert into rezultat values (0508, 7, 123.27, NULL, 123.27, 36, 3050, 047, 005);
insert into rezultat values (0509, 9, 123.40, NULL, 123.40, 29, 2200, 062, 005);
insert into rezultat values (0510, 10, 123.50, NULL, 123.50, 26, 2000, 038, 005);
insert into rezultat values (0511, 11, 123.53, NULL, 123.53, 24, 1800, 037, 005);
insert into rezultat values (0512, 12, 123.59, NULL, 123.59, 22, 1550, 044, 005);
insert into rezultat values (0513, 12, 123.59, NULL, 123.59, 22, 1550, 035, 005);
insert into rezultat values (0514, 14, 123.64, NULL, 123.64, 18, 1400, 091, 005);
insert into rezultat values (0515, 15, 123.80, NULL, 123.80, 16, 1350, 090, 005);
insert into rezultat values (0516, 16, 123.83, NULL, 123.83, 15, 1300, 088, 005);
insert into rezultat values (0517, 17, 123.87, NULL, 123.87, 14, 1200, 028, 005);
insert into rezultat values (0518, 18, 123.88, NULL, 123.88, 13, 1150, 041, 005);
insert into rezultat values (0519, 19, 123.90, NULL, 123.90, 12, 1100, 070, 005);
insert into rezultat values (0520, 20, 124.05, NULL, 124.05, 11, 1025, 123, 005);
insert into rezultat values (0521, 20, 124.05, NULL, 124.05, 11, 1025, 061, 005);
insert into rezultat values (0522, 22, 124.09, NULL, 124.09, 9, 950, 016, 005);
insert into rezultat values (0523, 23, 124.11, NULL, 124.11, 8, 900, 089, 005);
insert into rezultat values (0524, 24, 124.16, NULL, 124.16, 7, 850, 029, 005);
insert into rezultat values (0525, 25, 124.19, NULL, 124.19, 6, 800, 030, 005);
insert into rezultat values (0526, 26, 124.21, NULL, 124.21, 5, 750, 077, 005);
insert into rezultat values (0527, 27, 124.22, NULL, 124.22, 4, 700, 125, 005);
insert into rezultat values (0528, 28, 124.24, NULL, 124.24, 3, 650, 060, 005);
insert into rezultat values (0529, 29, 124.25, NULL, 124.25, 2, 575,  104, 005);
insert into rezultat values (0530, 29, 124.25, NULL, 124.25, 2, 575, 120, 005);



-- ST. MORITZ (3F, spust)

insert into rezultat values (0601, 1, 88.85, NULL, 88.85, 100, 50000, 134, 006);
insert into rezultat values (0602, 2, 89.28, NULL, 89.28, 80, 22000, 138, 006);
insert into rezultat values (0603, 3, 89.37, NULL, 879.37, 60, 11000, 221, 006);
insert into rezultat values (0604, 4, 89.46, NULL, 89.46, 50, 7500, 128, 006);
insert into rezultat values (0605, 5, 89.60, NULL, 89.60, 45, 5500, 140, 006);
insert into rezultat values (0606, 6, 89.66, NULL, 89.66, 40, 4500, 151, 006);
insert into rezultat values (0607, 7, 89.89, NULL, 89.89, 36, 3500, 146, 006);
insert into rezultat values (0608, 8, 90.01, NULL, 90.01, 32, 2600, 136, 006);
insert into rezultat values (0609, 9, 90.14, NULL, 90.14, 29, 2200, 152, 006);
insert into rezultat values (0610, 10, 90.17, NULL, 90.17, 26, 2000, 149, 006);
insert into rezultat values (0611, 11, 90.24, NULL, 90.24, 24, 1800, 172, 006);
insert into rezultat values (0612, 12, 90.30, NULL, 90.30, 22, 1600, 129, 006);
insert into rezultat values (0613, 13, 90.32, NULL, 90.32, 20, 1500, 176, 006);
insert into rezultat values (0614, 14, 90.34, NULL, 90.34, 18, 1400, 139, 006);
insert into rezultat values (0615, 15, 90.39, NULL, 90.39, 16, 1350, 141, 006);
insert into rezultat values (0616, 16, 90.41, NULL, 90.41, 15, 1300, 159, 006);
insert into rezultat values (0617, 17, 90.43, NULL, 90.43, 14, 1200, 170, 006);
insert into rezultat values (0618, 18, 90.44, NULL, 90.44, 13, 1125, 154, 006);
insert into rezultat values (0619, 18, 90.44, NULL, 90.44, 13, 1125, 132, 006);
insert into rezultat values (0620, 20, 90.55, NULL, 90.55, 11, 1050, 169, 006);
insert into rezultat values (0621, 21, 90.60, NULL, 90.60, 10, 1000, 179, 006);
insert into rezultat values (0622, 22, 90.67, NULL, 90.67, 9, 950, 158, 006);
insert into rezultat values (0623, 23, 90.71, NULL, 90.71, 8, 900, 166, 006);
insert into rezultat values (0624, 24, 90.74, NULL, 90.74, 7, 850, 211, 006);
insert into rezultat values (0625, 25, 90.76, NULL, 90.76, 6, 800, 167, 006);
insert into rezultat values (0626, 26, 90.80, NULL, 90.80, 5, 750, 204, 006);
insert into rezultat values (0627, 27, 90.82, NULL, 90.82, 4, 700, 184, 006);
insert into rezultat values (0628, 28, 90.88, NULL, 90.88, 3, 650, 181, 006);
insert into rezultat values (0629, 29, 90.91, NULL, 90.91, 2, 600,  163, 006);
insert into rezultat values (0630, 30, 90.95, NULL, 90.95, 1, 550, 192, 006);


-- ALTA BADIA (4M, veleslalom)

insert into REZULTAT values (0701, 1, 79.22, 77.13, 156.35, 100, 50000, 008, 007);
insert into REZULTAT values (0702, 2, 79.09, 77.28, 156.37, 80, 22000, 011, 007);
insert into REZULTAT values (0703, 3, 79.91, 76.54, 156.45, 60, 11000, 001, 007);
insert into REZULTAT values (0704, 4, 79.41, 77.61, 157.02, 50, 7500, 005, 007);
insert into REZULTAT values (0705, 5, 78.49, 78.55, 157.04, 45, 5500, 011, 007);
insert into REZULTAT values (0706, 6, 79.79, 77.31, 157.40, 40, 4500, 004, 007);
insert into rezultat values (0707, 7, 80.13, 77.02, 157.15, 36, 3500, 017, 007);
insert into rezultat values (0708, 8, 79.28, 77.98, 157.26, 32, 2600, 031, 007);
insert into rezultat values (0709, 9, 79.80, 77.76, 157.56, 29, 2200, 027, 007);
insert into rezultat values (0710, 10, 80.03, 77.60, 157.63, 26, 2000, 024, 007);
insert into rezultat values (0711, 11, 79.78, 77.95, 157.73, 24, 1800, 006, 007);
insert into rezultat values (0712, 12, 82.08, 75.74, 157.82, 22, 1600, 064, 007);
insert into rezultat values (0713, 13, 80.75, 77.15, 157.90, 20, 1450, 036, 007);
insert into rezultat values (0714, 13, 80.17, 77.73, 157.90, 20, 1450, 010, 007);
insert into rezultat values (0715, 15, 80.84, 77.33, 158.17, 16, 1350, 082, 007);
insert into rezultat values (0716, 16, 80.33, 78.03, 158.36, 15, 1300, 013, 007);
insert into rezultat values (0717, 17, 81.62, 77.07, 158.69, 14, 1200, 040, 007);
insert into rezultat values (0718, 18, 81.38, 77.47, 158.85, 13, 1150, 052, 007);
insert into rezultat values (0719, 19, 81.97, 76.94, 158.91, 12, 1100, 121, 007);
insert into rezultat values (0720, 20, 81.20, 77.96, 159.16, 11, 1050, 107, 007);
insert into rezultat values (0721, 21, 81.10, 78.24, 159.34, 10, 1000, 056, 007);
insert into rezultat values (0722, 22, 82.33, 77.08, 159.41, 9, 950, 106, 007);
insert into rezultat values (0723, 23, 80.94, 78.67, 159.61, 8, 900, 194, 007);
insert into rezultat values (0724, 24, 81.99, 78.07, 160.06, 7, 850, 092, 007);
insert into rezultat values (0725, 25, 81.99, 78.08, 160.07, 6, 800, 009, 007);
insert into rezultat values (0726, 26, 81.71, 78.92, 160.63, 5, 750, 085, 007);
insert into rezultat values (0727, 27, 82.32, 78.79, 161.11, 4, 700, 109, 007);
insert into rezultat values (0728, 28, 81.17, 80.00, 161.17, 3, 650, 114, 007);
insert into rezultat values (0729, 29, 81.67, 84.88, 166.55, 2, 600, 101, 007);
insert into rezultat values (0730, 0, 82.06, NULL, NULL, 0, 0, 033, 007);




-- GARMISCH (5M, slalom)

insert into REZULTAT values (0801, 1, 52.84, 55.53, 108.37, 100, 50000, 003, 008);
insert into REZULTAT values (0802, 2, 54.17, 55.42, 109.59, 80, 22000, 010, 008);
insert into REZULTAT values (0803, 3, 53.77, 55.42, 109.83, 60, 11000, 025, 008);
insert into REZULTAT values (0804, 4, 54.34, 55.74, 110.08, 50, 7500, 019, 008);
insert into REZULTAT values (0805, 5, 56.83, 53.33, 110.16, 45, 5500, 075, 008);
insert into REZULTAT values (0806, 6, 54.94, 55.26, 110.20, 40, 4500, 043, 008);
insert into rezultat values (0807, 7, 56.37, 53.68, 110.23, 36, 3500, 055, 008);
insert into rezultat values (0808, 8, 54.34, 55.99, 110.33, 32, 2600, 006, 008);
insert into rezultat values (0809, 9, 54.84, 55.51, 110.35, 29, 2200, 049, 008);
insert into rezultat values (0810, 10, 57.03, 53.37, 110.40, 26, 2000, 021, 008);
insert into rezultat values (0811, 11, 56.32, 54.09, 110.41, 24, 1800, 095, 008);
insert into rezultat values (0812, 12, 55.08, 55.38, 110.46, 22, 1600, 012, 008);
insert into rezultat values (0813, 13, 55.59, 55.02, 110.61, 20, 1500, 005, 008);
insert into rezultat values (0814, 14, 56.15, 54.47, 110.62, 18, 1400, 056, 008);
insert into rezultat values (0815, 15, 56.89, 53.78, 110.67, 16, 1350, 024, 008);
insert into rezultat values (0816, 16, 55.87, 54.86, 110.73, 15, 1250, 083, 008);
insert into rezultat values (0817, 16, 54.71, 56.02, 110.73, 15, 1250, 032, 008);
insert into rezultat values (0818, 18, 56.80, 53.99, 110.79, 13, 1150, 076, 008);
insert into rezultat values (0819, 19, 56.96, 53.87, 110.83, 12, 1100, 119, 008);
insert into rezultat values (0820, 20, 55.32, 55.62, 110.94, 11, 1050, 046, 008);
insert into rezultat values (0821, 21, 55.07, 55.89, 110.96, 10, 1000, 050, 008);
insert into rezultat values (0822, 22, 56.31, 55.10, 111.41, 9, 950, 080, 008);
insert into rezultat values (0823, 23, 55.39, 56.05, 111.44, 8, 900, 004, 008);
insert into rezultat values (0824, 24, 56.69, 55.15, 111.84, 7, 850, 103, 008);
insert into rezultat values (0825, 25, 56.95, 56.04, 112.99, 6, 800, 127, 008);
insert into rezultat values (0826, 26, 55.55, 68.47, 124.02, 5, 750, 082, 008);
insert into rezultat values (0827, 0, 55.40, NULL, NULL, 0, 0, 042, 008);
insert into rezultat values (0828, 0, 55.36, NULL, NULL, 0, 0, 057, 008);
insert into rezultat values (0829, 0, 54.73, NULL, NULL, 0, 0, 059, 008);
insert into rezultat values (0830, 0, 53.55, NULL, NULL, 0, 0, 023, 008);



-- SLJEME (4F, slalom)

insert into REZULTAT values (0901, 1, 48.93, 47.49, 96.42, 100, 50000, 128, 009);
insert into REZULTAT values (0902, 2, 49.48, 47.70, 97.18, 80, 22000, 131, 009);
insert into REZULTAT values (0903, 3, 49.16, 48.47, 97.47, 60, 11000, 148, 009);
insert into REZULTAT values (0904, 4, 50.21, 47.59, 97.80, 50, 7500, 133, 009);
insert into REZULTAT values (0905, 5, 50.49, 48.29, 98.78, 45, 5500, 150, 009);
insert into REZULTAT values (0906, 6, 50.67, 48.48, 99.15, 40, 4500, 173, 009);
insert into rezultat values (0907, 7, 51.12, 48.15, 99.27, 36, 3500, 145, 009);
insert into rezultat values (0908, 8, 51.58, 47.77, 99.35, 32, 2400, 180, 009);
insert into rezultat values (0909, 8, 51.49, 47.86, 99.35, 32, 2400, 160, 009);
insert into rezultat values (0910, 10, 50.80, 48.64, 99.44, 26, 2000, 157, 009);
insert into rezultat values (0911, 11, 51.91, 47.58, 99.49, 24, 1800, 166, 009);
insert into rezultat values (0912, 12, 51.17, 48.34, 99.51, 22, 1600, 186, 009);
insert into rezultat values (0913, 13, 52.24, 47.71, 99.95, 20, 1500, 144, 009);
insert into rezultat values (0914, 14, 52.84, 47.15, 99.99, 18, 1400, 165, 009);
insert into rezultat values (0915, 15, 52.02, 48.02, 100.04, 16, 1300, 187, 009);
insert into rezultat values (0916, 15, 52.20, 47.84, 100.04, 16, 1300, 178, 009);
insert into rezultat values (0917, 17, 52.60, 47.47, 100.07, 15, 1200, 188, 009);
insert into rezultat values (0918, 18, 52.28, 47.82, 100.10, 13, 1150, 194, 009);
insert into rezultat values (0919, 19, 52.73, 47.40, 100.13, 12, 1075, 197, 009);
insert into rezultat values (0920, 19, 51.44, 48.69, 100.13, 12, 1075, 212, 009);
insert into rezultat values (0921, 21, 50.96, 49.34, 90.30, 10, 1000, 141, 009);
insert into rezultat values (0922, 22, 52.04, 48.45, 100.49, 9, 950, 195, 009);
insert into rezultat values (0923, 23, 49.79, 57.34, 107.13, 0, 900, 168, 009);
insert into rezultat values (0924, 0, 52.52, NULL, NULL, 0, 0, 202, 009);
insert into rezultat values (0925, 0, 50.91, NULL, NULL, 0, 0, 183, 009);
insert into rezultat values (0926, 0, 51.75, NULL, NULL, 0, 0, 185, 009);
insert into rezultat values (0927, 0, 50.23, NULL, NULL, 0, 0, 162, 009);
insert into rezultat values (0928, 0, 50.93, NULL, NULL, 0, 0, 164, 009);
insert into rezultat values (0929, 0, 50.14, NULL, NULL, 0, 0, 174, 009);
insert into rezultat values (0930, 0, 52.08, NULL, NULL, 0, 0, 156, 009);



-- ADELBODEN (6M, veleslalom)


insert into REZULTAT values (1001, 1, 76.69, 73.99, 150.68, 100, 50000, 001, 010);
insert into REZULTAT values (1002, 2, 77.01, 74.40, 151.41, 80, 22000, 003, 010);
insert into REZULTAT values (1003, 3, 77.18, 75.16, 152.34, 60, 11000, 006, 010);
insert into REZULTAT values (1004, 4, 78.00, 74.95, 152.95, 50, 7500, 010, 010);
insert into REZULTAT values (1005, 5, 78.72, 74.36, 153.08, 45, 5500, 011, 010);
insert into REZULTAT values (1006, 6, 77.88, 75.30, 153.18, 40, 4500, 005, 010);
insert into rezultat values (1007, 7, 78.76, 74.48, 153.24, 36, 3500, 004, 010);
insert into rezultat values (1008, 8, 78.27, 75.18, 153.45, 32, 2600, 013, 010);
insert into rezultat values (1009, 9, 78.74, 74.93, 153.67, 29, 2200, 002, 010);
insert into rezultat values (1010, 10, 78.96, 75.05, 154.01, 26, 2000, 024, 010);
insert into rezultat values (1011, 11, 79.23, 74.81, 154.04, 24, 1800, 040, 010);
insert into rezultat values (1012, 12, 78.89, 75.41, 154.30, 22, 1600, 033, 010);
insert into rezultat values (1013, 13, 78.82, 75.53, 154.35, 20, 1500, 036, 010);
insert into rezultat values (1014, 14, 79.52, 75.07, 154.59, 18, 1400, 020, 010);
insert into rezultat values (1015, 15, 80.00, 74.63, 154.63, 16, 1350, 056, 010);
insert into rezultat values (1016, 16, 80.23, 74.65, 154.88, 15, 1300, 116, 010);
insert into rezultat values (1017, 17, 80.77, 74.25, 155.02, 14, 1200, 101, 010);
insert into rezultat values (1018, 18, 79.91, 75.13, 155.04, 13, 1150, 085, 010);
insert into rezultat values (1019, 19, 79.51, 75.75, 155.26, 12, 1100, 068, 010);
insert into rezultat values (1020, 20, 80.01, 75.36, 135.37, 11, 1050, 114, 010);
insert into rezultat values (1021, 21, 79.30, 76.21, 155.51, 10, 1000, 052, 010);
insert into rezultat values (1022, 22, 79.39, 76.23, 155.68, 9, 950, 045, 010);
insert into rezultat values (1023, 23, 80.58, 75.35, 155.93, 8, 900, 112, 010);
insert into rezultat values (1024, 24, 80.45, 75.52, 155.97, 7, 850, 126, 010);
insert into rezultat values (1025, 25, 80.71, 75.46, 156.17, 6, 800, 115, 010);
insert into rezultat values (1026, 26, 79.94, 76.41, 156.35, 5, 750, 113, 010);
insert into rezultat values (1027, 27, 80.85, 75.63, 156.63, 4, 700, 081, 010);
insert into rezultat values (1028, 0, 80.43, NULL, NULL, 0, 0, 093, 010);
insert into rezultat values (1029, 0, 78.47, NULL, NULL, 0, 0, 082, 010);
insert into rezultat values (1030, 0, 80.07, NULL, NULL, 0, 0, 094, 010);


-- KRANJSKA GORA (5F, veleslalom)


insert into REZULTAT values (1101, 1, 55.30, 57.23, 112.53, 100, 50000, 128, 011);
insert into REZULTAT values (1102, 2, 55.54, 57.76, 113.30, 80, 22000, 130, 011);
insert into REZULTAT values (1103, 3, 56.07, 57.43, 113.50, 60, 11000, 129, 011);
insert into REZULTAT values (1104, 4, 56.17, 57.43, 113.60, 50, 7500, 131, 011);
insert into REZULTAT values (1105, 5, 56.03, 57.66, 113.69, 45, 5500, 135, 011);
insert into REZULTAT values (1106, 6, 55.69, 58.58, 114.27, 40, 4500, 153, 011);
insert into rezultat values (1107, 7, 56.41, 57.95, 114.36, 36, 3500, 156, 011);
insert into rezultat values (1108, 8, 56.15, 58.32, 114.47, 32, 2600, 137, 011);
insert into rezultat values (1109, 9, 56.41, 58.19, 114.60, 29, 2200, 147, 011);
insert into rezultat values (1110, 10, 56.53, 58.39, 114.92, 26, 2000, 150, 011);
insert into rezultat values (1111, 11, 56.81, 58.17, 114.98, 24, 1800, 160, 011);
insert into rezultat values (1112, 12, 57.60, 57.47, 115.07, 22, 1600, 182, 011);
insert into rezultat values (1113, 13, 57.40, 57.73, 115.13, 20, 1500, 190, 011);
insert into rezultat values (1114, 14, 57.41, 57.85, 115.26, 18, 1400, 189, 011);
insert into rezultat values (1115, 15, 57.39, 58.00, 115.39, 16, 1350, 145, 011);
insert into rezultat values (1116, 16, 57.57, 57.88, 115.45, 15, 1300, 215, 011);
insert into rezultat values (1117, 17, 56.88, 58.58, 115.46, 14, 1200, 132, 011);
insert into rezultat values (1118, 18, 57.38, 58.18, 115.56, 13, 1150, 143, 011);
insert into rezultat values (1119, 19, 57.40, 58.17, 155.26, 12, 1100, 171, 011);
insert into rezultat values (1120, 20, 57.19, 58.42, 115.61, 11, 1050, 144, 011);
insert into rezultat values (1121, 21, 56.61, 59.20, 115.81, 10, 1000, 161, 011);
insert into rezultat values (1122, 22, 57.51, 58.44, 115.95, 9, 950, 173, 011);
insert into rezultat values (1123, 23, 57.61, 58.67, 116.28, 8, 900, 133, 011);
insert into rezultat values (1124, 24, 57.01, 59.32, 116.33, 7, 850, 216, 011);
insert into rezultat values (1125, 25, 57.34, 59.06, 116.40, 6, 800, 222, 011);
insert into rezultat values (1126, 26, 57.14, 59.55, 116.69, 5, 750, 193, 011);
insert into rezultat values (1127, 27, 57.27, 59.43, 116.70, 4, 700, 220, 011);
insert into rezultat values (1128, 28, 57.38, 59.49, 116.87, 3, 650, 141, 011);
insert into rezultat values (1129, 29, 57.48, 62.01, 119.49, 2, 600, 217, 011);
insert into rezultat values (1130, 0, 57.28, NULL, NULL, 0, 0, 155, 011);



-- WENGEN (7M, slalom)


insert into REZULTAT values (1201, 1, 57.58, 53.60, 111.18, 100, 50000, 003, 012);
insert into REZULTAT values (1202, 2, 57.13, 54.25, 111.38, 80, 22000, 006, 012);
insert into REZULTAT values (1203, 3, 57.61, 54.06, 111.67, 60, 11000, 008, 012);
insert into REZULTAT values (1204, 4, 57.81, 54.86, 112.67, 50, 7500, 023, 012);
insert into REZULTAT values (1205, 5, 58.17, 54.73, 112.90, 45, 5500, 017, 012);
insert into REZULTAT values (1206, 6, 58.99, 54.00, 112.99, 40, 4500, 025, 012);
insert into rezultat values (1207, 7, 59.56, 53.48, 113.04, 36, 3500, 004, 012);
insert into rezultat values (1208, 8, 58.74, 54.79, 113.53, 32, 2600, 043, 012);
insert into rezultat values (1209, 9, 59.34, 54.70, 114.04, 29, 2200, 012, 012);
insert into rezultat values (1210, 10, 60.34, 53.86, 114.19, 26, 2000, 039, 012);
insert into rezultat values (1211, 11, 59.09, 55.28, 114.37, 24, 1800, 019, 012);
insert into rezultat values (1212, 12, 60.09, 54.43, 114.52, 22, 1600, 097, 012);
insert into rezultat values (1213, 13, 60.31, 54.22, 114.53, 20, 1500, 005, 012);
insert into rezultat values (1214, 14, 62.30, 52.82, 115.12, 18, 1400, 021, 012);
insert into rezultat values (1215, 15, 61.40, 53.77, 115.17, 16, 1350, 083, 012);
insert into rezultat values (1216, 16, 62.40, 52.88, 115.28, 15, 1300, 108, 012);
insert into rezultat values (1217, 17, 61.32, 54.04, 115.36, 14, 1200, 055, 012);
insert into rezultat values (1218, 18, 62.22, 53.23, 115.45, 13, 1150, 069, 012);
insert into rezultat values (1219, 19, 61.43, 54.08, 115.51, 12, 1100, 024, 012);
insert into rezultat values (1220, 20, 62.04, 53.56, 115.60, 11, 1050, 098, 012);
insert into rezultat values (1221, 21, 60.48, 55.14, 115.62, 10, 1000, 046, 012);
insert into rezultat values (1222, 22, 61.18, 54.61, 115.79, 9, 950, 056, 012);
insert into rezultat values (1223, 23, 61.21, 54.68, 115.89, 8, 900, 042, 012);
insert into rezultat values (1224, 24, 61.86, 54.13, 115.99, 7, 850, 095, 012);
insert into rezultat values (1225, 25, 61.57, 54.67, 116.24, 6, 800, 080, 012);
insert into rezultat values (1226, 26, 61.92, 55.20, 117.12, 5, 750, 110, 012);
insert into rezultat values (1227, 27, 62.78, 54.64, 117.42, 4, 700, 087, 012);
insert into rezultat values (1228, 28, 62.23, 72.96, 125.19, 0, 650, 071, 012);
insert into rezultat values (1229, 0, 62.54, NULL, NULL, 0, 0, 118, 012);
insert into rezultat values (1230, 0, 60.79, NULL, NULL, 0, 0, 057, 012);


-- ST.ANTON (6F, super G)

insert into rezultat values (1301, 1, 60.21, NULL, 60.21, 100, 50000, 130, 013);
insert into rezultat values (1302, 2, 60.75, NULL, 60.75, 80, 22000, 152, 013);
insert into rezultat values (1303, 3, 60.87, NULL, 60.87, 60, 11000, 129, 013);
insert into rezultat values (1304, 4, 61.03, NULL, 61.03, 50, 7500, 143, 013);
insert into rezultat values (1305, 5, 61.10, NULL, 61.10, 45, 5500, 176, 013);
insert into rezultat values (1306, 6, 61.17, NULL, 61.17, 40, 4500, 132, 013);
insert into rezultat values (1307, 7, 61.18, NULL, 61.18, 36, 3500, 221, 013);
insert into rezultat values (1308, 8, 61.24, NULL, 61.24, 32, 2600, 135, 013);
insert into rezultat values (1309, 9, 61.28, NULL, 61.28, 29, 2200, 140, 013);
insert into rezultat values (1310, 10, 61.29, NULL, 61.29, 26, 2000, 158, 013);
insert into rezultat values (1311, 11, 61.53, NULL, 61.53, 24, 1800, 146, 013);
insert into rezultat values (1312, 12, 61.55, NULL, 61.55, 22, 1600, 155, 013);
insert into rezultat values (1313, 13, 61.56, NULL, 61.56, 20, 1500, 136, 013);
insert into rezultat values (1314, 14, 61.62, NULL, 61.62, 18, 1400, 201, 013);
insert into rezultat values (1315, 15, 61.71, NULL, 61.71, 16, 1350, 139, 013);
insert into rezultat values (1316, 16, 61.85, NULL, 61.85, 15, 1250, 191, 013);
insert into rezultat values (1317, 16, 61.85, NULL, 61.85, 15, 1250, 170, 013);
insert into rezultat values (1318, 18, 61.87, NULL, 61.87, 13, 1150, 214, 013);
insert into rezultat values (1319, 19, 61.93, NULL, 61.93, 12, 1100, 159, 013);
insert into rezultat values (1320, 20, 61.95, NULL, 61.95, 11, 1050, 149, 013);
insert into rezultat values (1321, 21, 61.99, NULL, 61.99, 10, 1000, 177, 013);
insert into rezultat values (1322, 22, 62.24, NULL, 62.24, 9, 950, 154, 013);
insert into rezultat values (1323, 23, 62.25, NULL, 62.25, 8, 900, 153, 013);
insert into rezultat values (1324, 24, 62.42, NULL, 62.42, 7, 850, 209, 013);
insert into rezultat values (1325, 25, 62.53, NULL, 62.53, 6, 800, 218, 013);
insert into rezultat values (1326, 26, 62.62, NULL, 62.62, 5, 750, 184, 013);
insert into rezultat values (1327, 27, 62.81, NULL, 62.81, 4, 700, 206, 013);
insert into rezultat values (1328, 28, 62.86, NULL, 62.86, 3, 650, 172, 013);
insert into rezultat values (1329, 29, 62.89, NULL, 62.89, 2, 600,  167, 013);
insert into rezultat values (1330, 30, 62.93, NULL, 62.93, 1, 550, 163, 013);



-- KITZBUEHL (8M, spust)


insert into rezultat values (1401, 1, 116.16, NULL, 116.16, 100, 98000, 007, 014);
insert into rezultat values (1402, 2, 116.39, NULL, 116.39, 80, 49000, 034, 014);
insert into rezultat values (1403, 3, 116.47, NULL, 116.47, 60, 24500, 026, 014);
insert into rezultat values (1404, 4, 116.51, NULL, 116.51, 50, 20580, 062, 014);
insert into rezultat values (1405, 5, 116.55, NULL, 116.55, 45, 15190, 038, 014);
insert into rezultat values (1406, 5, 116.55, NULL, 116.55, 45, 15190, 018, 014);
insert into rezultat values (1407, 7, 116.62, NULL, 116.62, 36, 11270, 070, 014);
insert into rezultat values (1408, 7, 116.62, NULL, 116.62, 36, 11270, 047, 014);
insert into rezultat values (1409, 9, 116.83, NULL, 116.83, 29, 9800, 088, 014);
insert into rezultat values (1410, 10, 116.90, NULL, 116.90, 26, 8820, 058, 014);
insert into rezultat values (1411, 11, 116.91, NULL, 116.91, 24, 5880, 077, 014);
insert into rezultat values (1412, 12, 116.95, NULL, 116.95, 22, 4900, 027, 014);
insert into rezultat values (1413, 13, 117.03, NULL, 117.03, 20, 4410, 074, 014);
insert into rezultat values (1414, 14, 117.04, NULL, 117.04, 18, 3920, 044, 014);
insert into rezultat values (1415, 15, 117.10, NULL, 117.10, 16, 3626, 016, 014);
insert into rezultat values (1416, 16, 117.13, NULL, 117.13, 15, 3332, 002, 014);
insert into rezultat values (1417, 17, 117.19, NULL, 117.19, 14, 3038, 014, 014);
insert into rezultat values (1418, 18, 117.22, NULL, 117.22, 13, 2744, 022, 014);
insert into rezultat values (1419, 19, 117.28, NULL, 117.28, 12, 2450, 053, 014);
insert into rezultat values (1420, 20, 117.33, NULL, 117.33, 11, 2156, 122, 014);
insert into rezultat values (1421, 21, 117.34, NULL, 117.34, 10, 1960, 079, 014);
insert into rezultat values (1422, 22, 117.40, NULL, 117.40, 9, 1911, 067, 014);
insert into rezultat values (1423, 23, 117.44, NULL, 117.44, 8, 1862, 037, 014);
insert into rezultat values (1424, 24, 117.46, NULL, 117.46, 7, 1813, 084, 014);
insert into rezultat values (1425, 25, 117.50, NULL, 117.50, 6, 1764, 061, 014);
insert into rezultat values (1426, 26, 117.51, NULL, 117.51, 5, 1715, 099, 014);
insert into rezultat values (1427, 27, 117.53, NULL, 117.53, 4, 1666, 111, 014);
insert into rezultat values (1428, 28, 117.58, NULL, 117.58, 3, 1617, 041, 014);
insert into rezultat values (1429, 29, 117.61, NULL, 117.61, 2, 1568,  089, 014);
insert into rezultat values (1430, 30, 117.70, NULL, 117.70, 1, 1519, 086, 014);


-- SPINDLERZV MLYN (7F, slalom)

insert into REZULTAT values (1501, 1, 45.33, 45.58, 90.91, 100, 50000, 142, 015);
insert into REZULTAT values (1502, 2, 44.66, 46.31, 90.97, 80, 22000, 128, 015);
insert into REZULTAT values (1503, 3, 45.51, 45.89, 91.40, 60, 11000, 171, 015);
insert into REZULTAT values (1504, 4, 45.69, 46.05, 91.74, 50, 7500, 148, 015);
insert into REZULTAT values (1505, 5, 45.89, 45.86, 91.75, 45, 5500, 157, 015);
insert into REZULTAT values (1506, 6, 46.93, 45.53, 92.46, 40, 4500, 145, 015);
insert into rezultat values (1507, 7, 46.41, 46.12, 92.67, 36, 3500, 165, 015);
insert into rezultat values (1508, 8, 46.35, 46.32, 92.67, 32, 2600, 147, 015);
insert into rezultat values (1509, 9, 46.55, 46.25, 92.80, 29, 2200, 141, 015);
insert into rezultat values (1510, 10, 47.28, 45.68, 92.96, 26, 2000, 160, 015);
insert into rezultat values (1511, 11, 46.71, 46.35, 93.06, 24, 1800, 185, 015);
insert into rezultat values (1512, 12, 46.85, 46.24, 93.09, 22, 1600, 137, 015);
insert into rezultat values (1513, 13, 46.20, 46.95, 93.15, 20, 1500, 131, 015);
insert into rezultat values (1514, 14, 46.91, 46.28, 93.19, 18, 1400, 166, 015);
insert into rezultat values (1515, 15, 46.26, 47.09, 93.32, 16, 1325, 208, 015);
insert into rezultat values (1516, 15, 47.23, 46.09, 93.32, 16, 1325, 164, 015);
insert into rezultat values (1517, 17, 46.82, 46.51, 93.33, 14, 1200, 197, 015);
insert into rezultat values (1518, 18, 46.79, 46.59, 93.38, 13, 1150, 175, 015);
insert into rezultat values (1519, 19, 47.46, 46.01, 93.47, 12, 1100, 199, 015);
insert into rezultat values (1520, 20, 47.41, 46.07, 93.48, 11, 1050, 180, 015);
insert into rezultat values (1521, 21, 46.86, 46.63, 93.49, 10, 1000, 178, 015);
insert into rezultat values (1522, 22, 46.34, 47.18, 93.52, 9, 950, 150, 015);
insert into rezultat values (1523, 23, 46.61, 46.94, 93.55, 8, 900, 173, 015);
insert into rezultat values (1524, 24, 46.82, 46.87, 93.69, 7, 850, 194, 015);
insert into rezultat values (1525, 25, 47.38, 46.32, 93.70, 6, 800, 187, 015);
insert into rezultat values (1526, 26, 47.13, 46.59, 93.72, 5, 750, 168, 015);
insert into rezultat values (1527, 27, 46.98, 46.78, 93.76, 4, 700, 156, 015);
insert into rezultat values (1528, 28, 47.28, 46.51, 93.79, 3, 650, 183, 015);
insert into rezultat values (1529, 29, 47.58, 46.83, 94.41, 2, 600, 195, 015);
insert into rezultat values (1530, 30, 47.50, 47.43, 94.93, 1, 550, 219, 015);


-- CHAMONIX (M9, slalom)


insert into REZULTAT values (1601, 1, 50.43, 52.51, 102.94, 100, 50000, 012, 016);
insert into REZULTAT values (1602, 2, 51.81, 52.15, 103.96, 80, 22000, 054, 016);
insert into REZULTAT values (1603, 3, 50.45, 53.55, 104.00, 60, 11000, 019, 016);
insert into REZULTAT values (1604, 4, 50.89, 53.43, 104.32, 50, 7500, 017, 016);
insert into REZULTAT values (1605, 5, 50.86, 53.48, 104.34, 45, 5500, 059, 016);
insert into REZULTAT values (1606, 6, 51.16, 53.25, 104.41, 40, 4500, 023, 016);
insert into rezultat values (1607, 7, 51.38, 53.21, 104.59, 36, 3500, 105, 016);
insert into rezultat values (1608, 8, 51.39, 53.32, 104.71, 32, 2600, 039, 016);
insert into rezultat values (1609, 9, 51.67, 53.10, 104.77, 29, 2100, 076, 016);
insert into rezultat values (1610, 9, 51.82, 52.95, 104.77, 29, 2100, 021, 016);
insert into rezultat values (1611, 11, 51.58, 53.36, 104.94, 24, 1800, 043, 016);
insert into rezultat values (1612, 12, 51.54, 53.44, 104.98, 22, 1600, 095, 016);
insert into rezultat values (1613, 13, 51.91, 53.19, 105.10, 20, 1500, 049, 016);
insert into rezultat values (1614, 14, 51.91, 53.87, 105.28, 18, 1350, 024, 016);
insert into rezultat values (1615, 14, 51.93, 53.35, 105.28, 18, 1350, 010, 016);
insert into rezultat values (1616, 16, 51.43, 53.87, 105.30, 15, 1300, 080, 016);
insert into rezultat values (1617, 17, 51.51, 53.81, 105.32, 14, 1200, 055, 016);
insert into rezultat values (1618, 18, 51.78, 53.77, 105.55, 13, 1150, 071, 016);
insert into rezultat values (1619, 19, 51.88, 53.70, 105.58, 12, 1100, 098, 016);
insert into rezultat values (1620, 20, 51.67, 53.94, 105.61, 11, 1050, 032, 016);
insert into rezultat values (1621, 21, 51.69, 54.06, 105.75, 10, 1000, 042, 016);
insert into rezultat values (1622, 22, 51.82, 54.13, 105.95, 9, 950, 124, 016);
insert into rezultat values (1623, 23, 51.95, 54.07, 106.02, 8, 900, 117, 016);
insert into rezultat values (1624, 0, 51.33, NULL, NULL, 0, 0, 031, 016);
insert into rezultat values (1625, 0, 51.93, NULL, NULL, 0, 0, 097, 016);
insert into rezultat values (1626, 0, 51.08, NULL, NULL, 0, 0, 050, 016);
insert into rezultat values (1627, 0, 51.26, NULL, NULL, 0, 0, 046, 016);
insert into rezultat values (1628, 0, 50.68, NULL, NULL, 0, 0, 003, 016);
insert into rezultat values (1629, 0, 51.57, NULL, NULL, 0, 0, 006, 016);
insert into rezultat values (1630, 0, 50.28, NULL, NULL, 0, 0, 025, 016);


-- CORTINA (8F, super G)


insert into rezultat values (1701, 1, 83.22, NULL, 83.22, 100, 50000, 132, 017);
insert into rezultat values (1702, 2, 83.52, NULL, 83.52, 80, 22000, 140, 017);
insert into rezultat values (1703, 3, 83.69, NULL, 83.69, 60, 11000, 135, 017);
insert into rezultat values (1704, 4, 83.72, NULL, 83.72, 50, 7500, 129, 017);
insert into rezultat values (1705, 5, 83.75, NULL, 83.75, 45, 5500, 163, 017);
insert into rezultat values (1706, 6, 83.78, NULL, 83.78, 40, 4500, 136, 017);
insert into rezultat values (1707, 7, 83.84, NULL, 83.84, 36, 3500, 128, 017);
insert into rezultat values (1708, 8, 83.86, NULL, 83.86, 32, 2600, 146, 017);
insert into rezultat values (1709, 9, 84.04, NULL, 84.04, 29, 2200, 221, 017);
insert into rezultat values (1710, 10, 84.05, NULL, 84.05, 26, 2000, 141, 017);
insert into rezultat values (1711, 11, 84.06, NULL, 84.06, 24, 1800, 130, 017);
insert into rezultat values (1712, 12, 84.15, NULL, 84.15, 22, 1600, 152, 017);
insert into rezultat values (1713, 13, 84.18, NULL, 84.18, 20, 1500, 138, 017);
insert into rezultat values (1714, 14, 84.28, NULL, 84.28, 18, 1375, 133, 017);
insert into rezultat values (1715, 14, 84.28, NULL, 84.28, 18, 1375, 154, 017);
insert into rezultat values (1716, 16, 84.38, NULL, 84.38, 15, 1300, 158, 017);
insert into rezultat values (1717, 17, 84.40, NULL, 84.40, 14, 1200, 177, 017);
insert into rezultat values (1718, 18, 84.55, NULL, 84.55, 13, 1150, 211, 017);
insert into rezultat values (1719, 19, 84.57, NULL, 84.57, 12, 1100, 214, 017);
insert into rezultat values (1720, 20, 84.63, NULL, 84.63, 11, 1050, 143, 017);
insert into rezultat values (1721, 21, 84.77, NULL, 84.77, 10, 1000, 159, 017);
insert into rezultat values (1722, 22, 84.79, NULL, 84.79, 9, 950, 155, 017);
insert into rezultat values (1723, 23, 84.85, NULL, 84.85, 8, 900, 153, 017);
insert into rezultat values (1724, 24, 84.93, NULL, 84.93, 7, 850, 176, 017);
insert into rezultat values (1725, 25, 84.95, NULL, 84.95, 6, 800, 169, 017);
insert into rezultat values (1726, 26, 85.11, NULL, 85.11, 5, 750, 196, 017);
insert into rezultat values (1727, 27, 85.34, NULL, 85.34, 4, 675, 181, 017);
insert into rezultat values (1728, 27, 85.34, NULL, 85.34, 4, 675, 191, 017);
insert into rezultat values (1729, 29, 85.40, NULL, 85.40, 2, 600, 167, 017);
insert into rezultat values (1730, 30, 85.42, NULL, 85.42, 1, 550, 209, 017);


-- ASPEN (10M, super g)

insert into rezultat values (1801, 1, 66.80, NULL, 66.80, 100, 50000, 001, 018);
insert into rezultat values (1802, 2, 66.85, NULL, 66.85, 80, 22000, 016, 018);
insert into rezultat values (1803, 3, 67.14, NULL, 67.14, 60, 11000, 002, 018);
insert into rezultat values (1804, 4, 67.27, NULL, 67.27, 50, 7500, 048, 018);
insert into rezultat values (1805, 5, 67.31, NULL, 67.31, 45, 5500, 006, 018);
insert into rezultat values (1806, 6, 67.45, NULL, 67.45, 40, 4500, 102, 018);
insert into rezultat values (1807, 7, 67.50, NULL, 67.50, 36, 3500, 007, 018);
insert into rezultat values (1808, 8, 67.55, NULL, 67.55, 32, 2600, 027, 018);
insert into rezultat values (1809, 9, 67.56, NULL, 67.56, 29, 2200, 037, 018);
insert into rezultat values (1810, 10, 67.58, NULL, 67.58, 26, 2000, 096, 018);
insert into rezultat values (1811, 11, 67.61, NULL, 67.61, 24, 1675, 005, 018);
insert into rezultat values (1812, 11, 67.61, NULL, 67.61, 24, 1675, 009, 018);
insert into rezultat values (1813, 13, 67.75, NULL, 67.75, 20, 1500, 028, 018);
insert into rezultat values (1814, 14, 67.76, NULL, 67.76, 18, 1350, 079, 018);
insert into rezultat values (1815, 14, 67.76, NULL, 67.76, 18, 1350, 062, 018);
insert into rezultat values (1816, 14, 67.76, NULL, 67.76, 18, 1350, 013, 018);
insert into rezultat values (1817, 17, 67.93, NULL, 67.93, 14, 1200, 026, 018);
insert into rezultat values (1818, 18, 67.96, NULL, 67.96, 13, 1150, 030, 018);
insert into rezultat values (1819, 19, 68.00, NULL, 68.00, 12, 1100, 014, 018);
insert into rezultat values (1820, 20, 68.01, NULL, 68.01, 11, 1050, 065, 018);
insert into rezultat values (1821, 21, 68.03, NULL, 68.03, 10, 1000, 051, 018);
insert into rezultat values (1822, 22, 68.05, NULL, 68.05, 9, 950, 066, 018);
insert into rezultat values (1823, 23, 68.09, NULL, 68.09, 8, 900, 067, 018);
insert into rezultat values (1824, 24, 68.12, NULL, 68.12, 7, 850, 029, 018);
insert into rezultat values (1825, 25, 68.22, NULL, 68.22, 6, 775, 099, 018);
insert into rezultat values (1826, 25, 68.22, NULL, 68.22, 6, 775, 072, 018);
insert into rezultat values (1827, 27, 68.36, NULL, 68.36, 4, 700, 078, 018);
insert into rezultat values (1828, 28, 68.42, NULL, 68.42, 3, 650, 088, 018);
insert into rezultat values (1829, 29, 68.53, NULL, 68.53, 2, 575,  073, 018);
insert into rezultat values (1830, 29, 68.53, NULL, 68.53, 2, 575, 086, 018);




-- KVITFJELL (9F, super g)

insert into rezultat values (1901, 1, 92.36, NULL, 92.36, 100, 50000, 211, 019);
insert into rezultat values (1902, 2, 92.65, NULL, 92.65, 80, 22000, 134, 019);
insert into rezultat values (1903, 3, 92.77, NULL, 92.77, 60, 11000, 139, 019);
insert into rezultat values (1904, 4, 92.97, NULL, 92.97, 50, 7500, 138, 019);
insert into rezultat values (1905, 5, 93.15, NULL, 93.15, 45, 5000, 154, 019);
insert into rezultat values (1906, 5, 93.15, NULL, 93.15, 45, 5000, 128, 019);
insert into rezultat values (1907, 7, 93.21, NULL, 93.21, 36, 3500, 130, 019);
insert into rezultat values (1908, 8, 93.23, NULL, 93.23, 32, 2600, 167, 019);
insert into rezultat values (1909, 9, 93.25, NULL, 93.25, 29, 2200, 151, 019);
insert into rezultat values (1910, 10, 93.31, NULL, 93.31, 26, 2000, 169, 019);
insert into rezultat values (1911, 11, 93.34, NULL, 93.34, 24, 1800, 146, 019);
insert into rezultat values (1912, 12, 93.36, NULL, 93.36, 22, 1600, 172, 019);
insert into rezultat values (1913, 13, 93.49, NULL, 93.49, 20, 1500, 136, 019);
insert into rezultat values (1914, 14, 93.57, NULL, 93.57, 18, 1400, 152, 019);
insert into rezultat values (1915, 15, 93.63, NULL, 93.63, 16, 1350, 170, 019);
insert into rezultat values (1916, 16, 93.75, NULL, 93.75, 15, 1300, 159, 019);
insert into rezultat values (1917, 17, 93.92, NULL, 93.92, 14, 1200, 149, 019);
insert into rezultat values (1918, 18, 93.95, NULL, 93.95, 13, 1150, 132, 019);
insert into rezultat values (1919, 19, 94.00, NULL, 94.00, 12, 1100, 207, 019);
insert into rezultat values (1920, 20, 94.02, NULL, 94.02, 11, 1050, 179, 019);
insert into rezultat values (1921, 21, 94.05, NULL, 94.05, 10, 1000, 129, 019);
insert into rezultat values (1922, 22, 94.18, NULL, 94.18, 9, 950, 155, 019);
insert into rezultat values (1923, 23, 94.19, NULL, 94.19, 8, 900, 166, 019);
insert into rezultat values (1924, 24, 94.33, NULL, 94.33, 7, 850, 200, 019);
insert into rezultat values (1925, 25, 94.36, NULL, 94.36, 6, 800, 213, 019);
insert into rezultat values (1926, 26, 94.39, NULL, 94.39, 5, 750, 181, 019);
insert into rezultat values (1927, 27, 94.47, NULL, 94.47, 4, 700, 196, 019);
insert into rezultat values (1928, 28, 94.72, NULL, 94.72, 3, 650, 145, 019);
insert into rezultat values (1929, 29, 94.76, NULL, 94.79, 2, 575,  203, 019);
insert into rezultat values (1930, 29, 94.76, NULL, 94.79, 2, 575, 141, 019);


-- SOLDEU (10F, slalom), ovdje ima manje vrijednosti jer je to utrka sa zavrsnice svjetskog kupa pa samo najboljih 25 + juniorski prvak u toj disciplini ima pravo nastupa u utci...


insert into REZULTAT values (2001, 1, 54.28, 57.21, 111.38, 100, 50000, 131, 020);
insert into REZULTAT values (2002, 2, 54.60, 57.21, 111.81, 80, 22000, 157, 020);
insert into REZULTAT values (2003, 3, 54.87, 57.37, 112.24, 60, 11000, 128, 020);
insert into REZULTAT values (2004, 4, 56.22, 56.69, 112.91, 50, 7500, 137, 020);
insert into REZULTAT values (2005, 5, 55.44, 57.78, 113.22, 45, 5500, 133, 020);
insert into REZULTAT values (2006, 6, 57.37, 56.42, 113.79, 40, 4500, 178, 020);
insert into rezultat values (2007, 7, 56.65, 57.22, 113.87, 36, 3500, 175, 020);
insert into rezultat values (2008, 8, 56.15, 57.83, 113.98, 32, 2600, 141, 020);
insert into rezultat values (2009, 9, 56.46, 57.53, 113.99, 29, 2200, 144, 020);
insert into rezultat values (2010, 10, 57.30, 56.81, 114.11, 26, 2000, 164, 020);
insert into rezultat values (2011, 11, 56.79, 57.35, 114.14, 24, 1800, 180, 020);
insert into rezultat values (2012, 12, 56.72, 57.45, 114.17, 22, 1600, 174, 020);
insert into rezultat values (2013, 13, 56.03, 58.26, 114.29, 20, 1500, 156, 020);
insert into rezultat values (2014, 14, 55.76, 58.57, 114.33, 18, 1400, 142, 020);
insert into rezultat values (2015, 15, 56.41, 58.08, 114.49, 16, 1320, 162, 020);
insert into rezultat values (2016, 0, 56.31, NULL, NULL, 0, 0, 187, 020);
insert into rezultat values (2017, 0, 56.56, NULL, NULL, 0, 0, 168, 020);
insert into rezultat values (2018, 0, 56.05, NULL, NULL, 0, 0, 165, 020);
insert into rezultat values (2019, 0, 56.30, NULL, NULL, 0, 0, 145, 020);
insert into rezultat values (2020, 0, 55.57, NULL, NULL, 0, 0, 150, 020);
insert into rezultat values (2021, 0, 54.84, NULL, NULL, 0, 0, 148, 020);
insert into rezultat values (2022, 0, NULL, NULL, NULL, 0, 0, 173, 020);
insert into rezultat values (2023, 0, NULL, NULL, NULL, 0, 0, 160, 020);
insert into rezultat values (2024, 0, NULL, NULL, NULL, 0, 0, 166, 020);
insert into rezultat values (2025, 0, NULL, NULL, NULL, 0, 0, 171, 020);

