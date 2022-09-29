CREATE VIEW `documento_prioridad_baja_DBA` AS
(SELECT 
    doc.nombre_doc, pri.prioridad, est.estado, CONCAT(usu.nombre, ' ', usu.apellido) AS Nombre, rol.nombre_rol 
FROM
    documento AS doc
        INNER JOIN
    prioridad AS pri ON pri.id_prioridad = doc.prioridad_id
        INNER JOIN
    estado AS est ON doc.estado_id = est.id_estado
		INNER JOIN 
	usuario AS usu ON usu.id_usuario = doc.usuario_id
		INNER JOIN 
	rol ON rol.id_rol = usu.rol_id
    WHERE rol.nombre_rol = 'DBA'
    AND est.estado = 'Activo'
    AND pri.prioridad = 'Baja');