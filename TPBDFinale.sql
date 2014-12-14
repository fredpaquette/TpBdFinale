+-- Generated by Oracle SQL Developer Data Modeler 4.0.3.853
--   at:        2014-11-23 20:18:32 AST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g


DROP TABLE Division CASCADE CONSTRAINTS;
DROP TABLE Equipe CASCADE CONSTRAINTS;
DROP TABLE FicheMatchJoueur CASCADE CONSTRAINTS;
DROP TABLE Joueurs CASCADE CONSTRAINTS;
DROP TABLE Match CASCADE CONSTRAINTS;


-- G�n�r� par Oracle SQL Developer Data Modeler 4.0.2.840
--   � :        2014-11-28 12:08:27 EST
--   site :      Oracle Database 11g
--   type :      Oracle Database 11g

CREATE TABLE Division
  (
    NumDivision     NUMBER (4) NOT NULL ,
    Nom             VARCHAR2 (40) ,
    DateInscription DATE
  ) ;
  d
ALTER TABLE Division ADD CONSTRAINT Division_PK PRIMARY KEY ( NumDivision ) ;

CREATE TABLE Equipe
  (
    NumEquipe        NUMBER (4) NOT NULL ,
    NumDivision      NUMBER (4) NOT NULL ,
    DateIntroduction DATE ,
    Logo BLOB ,
    Ville     VARCHAR2 (30) ,
    NomEquipe VARCHAR2 (20)
  ) ;
  
ALTER TABLE Equipe ADD CONSTRAINT Equipe_PK PRIMARY KEY ( NumEquipe ) ;

CREATE TABLE FicheMatchJoueur
  (
    NumMatch  NUMBER (4) NOT NULL ,
    NumJoueur NUMBER (4) NOT NULL ,
    NbPasses  NUMBER (2) ,
    NbButs    NUMBER (2)
  ) ;
alter table FICHEMATCHJOUEUR
add  TempPunition number(3);

CREATE TABLE Joueurs
  (
    NumJoueur     NUMBER (4) NOT NULL ,
    Nom           VARCHAR2 (30) ,
    Prenom        VARCHAR2 (30) ,
    DateNaissance DATE ,
    NumeroMaillot NUMBER (2) ,
    Photo BLOB ,
    Position  VARCHAR2 (10) ,
    NumEquipe NUMBER (4) NOT NULL
  ) ;
  
ALTER TABLE Joueurs ADD CONSTRAINT Joueurs_PK PRIMARY KEY ( NumJoueur ) ;
alter table joueurs 
drop column photo ;
alter table joueurs 
add  photo VARCHAR2 (50) ;
commit;
alter table joueurs modify photo varchar2(400);

CREATE TABLE MATCH
  (
    NumMatch        NUMBER (4) NOT NULL ,
    EquipeReceveuse NUMBER (4) NOT NULL ,
    EquipeVisiteuse NUMBER (4) NOT NULL ,
    Dateheure       DATE ,
    Lieu            VARCHAR2 (30) ,
    ScoreFinaleV    NUMBER (2) ,
    ScoreFinaleR    NUMBER (2)
  );
  
ALTER TABLE MATCH ADD CONSTRAINT Match_PK PRIMARY KEY ( NumMatch ) ;

ALTER TABLE Equipe ADD CONSTRAINT Equipe_Division_FK FOREIGN KEY ( NumDivision ) REFERENCES Division ( NumDivision ) ;

ALTER TABLE FicheMatchJoueur ADD CONSTRAINT FicheMatchJoueur_Joueurs_FK FOREIGN KEY ( NumJoueur ) REFERENCES Joueurs ( NumJoueur ) ;

ALTER TABLE FicheMatchJoueur ADD CONSTRAINT FicheMatchJoueur_Match_FK FOREIGN KEY ( NumMatch ) REFERENCES MATCH ( NumMatch ) ;

ALTER TABLE Joueurs ADD CONSTRAINT Joueurs_Equipe_FK FOREIGN KEY ( NumEquipe ) REFERENCES Equipe ( NumEquipe ) ;

ALTER TABLE MATCH ADD CONSTRAINT Match_Equipe_FK FOREIGN KEY ( EquipeReceveuse ) REFERENCES Equipe ( NumEquipe ) ;

