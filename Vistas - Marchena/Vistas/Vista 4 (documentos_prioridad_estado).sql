CREATE VIEW `documentos_prioridad_estado` AS
SELECT 
    doc.nombre_doc, pri.prioridad, est.estado
FROM
    documento AS doc
        INNER JOIN
    prioridad AS pri ON pri.id_prioridad = doc.prioridad_id
        INNER JOIN
    estado AS est ON doc.estado_id = est.id_estado;