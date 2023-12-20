CREATE SCHEMA IF NOT EXISTS NEW_YEAR;
set search_path = NEW_YEAR, public;

-- Создание таблицы Страны
DROP TABLE IF EXISTS COUNTRY CASCADE;
CREATE TABLE COUNTRY (
    id_country SERIAL PRIMARY KEY,
    timezone VARCHAR(255) DEFAULT ('GMT'),
    name_of_the_country VARCHAR(255) UNIQUE,
    CONSTRAINT uq_country_name UNIQUE (name_of_the_country)
);

INSERT INTO COUNTRY (id_country, timezone, name_of_the_country) VALUES (1, 'GMT+5:30', 'Индия');
INSERT INTO COUNTRY (id_country, timezone, name_of_the_country) VALUES (2, 'GMT+8:00', 'Китай');
INSERT INTO COUNTRY (id_country, timezone, name_of_the_country) VALUES (3, 'GMT+9:00', 'Япония');
INSERT INTO COUNTRY (id_country, timezone, name_of_the_country) VALUES (4, 'GMT-7:00', 'США');
INSERT INTO COUNTRY (id_country, timezone, name_of_the_country) VALUES (5, 'GMT+3:00', 'Россия');
INSERT INTO COUNTRY (id_country, timezone, name_of_the_country) VALUES (6, 'GMT+1:00', 'Великобритания');
INSERT INTO COUNTRY (id_country, timezone, name_of_the_country) VALUES (7, 'GMT+2:00', 'Франция');
INSERT INTO COUNTRY (id_country, timezone, name_of_the_country) VALUES (8, 'GMT+1:00', 'Германия');

-- Создание таблицы Дети
DROP TABLE IF EXISTS CHILD CASCADE;
CREATE TABLE CHILD (
    id_child SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    age INTEGER check (age between 0 and 19),
    gender VARCHAR(10) check (gender = 'male' OR gender = 'female'),
    CONSTRAINT uq_name UNIQUE (first_name, last_name),
    id_country SERIAL REFERENCES COUNTRY(id_country)
);

INSERT INTO CHILD (id_child, first_name, last_name, age, gender, id_country) VALUES (1, 'Антон', 'Прошин', 19, 'male', 5);
INSERT INTO CHILD (id_child, first_name, last_name, age, gender, id_country) VALUES (2, 'Алина', 'Смирнова', 7, 'female', 1);
INSERT INTO CHILD (id_child, first_name, last_name, age, gender, id_country) VALUES (3, 'Мария', 'Козлова', 9, 'female', 2);
INSERT INTO CHILD (id_child, first_name, last_name, age, gender, id_country) VALUES (4, 'Елена', 'Соколова', 11, 'female', 3);
INSERT INTO CHILD (id_child, first_name, last_name, age, gender, id_country) VALUES (5, 'Ульяна', 'Вертелко', 8, 'female', 1);
INSERT INTO CHILD (id_child, first_name, last_name, age, gender, id_country) VALUES (6, 'Владимир', 'Басов', 14, 'male', 6);
INSERT INTO CHILD (id_child, first_name, last_name, age, gender, id_country) VALUES (7, 'Александр', 'Ефимов', 19, 'male', 7);
INSERT INTO CHILD (id_child, first_name, last_name, age, gender, id_country) VALUES (8, 'Екатерина', 'Кузнецова', 15, 'female', 8);
INSERT INTO CHILD (id_child, first_name, last_name, age, gender, id_country) VALUES (9, 'Арсений', 'Барашко', 6, 'male', 4);
INSERT INTO CHILD (id_child, first_name, last_name, age, gender, id_country) VALUES (10, 'Анастасия', 'Петрова', 10, 'female', 5);

-- Создание таблицы Эльфы
DROP TABLE IF EXISTS ELF CASCADE;
CREATE TABLE ELF (
    id_elf SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    rating INTEGER check (rating >= 0),
    position VARCHAR(255) NOT NULL,
    update_position DATE DEFAULT NOW(),
    CONSTRAINT uq_elf_name UNIQUE (first_name, last_name),
    id_country SERIAL REFERENCES COUNTRY(id_country)
);

