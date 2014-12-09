-- Generated by Oracle SQL Developer Data Modeler 4.0.3.853
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

CREATE TABLE MATCH
  (
    NumMatch        NUMBER (4) NOT NULL ,
    EquipeReceveuse NUMBER (4) NOT NULL ,
    EquipeVisiteuse NUMBER (4) NOT NULL ,
    Dateheure       DATE ,
    Lieu            VARCHAR2 (30) ,
    ScoreFinaleV    NUMBER (2) ,
    ScoreFinaleR    NUMBER (2)
  ) ;
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
SELECT JOUEURS.NUMJOUEUR,nom,prenom , equipe.nomequipe ,count(fichematchjoueur.nbbuts) as Nombrebuts,count(nbpasses) as nombrepasses
FROM JOUEURS
INNER JOIN EQUIPE
ON EQUIPE.NUMEQUIPE = JOUEURS.NUMEQUIPE
INNER JOIN MATCH
ON MATCH.EQUIPERECEVEUSE = EQUIPE.NUMEQUIPE OR MATCH.EQUIPEVISITEUSE =EQUIPE.NUMEQUIPE
INNER JOIN FICHEMATCHJOUEUR
ON FICHEMATCHJOUEUR.NUMMATCH = MATCH.NUMMATCH
GROUP BY JOUEURS.NUMJOUEUR ,NOM,PRENOM , EQUIPE.NOMEQUIPE);

CREATE INDEX NUMERODELEQUIPE
ON JOUEURS(NUMEQUIPE);

CREATE INDEX DATEETHEURE
ON MATCH (DATEHEURE);
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY MM DD';

INSERT INTO DIVISION (NOM,DateInscription)
VALUES('LAURENTIDE','1990-10-23');

INSERT INTO DIVISION (NOM,DateInscription)
VALUES('LAVAL','1992-10-14');

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
NumMatch  NUMBER (4) NOT NULL ,
    NumJoueur NUMBER (4) NOT NULL ,
    NbPasses  NUMBER (2) ,
    NbButs    NUMBER (2)
    TempPunition number(3);
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