ALTER TABLE MATCH ADD CONSTRAINT Match_Equipe_FKv1 FOREIGN KEY ( EquipeVisiteuse ) REFERENCES Equipe ( NumEquipe ) ;

CREATE SYNONYM SYNJOUEURS FOR JOUEURS;
GRANT SELECT ON SYNJOUEURS TO PUBLIC;
GRANT ALL ON SYNJOUEURS TO LEMAIREF;

drop view Fichepersonnelle;
CREATE VIEW FichePersonnelle AS(
select J.NUMJOUEUR,
sum(FMJ.NBBUTS) as NombreButs,
sum(FMJ.NBPASSES) as NomBrePasses,
J.NOM,
J.PRENOM, E.NOMEQUIPE
from FICHEMATCHJOUEUR FMJ
inner join Joueurs J on FMJ.NUMJOUEUR = J.NUMJOUEUR
inner join EQUIPE E on J.NUMEQUIPE = E.NUMEQUIPE 
group by J.nom, J.PRENOM, E.NOMEQUIPE,J.NUMJOUEUR
--SELECT JOUEURS.NUMJOUEUR,nom,prenom , equipe.nomequipe ,count(fichematchjoueur.nbbuts) as Nombrebuts,count(nbpasses) as nombrepasses
--FROM JOUEURS
--INNER JOIN EQUIPE
--ON EQUIPE.NUMEQUIPE = JOUEURS.NUMEQUIPE
--INNER JOIN MATCH
--ON MATCH.EQUIPERECEVEUSE = EQUIPE.NUMEQUIPE OR MATCH.EQUIPEVISITEUSE =EQUIPE.NUMEQUIPE
--INNER JOIN FICHEMATCHJOUEUR
--ON FICHEMATCHJOUEUR.NUMMATCH = MATCH.NUMMATCH
--GROUP BY JOUEURS.NUMJOUEUR ,NOM,PRENOM , EQUIPE.NOMEQUIPE
 );

CREATE INDEX NUMERODELEQUIPE
ON JOUEURS(NUMEQUIPE);

CREATE INDEX DATEETHEURE
ON MATCH (DATEHEURE);

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY MM DD';



select * from division;

INSERT INTO EQUIPE (NUMDIVISION, DateIntroduction,VILLE,NOMEQUIPE)
VALUES(2,'2003-09-03','saskatoune','LesRequins');

INSERT INTO EQUIPE (NUMDIVISION, DateIntroduction,VILLE,NOMEQUIPE)
VALUES(2,'2000-04-17','Quebec','LesLynx');
select* from equipe;

delete from equipe where numequipe = 7;

select * from DIVISION;

commit;

select * from joueurs;
 
commit;
insert into match( EquipeReceveuse,EquipeVisiteuse,  Dateheure, Lieu, ScoreFinaleV, ScoreFinaleR)
values(11,9,'2014-04-23','Quebec',3,2);
select * from match;

alter table FICHEMATCHJOUEUR
add  TempPunition number(3);

    insert into fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts,tempPunition)
    Values (1,14,0,0,0);
 
 insert into fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts,tempPunition)
    Values (1,15,1,0,0);
    
    select * from equipe;
select * from  Fichepersonnelle where nomequipe ='LesLynx';

select * from match;

select numjoueur,nom,prenom
from joueurs 
inner join equipe 
on equipe.numequipe = joueurs.numequipe;

select nummatch from match;

select DATEHEURE from match;

select * from match where DateHeure = '2014-04-23';

select * from match;

select *
from joueurs
where numjoueur in (select numjoueur from FICHEMATCHJOUEUR where nummatch = 1);

select * from FICHEMATCHJOUEUR where nummatch = 1;

select * from joueurs;

select * from equipe;
select * from joueurs;
 
insert into equipe (NumDivision,DateIntroduction,Ville,NomEquipe)
values(1,'2000-04-14','Chibougamo','The Team');
commit;
select * from equipe;

update equipe
set NOMEQUIPE = 'test',ville = 'testencore'
where numequipe = 11;


--Division
INSERT INTO DIVISION (NOM,DateInscription)
VALUES('LAURENTIDE','1990-10-23');

INSERT INTO DIVISION (NOM,DateInscription)
VALUES('LAVAL','1992-10-14');

