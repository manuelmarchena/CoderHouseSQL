CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `proyecto_final_sql`.`usuarios_por_equipo` AS
    (SELECT 
        `equ`.`nombre` AS `Equipo`,
        `proyecto_final_sql`.`rol`.`nombre_rol` AS `Puesto`,
        CONCAT(`usu`.`nombre`, ' ', `usu`.`apellido`) AS `Nombre`
    FROM
        ((`proyecto_final_sql`.`usuario` `usu`
        JOIN `proyecto_final_sql`.`equipo` `equ` ON (`equ`.`id_equipo` = `usu`.`equipo_id`))
        JOIN `proyecto_final_sql`.`rol` ON (`proyecto_final_sql`.`rol`.`id_rol` = `usu`.`rol_id`)))