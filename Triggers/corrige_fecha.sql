CREATE DEFINER=`root`@`localhost` TRIGGER `proyecto_final_sql`.`corrige_fecha` BEFORE UPDATE ON `usuario` FOR EACH ROW
BEGIN
UPDATE usuario
SET fecha_modificacion = CURRENT_DATE()
WHERE fecha_modificación = '0000-00-00 00:00:00';
-- Modifica la fecha cuando se cargó de forma erronea
END