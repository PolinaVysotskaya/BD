--1
CREATE VIEW children_with_early_gifts AS
SELECT
    d.delivery_time,
    c.first_name,
    SUBSTRING(c.last_name FROM 1 FOR 1) || REPEAT('*', LENGTH(c.last_name) - 1) AS masked_last_name,
    g.gift_name
FROM
    CHILD c
JOIN
    CHILD_X_GIFT cxg ON c.id_child = cxg.id_child
JOIN
    GIFT g ON cxg.id_gift = g.id_gift
JOIN
    DELIVERY d ON g.id_delivery = d.id_delivery
WHERE
    d.delivery_time <= '00:05'
ORDER BY d.delivery_time ASC;

-- Представление предназначено для отображения имени ребенка, замаскированной фамилии и названия подарков,
-- которые дети получили в первые пять минут после начала Нового года.
-- Представление объединяет таблицы "CHILD", "CHILD_X_GIFT", "GIFT" и "DELIVERY" с помощью операторов JOIN.
-- Затем оно фильтрует записи, где время доставки подарка меньше или равно '00:05' с помощью оператора WHERE
-- и выводит значения по возрастанию времени доставки

--2
CREATE VIEW children_without_gifts AS
SELECT
    c.first_name,
    c.last_name
FROM
    CHILD c
LEFT JOIN
    CHILD_X_GIFT cxg ON c.id_child = cxg.id_child
WHERE
    cxg.id_gift IS NULL;

-- Представление, которое сохранит только имя и фамилию ребенка без подарка
-- Представление объединяет таблицы "CHILD" и "CHILD_X_GIFT"

--3
CREATE VIEW children_elf AS
SELECT DISTINCT
    ch.first_name AS child_first_name,
    ch.last_name AS child_last_name,
    e.first_name AS elf_first_name,
    e.last_name AS elf_last_name
FROM
    CHILD ch
JOIN
    CHILD_X_GIFT cxg ON ch.id_child = cxg.id_child
JOIN
    GIFT g ON cxg.id_gift = g.id_gift
JOIN
    DELIVERY d ON g.id_delivery = d.id_delivery
LEFT JOIN
    ELF e ON d.id_elf = e.id_elf;

-- Представление предназначено для отображения ребенка и соответствующего ему эльфа.
-- В представлении используется JOIN для объединения таблиц
-- "CHILD", "CHILD_X_GIFT", "GIFT" и "DELIVERY", а также таблицы "ELF".
-- Оператор LEFT JOIN используется для соединения таблицы "ELF" с
-- возможностью наличия записей без соответствующих значений в таблице "DELIVERY"
