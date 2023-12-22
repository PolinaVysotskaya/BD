CREATE SCHEMA IF NOT EXISTS LOGICAL_TABLE;
set search_path = LOGICAL_TABLE, public;

-- Создание таблицы Страны
DROP TABLE IF EXISTS COUNTRY CASCADE;
CREATE TABLE COUNTRY (
    id_country SERIAL PRIMARY KEY,
    timezone VARCHAR(255) DEFAULT ('GMT'),
    name_of_the_country VARCHAR(255) UNIQUE,
    CONSTRAINT uq_country UNIQUE (name_of_the_country)
);

-- Создание таблицы Дети
DROP TABLE IF EXISTS CHILD CASCADE;
CREATE TABLE CHILD (
    id_child SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    age INTEGER check (age between 0 and 19),
    gender VARCHAR(10) check (gender = 'male' OR gender = 'female'),
    valid_from TIMESTAMP DEFAULT NOW(),
    CONSTRAINT uq_name UNIQUE (first_name, last_name),
    id_country SERIAL REFERENCES COUNTRY(id_country)
);

-- Создание таблицы Эльфы
DROP TABLE IF EXISTS ELF CASCADE;
CREATE TABLE ELF (
    id_elf SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    rating INTEGER check (rating >= 0),
    position VARCHAR(255) NOT NULL,
    pos_valid_from TIMESTAMP DEFAULT NOW(), -- сейчас мы его добавили и сейчас он вышел на позицию если не сейчас, то прописано когда
    CONSTRAINT uq_elf_name UNIQUE (first_name, last_name),
    id_country SERIAL REFERENCES COUNTRY(id_country)
);

-- Создание таблицы Доставки
DROP TABLE IF EXISTS DELIVERY CASCADE;
CREATE TABLE DELIVERY (
    id_delivery SERIAL PRIMARY KEY,
    delivery_time varchar(5) check (delivery_time like '__:__'),
    delivery_estimate INTEGER check (delivery_estimate between 0 AND 10),
    id_elf SERIAL REFERENCES ELF(id_elf)
);

-- Создание таблицы Подарки
DROP TABLE IF EXISTS GIFT CASCADE;
CREATE TABLE GIFT (
    id_gift SERIAL PRIMARY KEY,
    gift_name VARCHAR(255) NOT NULL,
    weight FLOAT check (weight between 0. AND 50.),
    gift_price DECIMAL DEFAULT (0),
    id_delivery SERIAL REFERENCES DELIVERY(id_delivery)
);

-- Создание таблицы Платежей
DROP TABLE IF EXISTS PAYMENT CASCADE;
CREATE TABLE PAYMENT (
    id_payment INTEGER PRIMARY KEY REFERENCES DELIVERY(id_delivery),
    type_of_payment VARCHAR(255) check (type_of_payment = 'by cash' OR type_of_payment = 'by bank card'
                                            OR type_of_payment = 'by a gift' OR type_of_payment = 'by sweets' OR type_of_payment = 'by coins'),
    "check" DECIMAL DEFAULT(0)
);

-- Создание таблицы Связь Детей и Подарков
DROP TABLE IF EXISTS CHILD_X_GIFT CASCADE;
CREATE TABLE CHILD_X_GIFT (
    id_child SERIAL REFERENCES LOGICAL_TABLE.child(id_child),
    id_gift SERIAL REFERENCES LOGICAL_TABLE.gift(id_gift),
    primary key (id_child, id_gift)
);

-- Создание таблицы Изменений Детей
DROP TABLE IF EXISTS CHILDREN_HISTORY CASCADE;
CREATE TABLE CHILDREN_HISTORY
(
    id_child INTEGER,
    id_country INTEGER,
    valid_from TIMESTAMP DEFAULT NOW(),
    valid_to TIMESTAMP DEFAULT '2999-12-31',
    PRIMARY KEY (id_child, valid_from)
);


-- Создание таблицы Изменений Эльфов
DROP TABLE IF EXISTS ELF_HISTORY CASCADE;
CREATE TABLE ELF_HISTORY
(
    id_elf INTEGER,
    rating INTEGER check (rating >= 0),
    position VARCHAR(255) NOT NULL,
    pos_valid_from TIMESTAMP DEFAULT NOW(), -- уже есть
    pos_valid_to TIMESTAMP DEFAULT NOW(), -- ставим в момент когда именения произошли
    PRIMARY KEY (id_elf, pos_valid_from)
);

