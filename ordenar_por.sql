CREATE DEFINER=`root`@`localhost` PROCEDURE `order_by`(IN p_tabla VARCHAR(20), IN p_criterio varchar(20), IN p_orden varchar(4))
BEGIN
SET @tabla = p_tabla;
SET @criterio = p_criterio;
SET @orden = p_orden;
SET @consulta = 'SELECT * FROM '+
	@tabla+ ' ORDER BY( '+ @criterio+') ' + @orden;
PREPARE stmt FROM @consulta ;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
END
