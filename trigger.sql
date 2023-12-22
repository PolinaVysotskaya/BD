-- отслеживание изменение страны ребенка
 CREATE OR REPLACE FUNCTION tracking_updates_child_countries()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO CHILDREN_HISTORY(id_child, id_country, valid_from, valid_to)
  VALUES (OLD.id_child, OLD.id_country, OLD.valid_from, NOW());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--DROP TRIGGER tracking_updates ON CHILD;

CREATE TRIGGER tracking_updates_child_history
AFTER UPDATE ON CHILD
FOR EACH ROW EXECUTE PROCEDURE tracking_updates_child_countries();

UPDATE CHILD SET id_country = 8, valid_from = NOW() WHERE id_child = 1;
UPDATE CHILD SET id_country = 8, valid_from = NOW() WHERE id_child = 2;
UPDATE CHILD SET id_country = 5, valid_from = NOW() WHERE id_child = 1;

-- отслеживание изменений позиции эльфов
CREATE OR REPLACE FUNCTION tracking_updates_elf_positions()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO ELF_HISTORY (id_elf, rating, position, pos_valid_from, pos_valid_to)
  VALUES (OLD.id_elf, OLD.rating, OLD.position, OLD.pos_valid_from, NOW());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--DROP TRIGGER tracking_updates ON ELF;

CREATE TRIGGER tracking_updates
AFTER UPDATE ON ELF
FOR EACH ROW EXECUTE PROCEDURE tracking_updates_elf_positions();

UPDATE ELF SET rating = 300, position = 'украшение новогодних подарков', pos_valid_from = NOW() WHERE id_elf = 1;
UPDATE ELF SET rating = 0, position = 'сошел с ума', pos_valid_from = NOW() WHERE id_elf = 3;
UPDATE ELF SET rating = 0, position = 'смог', pos_valid_from = NOW() WHERE id_elf = 3;
