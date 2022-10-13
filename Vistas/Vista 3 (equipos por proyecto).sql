CREATE VIEW `equipos_por_proyecto` AS
(SELECT 
    pro.nombre_proyecto,
    equ.nombre,
    CONCAT(usu.nombre, ' ', usu.apellido) AS nombre,
    rol.nombre_rol
FROM
    proyecto AS pro
        INNER JOIN
    equipo AS equ ON pro.equipo_id = equ.id_equipo
        INNER JOIN
    usuario AS usu ON equ.id_equipo = usu.equipo_id
        INNER JOIN
    rol ON rol.id_rol = usu.rol_id);