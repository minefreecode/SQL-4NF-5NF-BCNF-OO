/*Example of ORDBMS with oracle*/
/*force drop all inital tales and types */

/* Удаление всех типов */
DROP TYPE DRIVERTYPE force;
DROP TYPE AddressType force;
DROP TYPE TeamType force;
DROP TABLE driver;
DROP TABLE team;
DROP TABLE address;
DROP TYPE TEAMS2 FORCE;
DROP TABLE TEAMSV2;
/*begin creating a type and a relevent method some PL/SQL*/
/*Вводится новый тип*/
CREATE or replace TYPE DRIVERTYPE as OBJECT
(
 driver_no NUMBER(2),
 driver_fname VARCHAR2(30),
 driver_inits VARCHAR2(3),
 driver_sname varchar2(25),
 address AddressType,
 championship_ranking NUMBER(2),
 races_won NUMBER(3),
 phone_number VARCHAR2(13),
 MEMBER FUNCTION display_address
     RETURN VARCHAR2);
/*Вводится еще один тип*/
CREATE OR REPLACE TYPE BODY DRIVERTYPE AS
MEMBER FUNCTION display_address
  RETURN VARCHAR2 IS
BEGIN
RETURN address.house_no||', '||address.street||', '||address.town||', '||address.postcode||', '||address.country;
END;
END;
/*Создается новый тип как объект */
CREATE or replace TYPE AddressType as OBJECT
(
 house_no NUMBER(3),
 street VARCHAR2(30),
 town VARCHAR2(20),
 county VARCHAR2(25),
 postcode VARCHAR2(8),
 country VARCHAR2(3));
/*Заменяется тип полей */
 CREATE OR REPLACE TYPE telephones IS VARRAY(3) OF VARCHAR2(13);
/*Создает новый тип как объект. Причем ему принадлежит подтип, который мы определили выше*/
CREATE TYPE TeamType as OBJECT
(
 team_no NUMBER(3),
 team_name VARCHAR2(30),
 team_location AddressType,
 manager REF DRIVERTYPE,
 tel_no telephones
 );
/*Создается таблица заданного типа. Она связана с таблицей ADDRESS*/
CREATE TABLE DRIVER OF DRIVERTYPE;
/*Создается таблица заданного типа*/
CREATE TABLE TEAM OF TEAMTYPE;
/*Создается таблица заданного типа. Она связана с таблицей DRIVER*/
CREATE TABLE ADDRESS OF ADDRESSTYPE;
/* Вставка данных в саму таблицу и в связную таблицу одноврепменно*/
INSERT INTO DRIVER VALUES (1,'DANIEL','DW','WILKINSON',AddressType(7,'winner street'
,'sunderland','tyne and wear','SR4 8LE','UK'),1,1,'01915347630');
INSERT INTO DRIVER VALUES (2,'BOB','BM','MARELY',AddressType(49,'looser street'
,'newcastle','newcastle upon','NW4 8LE','UK'),10,0,'01915347631');
INSERT INTO DRIVER VALUES (3,'BILLY','BM','MAY',AddressType(117,'awesome street'
,'manchester','tyne and wea','SR4 8LB','UK'),1,1,'01915347632');
INSERT INTO DRIVER VALUES (4,'JOE','JD','DUMBO',AddressType(34,'sad street'
,'linkin','linkin county','SR4 8LR','UK'),9,5,'01915347633');
INSERT INTO DRIVER VALUES (5,'BUM','BW','WILIAMSON',AddressType(12,'winner street'
,'london','tyne and wear','SR4 8LE','UK'),1,1,'01915347634');
INSERT INTO DRIVER VALUES (6,'MAY','MS','SMITH',AddressType(87,'boo street'
,'quabec','a county','CAN 8LE','CAN'),1,1,'01915347635');