--Insertion divison 1
INSERT INTO EQUIPE (NUMDIVISION , DateIntroduction ,Ville , NomEquipe)
values (1 , '1995-02-13', 'Quebec','Bulls');
INSERT INTO EQUIPE (NUMDIVISION , DateIntroduction ,Ville , NomEquipe)
values (1 , '1992-06-06', 'Lanaudiere','Husky');
INSERT INTO EQUIPE (NUMDIVISION , DateIntroduction ,Ville , NomEquipe)
values (1 , '1990-10-12', 'Trois-Riviere','PitBull');
INSERT INTO EQUIPE (NUMDIVISION , DateIntroduction ,Ville , NomEquipe)
values (1 , '1991-07-13', 'Shawiningan','Dragon');

--Insertion division 2
INSERT INTO EQUIPE (NUMDIVISION , DateIntroduction ,Ville , NomEquipe)
values (2 , '1994-01-19', 'Montreal Nord','Eagles');
INSERT INTO EQUIPE (NUMDIVISION , DateIntroduction ,Ville , NomEquipe)
values (2 , '1993-12-23', 'Lavaltrie','Darksiders');
INSERT INTO EQUIPE (NUMDIVISION , DateIntroduction ,Ville , NomEquipe)
values (2 , '1991-01-11', 'Tox Ville','Tox');
INSERT INTO EQUIPE (NUMDIVISION , DateIntroduction ,Ville , NomEquipe)
values (2 , '1992-09-15', 'Small Ville','SuperMan');


--Joueurs equipe division 1
 
 --Equipe 1   
INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Parker','Peter','1994-04-30',13,'Attaquant',21 );

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Patoche','Alain','1990-12-28',22,'Attaquant',21 );

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('TravailFort','Il','1992-09-22',48,'Defenseur',21 );

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('LaRebelle','Ginette','1991-10-13',66,'Defenseur',21 );

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Salty','Mels','1993-03-10',89,'Gardien',21 );

--Equipe 2
INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Bourgeau','Xavier','1992-01-22',09,'Attaquant',23);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Kent','Clark','1992-10-03',55,'Attaquant',23);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Juteux','Poirier','1992-11-20',13,'Defenseur',23 );

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Trie','Max','1990-02-22',89,'Defenseur',23 );

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Sylverstio','Davido','1990-11-13',70,'Gardien',23 );

--Equipe 3
INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Lemaire','Francis','1991-08-28',33,'Attaquant',25 );

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('St-Laurent','Daren','1993-06-17',27,'Attaquant',25);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Subban','Pk','1992-05-16',75,'Defenseur',25);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Anti','Aalto','1990-07-16',44,'Defenseur',25);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Adams','Greg','1991-10-14',39,'Gardien',25);

--equipe 4
INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Abric','Peter','1992-09-13',56,'Attaquant',27);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Michel','Yvan','1990-04-06',99,'Attaquant',27);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Wayne','Bruce','1992-09-05',21,'Defenseur',27);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Lisa','Mona','1991-12-29',22,'Defenseur',27);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Aiken','Don','1990-03-07',77,'Gardien',27);


--Insertion Division 2
--Equipe 5
INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Alexender','Bob','1990-11-12',90,'Attaquant',29);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Potter','Harry','1991-10-12',89,'Attaquant',29);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Granger','Hermione','1991-07-18',54,'Defenseur',29);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Wesley','Ron','1994-07-12',11,'Defenseur',29);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Lebelle','Simeone','1990-01-05',29,'Gardien',29);

--equipe 6
INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('DeBretagne','Leduc','1992-12-27',19,'Attaquant',31);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('LeMagnifique','Gatsby','1992-05-20',30,'Attaquant',31);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Osborn','Harry','1992-02-18',31,'Defenseur',31);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Alexender','Bob','1990-03-19',90,'Defenseur',31);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('LePasGentil','LeGros','1991-04-24',20,'Gardien',31);

--equipe 7
INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Boy','Yolo','1991-09-21',01,'Attaquant',33);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Choisi','JeTe','1991-04-20',77,'Attaquant',33);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Fort','Trop','1996-02-11',11,'Defenseur',33);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Man','Spider','1990-05-11',19,'Defenseur',33);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Hulk','The','1989-11-20',99,'Gardien',33);

