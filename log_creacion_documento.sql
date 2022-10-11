CREATE DEFINER=`root`@`localhost` TRIGGER `proyecto_final_sql`.`log_creación_documento` AFTER INSERT ON `documento` FOR EACH ROW
BEGIN
INSERT INTO log_documentos VALUES(NULL, NEW.id_documento, NEW.usuario_id, NOW()); 
-- Guarda un registro de creación de los documentos en el orden en que son creados
END
