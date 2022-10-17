CREATE DEFINER=`root`@`localhost` TRIGGER `proyecto_final_sql`.`historial_contacto` BEFORE UPDATE ON `usuario` FOR EACH ROW
BEGIN
INSERT INTO historial_contacto VALUES (id_usuario, CURRENT_USER(), OLD.contacto, CURRENT_DATE(), CURRENT_TIME());
END