INSERT INTO COUNTRY (timezone, name_of_the_country) VALUES ('GMT+5:30', 'Индия');
INSERT INTO COUNTRY (timezone, name_of_the_country) VALUES ('GMT+8:00', 'Китай');
INSERT INTO COUNTRY (timezone, name_of_the_country) VALUES ('GMT+9:00', 'Япония');
INSERT INTO COUNTRY (timezone, name_of_the_country) VALUES ('GMT-7:00', 'США');
INSERT INTO COUNTRY (timezone, name_of_the_country) VALUES ('GMT+3:00', 'Россия');
INSERT INTO COUNTRY (timezone, name_of_the_country) VALUES ('GMT+1:00', 'Великобритания');
INSERT INTO COUNTRY (timezone, name_of_the_country) VALUES ('GMT+2:00', 'Франция');
INSERT INTO COUNTRY (timezone, name_of_the_country) VALUES ('GMT+1:00', 'Германия');

INSERT INTO CHILD (first_name, last_name, age, gender, id_country) VALUES ('Антон', 'Прошин', 19, 'male', 5);
INSERT INTO CHILD (first_name, last_name, age, gender, id_country) VALUES ('Алина', 'Смирнова', 7, 'female', 1);
INSERT INTO CHILD (first_name, last_name, age, gender, id_country) VALUES ('Мария', 'Козлова', 9, 'female', 2);
INSERT INTO CHILD (first_name, last_name, age, gender, id_country) VALUES ('Елена', 'Соколова', 11, 'female', 3);
INSERT INTO CHILD (first_name, last_name, age, gender, id_country) VALUES ('Ульяна', 'Вертелко', 8, 'female', 1);
INSERT INTO CHILD (first_name, last_name, age, gender, id_country) VALUES ('Владимир', 'Басов', 14, 'male', 6);
INSERT INTO CHILD (first_name, last_name, age, gender, id_country) VALUES ('Александр', 'Ефимов', 19, 'male', 7);
INSERT INTO CHILD (first_name, last_name, age, gender, id_country) VALUES ('Кристина', 'Панова', 15, 'female', 8);
INSERT INTO CHILD (first_name, last_name, age, gender, id_country) VALUES ('Арсений', 'Барашко', 6, 'male', 4);
INSERT INTO CHILD (first_name, last_name, age, gender, id_country) VALUES ('Анастасия', 'Петрова', 10, 'female', 5);
INSERT INTO CHILD (first_name, last_name, age, gender, id_country) VALUES ('Полина', 'Высоцкая', 5, 'female', 8);
INSERT INTO CHILD (first_name, last_name, age, gender, id_country) VALUES ('Саса', 'Афанасьева', 4, 'female', 6);

INSERT INTO ELF(first_name, last_name, rating, position, pos_valid_from, id_country) VALUES ('Харольд', 'Харольдсон', 28, 'доставка подарков', NOW(), 1);
INSERT INTO ELF(first_name, last_name, rating, position, pos_valid_from, id_country) VALUES ('Луна', 'Тильда', 7, 'управление санями', NOW(), 3);
INSERT INTO ELF(first_name, last_name, rating, position, pos_valid_from, id_country) VALUES ('Тимофей', 'Соснин', 1, 'доставка подарков', NOW(), 5);
INSERT INTO ELF(first_name, last_name, rating, position, pos_valid_from, id_country) VALUES ('Берти', 'Бэгшот', 19, 'украшение новогодних подарков', NOW(), 2);
INSERT INTO ELF(first_name, last_name, rating, position, pos_valid_from, id_country) VALUES ('Гилберт', 'Гринготтс', 10, 'управление санями', NOW(), 6);
INSERT INTO ELF(first_name, last_name, rating, position, pos_valid_from, id_country) VALUES ('Дороти', 'Доу', 5, 'доставка подарков', NOW(), 4);
INSERT INTO ELF(first_name, last_name, rating, position, pos_valid_from, id_country) VALUES ('Мариам', 'Мэнси', 22, 'доставка подарков', NOW(), 5);
INSERT INTO ELF(first_name, last_name, rating, position, pos_valid_from, id_country) VALUES ('Саймон', 'Лаун', 6, 'доставка подарков', NOW(), 7);
INSERT INTO ELF(first_name, last_name, rating, position, pos_valid_from, id_country) VALUES ('Тиль', 'Шэдоу', 13, 'украшение новогодних подарков', NOW(), 8);
INSERT INTO ELF(first_name, last_name, rating, position, pos_valid_from, id_country) VALUES ('Дарья', 'Маринина', 8, 'доставка подарков', NOW(), 8);

INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:01', 8, 1);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:00', 7, 2);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:05', 1, 3);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:00', 9, 4);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:07', 0, 3);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:02', 5, 5);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:01', 4, 6);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:01', 9, 7);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:01', 10, 9);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:08', 5, 5);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:12', 1, 6);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:00', 9, 7);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:02', 10, 4);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:10', 6, 8);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:10', 3, 9);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:09', 4, 7);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:00', 10, 1);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:03', 10, 1);
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:02', 8, 10);

INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Свитер', 1.5, 5000, 1);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Коньки', 3, 10000, 1);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Айфон13', 0.2, 90000, 2);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Планшет', 4.1, 70000, 3);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Пазл', 2.3, 3000, 4);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Краски', 1.7, 4000, 4);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Компьютер', 1.3, 100000, 5);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Сноуборд', 10, 12000, 6);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Шарф', 0.2, 3000, 6);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Наушники', 0.3, 20000, 7);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Конструктор ', 4.1, 17000, 8);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Часы', 0.1, 10000, 9);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Билеты на концерт', 0.04, 5000, 10);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Гитара', 3.5, 20000, 11);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Айфон15', 0.174, 120000, 12);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Настолка', 0.7, 0, 13);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Книга', 1.5, 0, 13);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Настолка', 0.5, 0, 14);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Пластинка', 2.6, 6000, 15);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Парфюм', 0.2, 10000, 16);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Игрушка', 0.2, 5000, 17);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Наушники', 0.2, 15000, 18);
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('ИУП', 0.2, 79000, 19);

INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (1, 'by cash', 1);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (2, 'by bank card', 0);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (3, 'by bank card', 0);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (4, 'by cash', 1);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (5, 'by bank card', 0);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (6, 'by bank card',1);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (7, 'by bank card', 1);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (8, 'by cash', 0);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (9, 'by bank card', 1);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (10, 'by bank card', 0);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (11, 'by bank card', 0);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (12, 'by bank card', 0);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (13, 'by sweets', 0);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (14, 'by sweets', 0);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (15, 'by bank card', 1);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (16, 'by bank card', 0);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (17, 'by cash', 0);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (18, 'by bank card', 1);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check") VALUES (19, 'by a gift', 1);

INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(1,4);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(1,7);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(1,20);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(2,1);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(2,2);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(2,21);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(2,22);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(3,5);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(3,6);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(3,16);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(3,17);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(4,3);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(6,8);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(6,9);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(6,13);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(7,18);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(8,19);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(8,12);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(9,10);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(9,14);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(9,11);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(9,15);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(9,19);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(11,23);
----

--1
CREATE VIEW view_country AS
SELECT
    NULL AS id_country,
    timezone,
    name_of_the_country
FROM
    COUNTRY;

--2
CREATE VIEW view_child AS
SELECT
    SUBSTRING(first_name FROM 1 FOR 1) || REPEAT('*', LENGTH(first_name) - 1) AS masked_first_name,
    SUBSTRING(last_name FROM 1 FOR 1) || REPEAT('*', LENGTH(last_name) - 1) AS masked_last_name,
    age,
    gender
FROM
    CHILD
ORDER BY age ASC;

--3
CREATE VIEW view_elf AS
SELECT
    SUBSTRING(first_name FROM 1 FOR 1) || REPEAT('*', LENGTH(first_name) - 1) AS masked_first_name,
    SUBSTRING(last_name FROM 1 FOR 1) || REPEAT('*', LENGTH(last_name) - 1) AS masked_last_name,
    rating,
    position
FROM
    ELF
ORDER BY rating;

--4
CREATE OR REPLACE VIEW view_delivery AS
SELECT
    d.delivery_time,
    d.delivery_estimate,
    REPEAT('*', LENGTH(first_name)) AS masked_first_name,
    SUBSTRING(last_name FROM 1 FOR 1) || REPEAT('*', LENGTH(last_name) - 1) AS masked_last_name
FROM
    DELIVERY d
LEFT JOIN
    ELF e ON d.id_elf = e.id_elf
ORDER BY d.delivery_time ASC;

--5
CREATE VIEW view_gift AS
SELECT
    gift_name,
    weight,
    gift_price
FROM
    GIFT
ORDER BY gift_price DESC;

--6
CREATE VIEW view_payment AS
SELECT
    type_of_payment,
    "check"
FROM
    PAYMENT
ORDER BY type_of_payment ASC;

--7
CREATE VIEW view_child_x_gift AS
SELECT
    SUBSTRING(first_name FROM 1 FOR 1) || REPEAT('*', LENGTH(first_name) - 1) AS masked_first_name,
    SUBSTRING(last_name FROM 1 FOR 1) || REPEAT('*', LENGTH(last_name) - 1) AS masked_last_name,
    g.gift_name
FROM
    CHILD_X_GIFT cxg
JOIN
    CHILD c ON cxg.id_child = c.id_child
JOIN
    GIFT g ON cxg.id_gift = g.id_gift;

--8
CREATE OR REPLACE VIEW children_history_view AS
SELECT
    NULL AS id_child, -- Маскировка id_child
    NULL AS id_country,
    valid_from,
    valid_to
FROM
    CHILDREN_HISTORY;

--9
CREATE OR REPLACE VIEW elf_history_view AS
SELECT
    'ELF*****' AS masked_id_elf,
    rating,
    SUBSTRING(position FROM 1 FOR 1) || REPEAT('*', LENGTH(position) - 1) AS masked_position,
    pos_valid_from,
    pos_valid_to
FROM
    ELF_HISTORY
ORDER BY rating DESC;
