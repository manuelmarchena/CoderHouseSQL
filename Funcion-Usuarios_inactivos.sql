CREATE DEFINER=`root`@`localhost` FUNCTION `Ususarios_inactivos`(p_DNI BIGINT, p_equipo VARCHAR(10)) RETURNS varchar(10) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
DECLARE v_estado VARCHAR(10);

SELECT e.estado
INTO v_estado
FROM usuario AS u
 INNER JOIN
    estado AS e ON u.estado_id = e.id_estado
        INNER JOIN
    equipo AS eq ON eq.id_equipo = u.equipo_id
WHERE
	eq.nombre = p_equipo AND u.DNI= p_DNI;
RETURN v_estado;
END
