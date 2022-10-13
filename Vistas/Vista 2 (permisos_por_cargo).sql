CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `proyecto_final_sql`.`permisos_por_cargo` AS
    (SELECT 
        `proyecto_final_sql`.`rol`.`nombre_rol` AS `Cargo`,
        `per`.`permiso` AS `permiso`
    FROM
        ((`proyecto_final_sql`.`permisos` `per`
        JOIN `proyecto_final_sql`.`rol_permisos` `rolp` ON (`rolp`.`permisos_id` = `per`.`id_permisos`))
        JOIN `proyecto_final_sql`.`rol` ON (`proyecto_final_sql`.`rol`.`id_rol` = `rolp`.`rol_id`)))