CREATE DEFINER=`root`@`localhost` PROCEDURE `proyectos_por_usuario`(
IN p_nombre VARCHAR(60),
IN p_apellido VARCHAR(60),
IN p_order VARCHAR(20)
)
BEGIN
DECLARE v_id_usuario INT;

SELECT us.id_usuario
INTO v_id_usuario
FROM usuario AS us
        WHERE
            us.nombre = p_nombre
                AND us.apellido = p_apellido;
IF v_id_usuario != '' THEN
	IF p_order = 'ASC' OR p_order = 'DESC' THEN
	SELECT
		us.id_usuario,
		us.nombre,
		us.apellido,
		pro.nombre_proyecto
	FROM
		usuario AS us
			INNER JOIN
		equipo AS equi ON us.equipo_id = equi.id_equipo
			INNER JOIN
		proyecto AS pro ON pro.equipo_id = equi.id_equipo
	WHERE
		us.id_usuario = v_id_usuario
        ORDER BY 
        CASE WHEN p_order = 'ASC' THEN pro.nombre_proyecto END ASC,
         CASE WHEN p_order = 'DESC' THEN pro.nombre_proyecto END DESC;
	ELSE
		SELECT 'Solo puede completar con ASC o DESC' AS errormsg; 
        END IF;
    ELSE 
		SELECT 'No existe || Datos erroneos' AS errormsg;
        END IF;
    END