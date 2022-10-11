CREATE DEFINER=`root`@`localhost` TRIGGER `proyecto_final_sql`.`log_cambio_rol` AFTER UPDATE ON `usuario` FOR EACH ROW
BEGIN

INSERT INTO cambio_rol VALUES(NULL, CURRENT_USER(), OLD.id_usuario, OLD.rol_id, NEW.rol_id);
-- Este trigger registra los cambios de rol realizados, indicando quien realizó el cambio de rol, cuando lo hizo y el rol anterior del usuario. 

END