--Equipe 8
INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Baggins','Bilbo','1990-12-24',19,'Attaquant',35);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('Baggins','Frodon','1991-12-24',49,'Attaquant',35);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('LeGris','Gandalf','1677-12-24',22,'Defenseur',35);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('TheRock','Gimli','1800-01-23',19,'Defenseur',35);

INSERT INTO JOUEURS (Nom, Prenom, DateNaissance, NumeroMaillot , Position , NumEquipe)
Values ('TheElf','Legolas','1980-12-24',97,'Gardien',35);


--Insertion des Match

    
    select * from equipe;
alter table match
modify Heure Varchar2(5);
INSERT INTO MATCH (EquipeReceveuse , EquipeVisiteuse , DateHeure , Lieu , ScoreFinaleV , ScoreFinaleR, Heure )
values (21,23,'2014-02-21','Quebec',4,2,'14:00');
--fiche joueur match
 
    select numjoueur,position from joueurs where numequipe = 21;
    --equipevisiteuse
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(6,24,1,1);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(6,25,2,1);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(6,26,0,2);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(6,27,0,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(6,28,0,0);

--equipe receveuse
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(6,19,0,2);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(6,20,1,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(6,21,1,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(6,22,0,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(6,23,0,0);

INSERT INTO MATCH (EquipeReceveuse , EquipeVisiteuse , DateHeure , Lieu , ScoreFinaleV , ScoreFinaleR, Heure )
values (25,27,'2014-02-25','Trois-Riviere',0,1,'20:00');
 select numjoueur,position from joueurs where numequipe = 25;
    --equipevisiteuse
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(7,34,0,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(7,35,0,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(7,36,0,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(7,37,0,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(7,38,0,0);
--
--equipe receveuse
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(7,29,1,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(7,30,0,1);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(7,31,0,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(7,32,0,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(7,33,0,0);

INSERT INTO MATCH (EquipeReceveuse , EquipeVisiteuse , DateHeure , Lieu , ScoreFinaleV , ScoreFinaleR, Heure )
values (29,31,'2014-03-03','Montreal',3,1,'21:00');
 select numjoueur,position from joueurs where numequipe = 29;
    --equipevisiteuse
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(8,45,1,1);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(8,46,1,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(8,47,0,1);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(8,48,1,1);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(8,49,0,0);
--
--equipe receveuse
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(8,40,1,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(8,41,0,1);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(8,42,0,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(8,43,0,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(8,44,0,0);

INSERT INTO MATCH (EquipeReceveuse , EquipeVisiteuse , DateHeure , Lieu , ScoreFinaleV , ScoreFinaleR, Heure )
values (33,35,'2014-03-07','Shawinigan',2,1,'21:00');
 select numjoueur,position from joueurs where numequipe = 33;
    --equipevisiteuse
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(9,55,1,1);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(9,56,1,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(9,57,0,1);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(9,58,0,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(9,59,0,0);
--
--equipe receveuse
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(9,50,1,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(9,51,0,1);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(9,52,0,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(9,53,0,0);
INSERT INTO fichematchjoueur(nummatch,numjoueur,nbpasses,nbbuts)
values(9,54,0,0);

commit;
select * from match;



select * from fichepersonelle;
select * from division;
Update division set nom ='LAVAL' WHERE numdivision = 2;

update joueurs set photo = 'http://im.ziffdavisinternational.com/t/ign_za/articlepage/s/sir-ian-mckellen-says-goodbye-to-gandalf/sir-ian-mckellen-says-goodbye-to-gandalf_pys4.1920.jpg' where numjoueur = 57;
commit;
update joueurs set photo = 'http://img2.wikia.nocookie.net/__cb20060228022700/lotr/images/a/a5/Lotr_movie_gimli.jpg' where numjoueur = 58;
update joueurs set photo = 'http://img2.timeinc.net/ew/i/2013/FMP/Gallery/Hobbit-The-Desolation-of-Smaug.jpg' where numjoueur = 59;

select * from joueurs;
select * from equipe;
select numjoueur,nom,prenom,Fichepersonnelle.nomequipe,nombrebuts,nombrepasses, equipe.logo  from  Fichepersonnelle inner join equipe on equipe.nomequipe = Fichepersonnelle.nomequipe where Fichepersonnelle.nomequipe = 'Husky';