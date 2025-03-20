/* 4NF Example*/

/* Удаление старых таблиц */
DROP TABLE ONE;
DROP TABLE TWO;

/*
Создаем новую таблицу 1 с полями MANUFACTURER и ITEM и делаем их первичным ключом
*/
CREATE TABLE ONE
(MANUFACTURER VARCHAR2(25) NOT NULL,
ITEM VARCHAR(25) NOT NULL,
PRIMARY KEY (MANUFACTURER,ITEM));

/*
Создаем новую таблицу 2 с полями MANUFACTURER и DELIVERY_AREA и делаем их первичным ключом
*/
CREATE TABLE TWO
(MANUFACTURER VARCHAR2(25) NOT NULL,
DELIVERY_AREA VARCHAR(25) NOT NULL,
PRIMARY KEY (MANUFACTURER,DELIVERY_AREA));
/*
Вставка данных в 1-ю таблицу
*/
INSERT INTO ONE VALUES ('Kitchen World','Kettle');
INSERT INTO ONE VALUES ('Kitchen World','Refrigerator');
INSERT INTO ONE VALUES ('BigCookeryProducts.com','Refrigerator');
INSERT INTO ONE VALUES ('BigCookeryProducts.com','Food Processor');
/*
Вставка данных в 2-ю таблицу
*/
INSERT INTO TWO VALUES ('Kitchen World','North Yorkshire');
INSERT INTO TWO VALUES ('Kitchen World','Tyne and Wear');
INSERT INTO TWO VALUES ('BigCookeryProducts.com','North Yorkshire');
INSERT INTO TWO VALUES ('BigCookeryProducts.com','Tyne and Wear');
INSERT INTO TWO VALUES ('BigCookeryProducts.com','County Durham');

/*
Получаем данные. 2-я таблица зависит от 1-й. Нет никаких тривиальных зависимостей
*/
SELECT o.MANUFACTURER, o.ITEM, t.DELIVERY_AREA
FROM ONE o, TWO t
WHERE t.MANUFACTURER = o.MANUFACTURER;
