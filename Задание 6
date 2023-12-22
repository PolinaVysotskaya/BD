
-- хотим проверить, что баллы эльфов совпадают с суммой баллов по их доставкам
SELECT ELF.first_name, sum(delivery_estimate), ELF.rating
    FROM DELIVERY
INNER JOIN ELF
    on DELIVERY.id_elf = ELF.id_elf
GROUP BY DELIVERY.id_elf, ELF.first_name, ELF.rating;

-- хотим найти подарки с весом больше 1.0 и ценой не меньше 10000, отсортировать по возрастанию веса (потом по цене)
SELECT * FROM GIFT
         WHERE weight > 1.0 AND gift_price >= 10000
ORDER BY weight, gift_price;

-- хотим посчитать количество детей разных полов, которые в новый год получили в подарок электронику
-- если суммарная цена эл.подарков для этого пола больше 120000
SELECT gender, count(CHILD.id_child)
    FROM CHILD
INNER JOIN CHILD_X_GIFT
    on CHILD.id_child= CHILD_X_GIFT.id_child
INNER JOIN GIFT
    on GIFT.id_gift = CHILD_X_GIFT.id_gift
WHERE GIFT.gift_name = 'Часы' OR GIFT.gift_name ='Айфон15' OR
      GIFT.gift_name ='Айфон13' OR GIFT.gift_name ='Наушники' OR
      GIFT.gift_name ='Компьютер' OR GIFT.gift_name ='Планшет'
GROUP BY gender
HAVING sum(gift_price) > 120000;


-- хотим вывести эльфов со средним рейтингом за доставки подарков больше 5
SELECT ELF.first_name, avg(DELIVERY.delivery_estimate)
FROM ELF
INNER JOIN DELIVERY
    on ELF.id_elf= DELIVERY.id_elf
WHERE ELF.position = 'доставка подарков'
GROUP BY ELF.id_elf, ELF.first_name, ELF.position
HAVING avg(DELIVERY.delivery_estimate) > 5;

-- хотим вывести детей с колличеством подарков от наибольшего к наименьшему
SELECT CHILD.first_name, count(GIFT.id_gift), sum(GIFT.gift_price)
FROM CHILD
INNER JOIN CHILD_X_GIFT
    on CHILD.id_child= CHILD_X_GIFT.id_child
INNER JOIN GIFT
    on GIFT.id_gift = CHILD_X_GIFT.id_gift
GROUP BY CHILD.id_child
ORDER BY count(GIFT.id_gift) DESC, sum(GIFT.gift_price) DESC;


-- хотим посмотреть какие подарки получили Полина Высоцкая и Саса Афанасьева
-- (учитывая только подарки оплаченные за конфеты), и какие эльфы их обслуживали
SELECT CHILD.first_name, GIFT.gift_name, ELF.first_name
    FROM CHILD
INNER JOIN CHILD_X_GIFT
    on CHILD.id_child= CHILD_X_GIFT.id_child
INNER JOIN GIFT
    on GIFT.id_gift = CHILD_X_GIFT.id_gift
INNER JOIN DELIVERY
    on GIFT.id_delivery= DELIVERY.id_delivery
INNER JOIN ELF
    on DELIVERY.id_elf= ELF.id_elf
INNER JOIN PAYMENT
    on DELIVERY.id_delivery= PAYMENT.id_payment
WHERE (CHILD.first_name = 'Полина' OR CHILD.first_name = 'Саса') AND type_of_payment = 'by sweets';

-- хотим вывести сколько доставок совершили эльфы из России
SELECT ELF.first_name, count(id_delivery)
FROM ELF
INNER JOIN DELIVERY
on DELIVERY.id_elf = ELF.id_elf
WHERE ELF.id_country IN(
    SELECT COUNTRY.id_country
    FROM COUNTRY
    WHERE name_of_the_country = 'Россия'
)
GROUP BY ELF.first_name;
