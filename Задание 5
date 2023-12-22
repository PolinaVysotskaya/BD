
INSERT INTO DELIVERY(delivery_time, delivery_estimate, id_elf) VALUES ('00:03', 10, 10);

DELETE FROM PAYMENT WHERE id_payment = 19;
DELETE FROM PAYMENT WHERE id_payment = 20;

INSERT INTO PAYMENT(id_payment, type_of_payment, "check") VALUES (19, 'by sweets', 1);
INSERT INTO PAYMENT(id_payment, type_of_payment, "check") VALUES (20, 'by a gift', 0);


UPDATE PAYMENT SET type_of_payment = 'by coins' WHERE type_of_payment = 'by cash';
UPDATE ELF SET rating =  18 WHERE id_elf = 10;
INSERT INTO GIFT(gift_name, weight, gift_price, id_delivery) VALUES ('Антон', 34.0, 0, 20);
INSERT INTO CHILD_X_GIFT(id_child, id_gift) VALUES(11,24);

UPDATE CHILD SET gender = 'male' WHERE id_child = 5;

SELECT * FROM DELIVERY WHERE id_elf = 10;
SELECT first_name FROM ELF WHERE position = 'доставка подарков';

-- хотим проверить, что баллы эльфов совпадают с суммой баллов по их доставкам
SELECT ELF.first_name, sum(delivery_estimate), ELF.rating
    FROM DELIVERY
INNER JOIN ELF
    on DELIVERY.id_elf = ELF.id_elf
GROUP BY DELIVERY.id_elf, ELF.first_name, ELF.rating;
