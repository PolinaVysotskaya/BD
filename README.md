# BDproject

1. Состав команды: Афанасьева Александра, Высоцкая Полина, Маринина Дарья

Область: вымышленный мир, где Дед Мороз должен проконтролировать доставку подарков детям во всех странах

Список сущностей: 

Факты:
CHILD_X_GIFT

Измерения:
Страна 
Ребенок 
Подарок 
Эльф 
Доставка 
Оплата

2.
БД находится в 2НФ, тк каждая таблица имеет один-к-одному, один-ко-многим или много-ко-многим отношения с другой таблицей. Каждая строка представляет собой отдельную запись, а каждый столбец представляет собой атрибут или характеристику записи. Каждая запись в таблице имеет уникальный идентификатор, который позволяет однозначно идентифицировать каждую запись.

Таблицы ELF и CHILDREN мы делаем версионной, выбрали SCD2, который подразумевает создание отдельной таблицы для хранения исторических данных, в которой каждая запись содержит все изменения поля на протяжении времени.

Поэтому добавим "ELFES_HISTORY", триггер будет создавать запись в таблице "ELFES_HISTORY" каждый раз, когда в таблице "ELF" происходит обновление. В таблице "ELFES_HISTORY" будут храниться старые значения полей эльфа.

Добавим "CHILDREN_HISTORY", триггер будет создавать запись в таблице "CHILDREN_HISTORY" каждый раз, когда в таблице "CHILDREN" происходит обновление. В таблице "CHILDREN_HISTORY" будут храниться старые значения полей детей.

