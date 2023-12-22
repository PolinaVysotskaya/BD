-- триггер срабатывает после каждого UPDATE ELF_HISTORY

CREATE OR REPLACE FUNCTION tracking_updates_elf_positions()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO ELF_HISTORY (id_elf, rating, position, pos_valid_from, pos_valid_to)
  VALUES (OLD.id_elf, OLD.rating, OLD.position, NEW.pos_valid_from, NOW());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--DROP TRIGGER tracking_updates ON ELF;

CREATE TRIGGER tracking_updates
AFTER UPDATE ON ELF
FOR EACH ROW EXECUTE PROCEDURE tracking_updates_elf_positions();

UPDATE ELF SET rating = 300, position = 'украшение новогодних подарков', pos_valid_from = NOW() WHERE id_elf = 1;
UPDATE ELF SET rating = 16666, position = 'больше не эльф', pos_valid_from = NOW() WHERE id_elf = 1;
UPDATE ELF SET rating = 0, position = 'больше не эльф' WHERE id_elf = 4; --сработает
UPDATE ELF SET rating = 5, position = 'больше не эльф' WHERE id_elf = 4; -- не сработает

