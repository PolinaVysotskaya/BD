--1
CREATE VIEW view_country AS
SELECT
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

--8 на таблицу CHILD_HISTORY
--9 на таблицу ELF_HISTORY