/*Ещё вставка с использованием типов и подтипов*/
INSERT INTO TEAM VALUES (1,'loosers',AddressType(11,'yo street','sunderland','tyne and wear','SR4 EEE','UK'), (SELECT REF(P) from DRIVER P WHERE P.driver_no = 1),telephones('01912345467','01914560986','01915656456'));
INSERT INTO TEAM VALUES (2,'young',AddressType(22,'me street','newcastle','devon','SR4 BBB','UK'), (SELECT REF(P) from DRIVER P WHERE P.driver_no = 2),telephones('01915347677','01914565435','01915657763'));
INSERT INTO TEAM VALUES (3,'winners',AddressType(33,'ha street','birmingham','essex','SR4 CCC','UK'), (SELECT REF(P) from DRIVER P WHERE P.driver_no = 3),telephones('01915347388','01913453456','01914556546'));
INSERT INTO TEAM VALUES (4,'pirates',AddressType(77,'ho street','liverpool','kent','SR4 DDD','UK'),(SELECT REF(P) from DRIVER P WHERE P.driver_no = 4),telephones('01915347399','01919878987','01915498978'));
INSERT INTO TEAM VALUES (5,'muskets',AddressType(88,'al street','london','surrey','SR4 EEE','UK'), (SELECT REF(P) from DRIVER P WHERE P.driver_no = 5),telephones('01915347300','01909876576','01915497676'));
INSERT INTO TEAM VALUES (6,'miniguns',AddressType(99,'cd street','York','north yorkshire','SR4 FFF','UK'), (SELECT REF(P) from DRIVER P WHERE P.driver_no,6),telephones('01915347360','01915646878','01915496756'));

SET LINESIZE 32000;
SELECT d.DRIVER_NO AS D_NO,d.DRIVER_FNAME AS FNAME,
d.DRIVER_SNAME AS SNAME,d.CHAMPIONSHIP_RANKING AS RANK,
d.display_address() AS Address FROM DRIVER d;
SELECT t.team_name, d.DRIVER_FNAME,
d.DRIVER_INITS,d.DRIVER_SNAME,
d.CHAMPIONSHIP_RANKING,d.display_address()
from TEAM t, DRIVER d
WHERE  ref(d) = t.MANAGER;
SELECT t.team_no,t.team_name,b.*
FROM TEAM t, table(TEL_NO) b;
/*STORING TELEPHONES, recreating the team type/table*/
CREATE TYPE TEAMS2 as OBJECT
(
 team_nos NUMBER(3), team_names VARCHAR2(30),
 team_locations AddressType, managers REF DRIVERTYPE,
 interprefix VARCHAR2(5),dailingcode VARCHAR2(5),
dailingnumber VARCHAR2(7),numbertype VARCHAR2(10),
MEMBER FUNCTION get_tell_num RETURN VARCHAR2);
/
CREATE OR REPLACE TYPE BODY TEAMS2 AS
MEMBER FUNCTION get_tell_num
  RETURN VARCHAR2 IS
BEGIN
RETURN interprefix||'-'||dailingcode||'-'||dailingnumber;
END;
END;
/
CREATE TABLE TEAMSV2 OF TEAMS2;
/
INSERT INTO TEAMSV2 VALUES (1,'loosers',AddressType(11,'yo street','sunderland','tyne and wear','SR4 EEE','UK'), (SELECT REF(P) from DRIVER P WHERE P.driver_no = 1),'+44','191','5673214','business');
INSERT INTO TEAMSV2 VALUES (1,'loosers',AddressType(11,'yo street','sunderland','tyne and wear','SR4 EEE','UK'), (SELECT REF(P) from DRIVER P WHERE P.driver_no = 1),'+44','191','5635446','fax');
INSERT INTO TEAMSV2 VALUES (3,'winners',AddressType(33,'ha street','birmingham','essex','SR4 CCC','UK'), (SELECT REF(P) from DRIVER P WHERE P.driver_no = 3),'+44','191','3423423','mobile');

SELECT a.team_names, a.get_tell_num() from TEAMSV2 a;

SELECT a.team_names, a.get_tell_num() from TEAMSV2 a
WHERE a.numbertype = 'business'
AND a.TEAM_NAMES = 'loosers';
