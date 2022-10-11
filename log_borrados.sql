CREATE DEFINER=`root`@`localhost` TRIGGER `proyecto_final_sql`.`log_borrados` BEFORE DELETE ON `documento` FOR EACH ROW
BEGIN
INSERT INTO old_records VALUES (NULL, OLD.id_documento, CURRENT_DATE(), CURRENT_TIME(), OLD.usuario_id, OLD.documento, OLD.proyecto_id);
-- Guarda una copia de los documentos que son eliminados de las DB
END
