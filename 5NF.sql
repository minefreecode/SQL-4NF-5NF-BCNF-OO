/*5NF Example*/
/*Удаление таблиц*/
DROP TABLE R1;
DROP TABLE R2;
DROP TABLE R3;
/*
Создание 1-й таблицы  с полями MANUFACTURER и ITEM
*/
CREATE TABLE R1
(MANUFACTURER VARCHAR2(25),
ITEM VARCHAR2(25),
PRIMARY KEY (MANUFACTURER,ITEM));

/*
Создание 2-й таблицы  с полями ITEM и SALESPERSON
*/
CREATE TABLE R2
(ITEM VARCHAR2(25),
PRIMARY KEY (ITEM,SALESPERSON));

/*
Создание 3-й таблицы  с полями MANUFACTURER и SALESPERSON
*/
CREATE TABLE R3
(MANUFACTURER VARCHAR2(25),
SALESPERSON VARCHAR2(25),
PRIMARY KEY (MANUFACTURER,SALESPERSON));


/*Вставки данных в 1-ю таблицу*/
INSERT INTO R1 VALUES ('Kitchen World','Doughnut');
INSERT INTO R1 VALUES ('Kitchen World','Refridgerator');
INSERT INTO R1 VALUES ('House AllSorts Ltd','Refridgerator');
/*Вставки данных в 2-ю таблицу*/
INSERT INTO R2 VALUES ('Refridgerator','Jennifer');
INSERT INTO R2 VALUES ('Doughnut','Charlotte');
INSERT INTO R2 VALUES ('Refridgerator','Charlotte');
/*Вставки данных в 3-ю таблицу*/
INSERT INTO R3 VALUES ('Kitchen World','Jennifer');
INSERT INTO R3 VALUES ('Kitchen World','Charlotte');
INSERT INTO R3 VALUES ('House AllSorts Ltd','Charlotte');

/*Выборка из 1-й и 2-й таблицы*/
Select * from R1,R2
WHERE R1.ITEM = R2.ITEM;

/*Выборка из 1-й и 3-й таблицы воссоздает композированный вид. Всех данных достаточно*/
Select * from R1,R3
WHERE R1.MANUFACTURER = R3.MANUFACTURER;

/*Выборка из 3-й, 2-й, 1-й таблицы воссоздает композированный вид. Всех данных достаточно*/
Select t3.MANUFACTURER,t3.SALESPERSON,t1.ITEM
FROM R3 t3, R2 t2, R1 t1
WHERE t1.MANUFACTURER = t3.MANUFACTURER
AND t2.SALESPERSON = t3.SALESPERSON
AND t1.ITEM = t2.ITEM;