INSERT INTO ELF(id_elf, first_name, last_name, rating, position, id_country) VALUES (1, 'Харольд', 'Харольдсон', 28, 'доставка подарков', 1);
INSERT INTO ELF(id_elf, first_name, last_name, rating, position, id_country) VALUES (2, 'Луна', 'Тильда', 7, 'управление санями', 3);
INSERT INTO ELF(id_elf, first_name, last_name, rating, position, id_country) VALUES (3, 'Тимофей', 'Соснин', 1, 'доставка подарков', 5);
INSERT INTO ELF(id_elf, first_name, last_name, rating, position, id_country) VALUES (4, 'Берти', 'Бэгшот', 19, 'украшение новогодних подарков', 2);
INSERT INTO ELF(id_elf, first_name, last_name, rating, position, id_country) VALUES (5, 'Гилберт', 'Гринготтс', 10, 'управление санями', 6);
INSERT INTO ELF(id_elf, first_name, last_name, rating, position, id_country) VALUES (6, 'Дороти', 'Доу', 5, 'доставка подарков', 4);
INSERT INTO ELF(id_elf, first_name, last_name, rating, position, id_country) VALUES (7, 'Мариам', 'Мэнси', 22, 'доставка подарков', 5);
INSERT INTO ELF(id_elf, first_name, last_name, rating, position, id_country) VALUES (8, 'Саймон', 'Лаун', 6, 'доставка подарков', 7);
INSERT INTO ELF(id_elf, first_name, last_name, rating, position, id_country) VALUES (9, 'Тиль', 'Шэдоу', 13, 'украшение новогодних подарков', 8);

-- Создание таблицы Доставки
DROP TABLE IF EXISTS DELIVERY CASCADE;
CREATE TABLE DELIVERY (
    id_delivery SERIAL PRIMARY KEY,
    delivery_time varchar(5) check (delivery_time like '__:__'),
    delivery_estimate INTEGER check (delivery_estimate between 0 AND 10),
    id_elf SERIAL REFERENCES ELF(id_elf)
);

INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (1, '00:01', 8, 1);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (2, '00:00', 7, 2);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (3, '00:05', 1, 3);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (4, '00:00', 9, 4);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (5, '00:07', 0, 3);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (6, '00:02', 5, 5);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (7, '00:01', 4, 6);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (8, '00:01', 9, 7);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (9, '00:01', 10, 9);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (10, '00:08', 5, 5);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (11, '00:12', 1, 6);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (12, '00:00', 9, 7);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (13, '00:02', 10, 4);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (14, '00:10', 6, 8);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (15, '00:10', 3, 9);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (16, '00:09', 4, 7);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (17, '00:00', 10, 1);
INSERT INTO DELIVERY(id_delivery, delivery_time, delivery_estimate, id_elf) VALUES (18, '00:03', 10, 1);

-- Создание таблицы Подарки
DROP TABLE IF EXISTS GIFT CASCADE;
CREATE TABLE GIFT (
    id_gift SERIAL PRIMARY KEY,
    gift_name VARCHAR(255) NOT NULL,
    weight FLOAT check (weight between 0. AND 50.),
    gift_price DECIMAL DEFAULT (0),

    id_delivery SERIAL REFERENCES DELIVERY(id_delivery)
);

INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (1, 'Свитер', 1.5, 5000, 1);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (2, 'Коньки', 3, 10000, 1);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (3, 'Айфон', 0.2, 90000, 2);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (4, 'Планшет', 4.1, 70000, 3);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (5, 'Пазл', 2.3, 3000, 4);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (6, 'Краски', 1.7, 4000, 4);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (7, 'Компьютер', 1.3, 100000, 5);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (8, 'Сноуборд', 10, 12000, 6);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (9, 'Шарф', 0.2, 3000, 6);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (10, 'Наушники', 0.3, 20000, 7);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (11, 'Конструктор ', 4.1, 17000, 8);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (12, 'Часы', 0.1, 10000, 9);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (13, 'Билеты на концерт', 0.04, 5000, 10);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (14, 'Гитара', 3.5, 20000, 11);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (15, 'Айфон', 0.174, 120000, 12);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (16, 'Настолка', 0.7, 0, 13);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (17, 'Книга', 1.5, 0, 13);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (18, 'Настолка', 0.5, 0, 14);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (19, 'Пластинка', 2.6, 6000, 15);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (20, 'Парфюм', 0.2, 10000, 16);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (21, 'Шарф', 0.2, 3000, 17);
INSERT INTO GIFT(id_gift, gift_name, weight, gift_price, id_delivery) VALUES (22, 'Наушники', 0.2, 15000, 18);

-- Создание таблицы Платежей
DROP TABLE IF EXISTS PAYMENT CASCADE;
CREATE TABLE PAYMENT (
    id_payment SERIAL PRIMARY KEY,
    type_of_payment VARCHAR(255) check (type_of_payment = 'by cash' OR type_of_payment = 'by bank card'
                                            OR type_of_payment = 'by a gift' OR type_of_payment = 'by sweets'),
    "check" DECIMAL DEFAULT(0),
    id_delivery SERIAL REFERENCES DELIVERY(id_delivery)
);

INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (1, 'by cash', 1, 1);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (2, 'by cash', 1, 1);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (3, 'by bank card', 0, 2);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (4, 'by bank card', 0, 3);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (5, 'by cash', 1, 4);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (6, 'by bank card', 1, 4);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (7, 'by bank card', 0, 5);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (8, 'by bank card',1, 6);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (9, 'by cash', 0, 6);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (10, 'by bank card', 1, 7);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (11, 'by cash', 0, 8);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (12, 'by bank card', 1, 9);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (13, 'by bank card', 0, 10);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (14, 'by bank card', 0, 11);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (15, 'by bank card', 0, 12);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (16, 'by sweets', 0, 13);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (17, 'by sweets', 0, 13);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (18, 'by sweets', 0, 14);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (19, 'by bank card', 1, 15);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (20, 'by bank card', 0, 16);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (21, 'by cash', 0, 17);
INSERT INTO PAYMENT (id_payment, type_of_payment, "check", id_delivery) VALUES (22, 'by bank card', 1, 18);

-- Создание таблицы Связь Детей и Подарков
DROP TABLE IF EXISTS CHILD_X_GIFT CASCADE;
CREATE TABLE CHILD_X_GIFT (
    id_child SERIAL REFERENCES new_year.child(id_child),
    id_gift SERIAL REFERENCES new_year.gift(id_gift),
    primary key (id_child, id_gift)
);

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

-- Создание таблицы Изменений Детей
DROP TABLE IF EXISTS CHILDREN_HISTORY CASCADE;
CREATE TABLE CHILDREN_HISTORY
(
    id_child       SERIAL UNIQUE,
    old_country    VARCHAR(255) NOT NULL,
    old_age        INTEGER,
    old_gender     CHAR(1),
    CONSTRAINT pk_child_history PRIMARY KEY (id_child),
    CONSTRAINT fk_child_history_child FOREIGN KEY (id_child) REFERENCES new_year.CHILD(id_child)
);

-- Создание таблицы Изменений Эльфов
DROP TABLE IF EXISTS ELF_HISTORY CASCADE;
CREATE TABLE ELF_HISTORY
(
    id_elf SERIAL UNIQUE,
    position_from DATE,
    position_to DATE DEFAULT NOW(),
    old_rating INTEGER,
    old_position VARCHAR(255) NOT NULL,
    CONSTRAINT pk_elf_history PRIMARY KEY (id_elf),
    CONSTRAINT fk_elf_history_elf FOREIGN KEY (id_elf) REFERENCES new_year.ELF(id_elf)
);
