CREATE DEFINER=`root`@`localhost` PROCEDURE `cambio_de_estado`(
IN p_prioridad VARCHAR(20), 
IN p_nombre VARCHAR(20)
)
BEGIN

DECLARE v_id_documento INT;
DECLARE v_nombre VARCHAR(60);
DECLARE v_prioridad VARCHAR(20);

SELECT d.id_documento
INTO v_id_documento
FROM documento  AS d 
INNER JOIN
    prioridad AS p ON p.id_prioridad = d.prioridad_id
WHERE
    d.nombre_doc = p_nombre
    AND CASE
     WHEN p_prioridad = 'Alta' THEN d.prioridad_id = 1
     WHEN p_prioridad = 'Media' THEN d.prioridad_id = 2
     WHEN p_prioridad = 'Baja' THEN d.prioridad_id = 3
     END;

IF v_id_documento = '' THEN 
	SELECT 'No existe' AS datosIncorrectos;
    ELSE
		UPDATE documento AS d
        SET d.prioridad_id = CASE
			WHEN p_prioridad = 'Alta' THEN d.prioridad_id = 1
			WHEN p_prioridad = 'Media' THEN d.prioridad_id = 2
			WHEN p_prioridad = 'Baja' THEN d.prioridad_id = 3
	END
    WHERE
		id_documento = v_id_documento;
    SELECT CONCAT('Cambios realizados ', p_nombre, ' tiene prioridad ', p_prioridad) AS datosCorrectos;
    END IF;
/*

  */     
END