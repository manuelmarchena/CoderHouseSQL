CREATE DEFINER=`root`@`localhost` FUNCTION `documento_demorado`(p_nombre_documento VARCHAR(100)) RETURNS varchar(60) CHARSET utf8mb4
    DETERMINISTIC
BEGIN

DECLARE v_documento VARCHAR(60);

SELECT DISTINCT 
    d.documento
INTO v_documento
FROM
    documento AS d
        INNER JOIN
    prioridad AS p ON d.prioridad_id = p.id_prioridad
WHERE
    p.prioridad = 'Alta'
       AND DATE_ADD(d.fecha_creacion,
       INTERVAL 180 DAY)< '2022-07-01'
        AND d.nombre_doc = p_nombre_documento;
RETURN v_documento;
END
