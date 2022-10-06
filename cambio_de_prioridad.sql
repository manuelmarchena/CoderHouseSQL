CREATE DEFINER=`root`@`localhost` PROCEDURE `cambio_de_estado`(IN p_prioridad VARCHAR(20), IN p_nombre VARCHAR(20), IN p_prioridad_nueva INT)
BEGIN
-- Este procedimiento cambia la prioridad de un documento a partir del nombre y la prioridad que tenga
-- Pimero haga un SELECT * FROM documento para tener los nombre_doc y id_prioridad 1 = Alta, 2 = Media, 3 = Baja
-- En el p_prioridad escriba la prioridad en letra y en el segundo con numeros
UPDATE documento AS d
 INNER JOIN
    prioridad AS p ON p.id_prioridad = d.prioridad_id
    SET prioridad_id = p_prioridad_nueva
WHERE
    p.prioridad = p_prioridad
    AND 
    d.nombre_doc = p_nombre;
       
END