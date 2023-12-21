-- 5 задание
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:03', 8, 10);
INSERT INTO PAYMENT(id_payment, type_of_payment, "check") VALUES (19, 'by sweets', 1);

UPDATE DELIVERY SET delivery_estimate = 0 WHERE id_elf = 6 AND delivery_time = '00:01';
UPDATE PAYMENT SET type_of_payment = 'by coins' WHERE type_of_payment = 'by cash';


DELETE FROM PAYMENT WHERE id_payment = 16;
INSERT INTO PAYMENT(id_payment, type_of_payment, "check") VALUES (16, 'by sweets', 1);
DELETE FROM PAYMENT WHERE id_payment = 19 AND type_of_payment = 'by gift';

SELECT * FROM DELIVERY WHERE  id_elf = 10;

SELECT id_delivery, PAYMENT."check"
    FROM DELIVERY
INNER JOIN PAYMENT
    on id_payment = id_delivery
WHERE delivery_estimate > 5;