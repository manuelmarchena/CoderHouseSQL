CREATE DEFINER=`root`@`localhost` PROCEDURE `order_by`(IN p_tabla VARCHAR(20), IN p_columna varchar(20), IN p_orden varchar(4))
BEGIN
SET @consulta = CONCAT('SELECT * FROM ',p_tabla, ' ORDER BY ', p_columna, ' ', p_orden);
PREPARE stmt FROM @consulta;
EXECUTE stmt;
END
