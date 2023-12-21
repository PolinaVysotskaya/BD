CREATE SCHEMA IF NOT EXISTS NEW_YEAR;
set search_path = NEW_YEAR, public;

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
    id_child SERIAL REFERENCES new_year.child(id_child),
    id_gift SERIAL REFERENCES new_year.gift(id_gift),
    primary key (id_child, id_gift)
);

-- Создание таблицы Изменений Детей
DROP TABLE IF EXISTS CHILDREN_HISTORY CASCADE;
CREATE TABLE CHILDREN_HISTORY
(
    id_child INTEGER,
    country VARCHAR(255) NOT NULL,
    valid_from DATE DEFAULT NOW(),
    valid_to DATE DEFAULT '2999-12-31',
    PRIMARY KEY (id_child, valid_from)
);


-- Создание таблицы Изменений Эльфов
DROP TABLE IF EXISTS ELF_HISTORY CASCADE;
CREATE TABLE ELF_HISTORY
(
    id_elf INTEGER,
    rating INTEGER check (rating >= 0),
    position VARCHAR(255) NOT NULL,
    pos_valid_from DATE DEFAULT NOW(),
    pos_valid_to DATE DEFAULT '2999-12-31',
    PRIMARY KEY (id_elf, pos_valid_from)
);

