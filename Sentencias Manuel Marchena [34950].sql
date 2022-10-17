/********************************************
		SENTENCIAS
********************************************/
/* 	IDENTIFICACIÓN
	• Autor: Manuel Marchena
	• CODERHOUSE
    • SQL Comisión 34950
		- Sentencias
*/

/*******************************************

CREATE USER 'GteDesarrollo'@'localhost' IDENTIFIED BY 'gT3D3s4rr0ll0';

CREATE USER 'Desarrollador'@'localhost' IDENTIFIED BY 'D3s4RROlL4d0r';

GRANT SELECT ON proyecto_final_sql.* TO 'Desarrollador';

DELETE FROM documento 
WHERE
    id_documento = 30;
    
GRANT SELECT, INSERT, UPDATE ON proyecto_final_sql.* TO 'GteDesarrollo';

DELETE FROM usuario 
WHERE
    id_usuario = 40;
