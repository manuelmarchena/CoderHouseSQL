/********************************************
CONTROL DE DOCUMENTACIÓN DE PROYECTOS
********************************************/
/* 	IDENTIFICACIÓN
	• Autor: Manuel Marchena
	• CODERHOUSE
    • SQL Comisión 34950
		- Primera entrega proyecto final
*/

/*******************************************
					INDICE
	Contenido							  Linea
I.- Diagrama Entidad- Relacion 				32
1.- Descripción teórica del proyecto		35
2.- Definición de la DB						43
3.- Tablas contenidas en la Base de Datos	49
4.- CREATE DB 								64
5.- CREATE TABLE							69
	5.1.- departamento						73
    5.2.- estado							97
    5.3.- permisos							118
    5.4.- prioridad							138
    5.5.- rol								158
    5.6.- equipos							188
	5.7.- Usuarios							219
    5.7.- tipo								280
	5.9.- proyecto 							304
	5.2.- documento							342
*********************************************/

-- I.- Diagrama Entidad- Relacion 
-- https://drive.google.com/file/d/1gZYTrWMkQPZFyMJP-t8d_0thX_or1LZy/view?usp=sharing

/* 1.- DESCRIPCIÓN TEÓRICA DEL POYECTO
La base de datos estará estructurada de manera que podrá almacenar la documentación
de los proyectos (definición funcional de Backend, Frontend, Manuales de usuario, 
entre otros...), los usuarios que forman parte de los equipos tendrán acceso a los 
proyectos y a la documentación, dependiendo del rol de estos podran tener permisos a 
realizar gestiones sobre la documentación y garantizar la confiabilidad de los datos.
*/

/* 2.- DEFINICIÓN DE LA BASE DE DATOS
 
La base de datos esta identificada como "proyecto_final_SQL" en esta se creará todas 
las tablas del proyecto, consultas y demás. 
*/

/* 3.- TABLAS QUE CONTENIDAS EN LA BASE DE DATOS
La base de datos esta compuesta por las siguientes tablas:

• Departamento
• Documentos
• Estado
• Equipos
• Permisos
• Prioridad
• Proyectos
• Rol
• Tipo
• Usuarios
*/

-- 4.- CREATE DB 

CREATE DATABASE IF NOT EXISTS proyecto_final_SQL;
USE proyecto_final_SQL;

-- 5.- CREATE TABLE 
/* 
El orden en que se presentan las tablas no tiene ninguna razón particular
*/
-- 5.1.- departamento
/********************************************
** La columna extra, es lo que da el desc table, aproveché la misma estructura
   del Worckbench
Departamento se refiere a las diferentes unidades organizacionales como esta
dividida la empresa, para efectos de garantizar la homogeneidad de los datos
se le asigno como data type un ENUM
+----------------------------------------------+
| 				Departamento                   |
+----------+------------+-------+------+-------+
| field    | data type  | null  | key  | extra |
+----------+------------+-------+------+-------+
| id_dpto  | INT        | NO    | PK   | AI    |
+----------+------------+-------+------+-------+
| dpto     | ENUM       | NO    |      |       |
+----------+------------+-------+------+-------+

***********************************************/
    
CREATE TABLE departamento (
    id_depto INT AUTO_INCREMENT NOT NULL,
    departamento ENUM('Admin', 'Desarrollo', 'Soporte', 'Infraestructura') NOT NULL,
	PRIMARY KEY(id_depto)
);

-- 5.2.- estado
/********************************************
Los estados son para definir si el documento se encuentra vigente aun, tiene
validez o no

+------------------------------------------------+
|                     Estado                     |
+------------+------------+-------+------+-------+
| field      | data type  | null  | key  | extra |
+------------+------------+-------+------+-------+
| id_estado  | INT        | NO    | PK   | AI    |
+------------+------------+-------+------+-------+
| estado     | ENUM       | NO    |      |       |
+------------+------------+-------+------+-------+

********************************************/

CREATE TABLE estado (
    id_estado INT NOT NULL AUTO_INCREMENT,
    estado ENUM('Activo', 'Inactivo') NOT NULL,
    PRIMARY KEY (id_estado)
);
-- 5.3.- permisos
/********************************************
Son las diferentes acciones a las que tendrá acceso un usuario,
dependiendo de su rol o permisos concedidos podra eliminar,
agregar, modificar, crear ususarios, roles, permisos o documentos
+------------------------------------------------+
|                    Permisos                    |
+------------+--------------+------+-----+-------+
| field      | data type    | null | key | extra |
+------------+--------------+------+-----+-------+
| id_permiso | INT          | NO   | PK  | AI    |
+------------+--------------+------+-----+-------+
| permiso    | VARCHAR(100) | NO   |     |       |
+------------+--------------+------+-----+-------+
********************************************/
CREATE TABLE permisos(
id_permisos INT NOT NULL AUTO_INCREMENT,
permiso VARCHAR(60) NOT NULL,
PRIMARY KEY(id_permisos)
);

-- 5.4.- prioridad
/********************************************
La prioridad define que la urgencia con la que se debe finalizar el documento

+---------------------------------------------------+
|                     Prioridad                     |
+---------------+------------+-------+------+-------+
| field         | data type  | null  | key  | extra |
+---------------+------------+-------+------+-------+
| id_prioridad  | INT        | NO    | PK   | AI    |
+---------------+------------+-------+------+-------+
| prioridad     | ENUM       | NO    |      |       |
+---------------+------------+-------+------+-------+
********************************************/

CREATE TABLE prioridad (
    id_prioridad INT NOT NULL AUTO_INCREMENT,
    prioridad ENUM('Alta', 'Media', 'Baja') NOT NULL,
    PRIMARY KEY(id_prioridad)
);

-- 5.5.- rol
/********************************************
Dependiendo del rol que tengan dentro del equipo podrán realizar diferentes acciones o
verificar la información
+----------------------------------------------------+
|                         Rol                        |
+-------------+---------------+-------+------+-------+
| field       | data type     | null  | key  | extra |
+-------------+---------------+-------+------+-------+
| id_rol      | INT           | NO    | PK   | AI    |
+-------------+---------------+-------+------+-------+
| nombre_rol  | VARCHAR(60)  | NO    |      |       |
+-------------+---------------+-------+------+-------+

********************************************/


CREATE TABLE rol (
    id_rol INT NOT NULL AUTO_INCREMENT,
    nombre_rol VARCHAR(60) NOT NULL,
    permisos_id INT NOT NULL,
    PRIMARY KEY(id_rol),
    FOREIGN KEY(permisos_id) 
		REFERENCES permisos(id_permisos)
);

-- 5.6.- equipos
/*******************************************
Son los grupos de personasresponsables del desarrollo y soporte compuesto
por desarrolladores BackEnd, FrontEnd, Tech Leader y Project Manager

+------------------------------------------------+
|                     Equipo                     |
+------------+--------------+------+-----+-------+
| field      | data type    | null | key | extra |
+------------+--------------+------+-----+-------+
| id_equipo  | INT          | NO   | PK  | AI    |
+------------+--------------+------+-----+-------+
| nombre     | VARCHAR(100) | NO   |     |       |
+------------+--------------+------+-----+-------+
| usuario_id | INT          | NO   | FK  |       |
+------------+--------------+------+-----+-------+
| estado_id  | INT          | NO   | FK  |       |
+------------+--------------+------+-----+-------+

*******************************************/

CREATE TABLE equipo (
    id_equipo INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    usuario_id INT NOT NULL,
    estado_id INT NOT NULL,
    PRIMARY KEY(id_equipo),
    FOREIGN KEY (estado_id)
        REFERENCES estado (id_estado)
);

-- 5.7.- Usuarios
/********************************************
Son los usuarios que participan en los proyectos y tienen acceso a los documento

+--------------------------------------------------------------+
|                            Usuario                           |
+---------------------+---------------+-------+--------+-------+
| field               | data type     | null  | key    | extra |
+---------------------+---------------+-------+--------+-------+
| id_usuario          | INT           | NO    | PK     | AI    |
+---------------------+---------------+-------+--------+-------+
| nombre              | VARCHAR(100)  | NO    |        |       |
+---------------------+---------------+-------+--------+-------+
| apellido            | VARCHAR(100)  | NO    |        |       |
+---------------------+---------------+-------+--------+-------+
| DNI                 | BIGINT        | NO    | UNIQUE |       |
+---------------------+---------------+-------+--------+-------+
| contrasena          | VARCHAR(20)   | NO    |        |       |
+---------------------+---------------+-------+--------+-------+
| usuario             | VARCHAR(20)   | NO    |        |       |
+---------------------+---------------+-------+--------+-------+
| fecha_creacion      | DATETIME      | NO    |        |       |
+---------------------+---------------+-------+--------+-------+
| fecha_modificacion  | DATETIME      | NO    |        |       |
+---------------------+---------------+-------+--------+-------+
| estado_id           | INT           | NO    | FK     |       |
+---------------------+---------------+-------+--------+-------+
| rol_id              | INT           | NO    | FK     |       |
+---------------------+---------------+-------+--------+-------+
| equipo_id           | INT           | NO    | FK     |       |
+---------------------+---------------+-------+--------+-------+
| departamento_ id    | INT           | NO    | FK     |       |
+---------------------+---------------+-------+--------+-------+


********************************************/

CREATE TABLE usuario (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    DNI BIGINT NOT NULL UNIQUE,
    contrasena VARCHAR(20) NOT NULL,
    usuario VARCHAR(20) NOT NULL,
    fecha_creacion DATETIME NOT NULL,
    fecha_modificacion DATETIME NOT NULL,
    estado_id INT NOT NULL,
    rol_id INT NOT NULL,
    depto_id INT NOT NULL,
    equipo_id INT NOT NULL,
    PRIMARY KEY (id_usuario),
	FOREIGN KEY (estado_id)
        REFERENCES estado (id_estado),
	FOREIGN KEY (rol_id)
        REFERENCES rol (id_rol),
	FOREIGN KEY (depto_id)
        REFERENCES departamento (id_depto),
	 FOREIGN KEY (equipo_id)
        REFERENCES equipo (id_equipo)
);

-- 5.7.- tipo
/*******************************************
Define que tipo de documento se esta ingresando en la DB, definición funcional, manual
de usuario, entre otros...

+-------------------------------------------------+
|                       Tipo                      |
+----------+---------------+-------+------+-------+
| field    | data type     | null  | key  | extra |
+----------+---------------+-------+------+-------+
| id_tipo  | INT           | NO    | PK   | AI    |
+----------+---------------+-------+------+-------+
| tipo     | VARCHAR(100)  | NO    |      |       |
+----------+---------------+-------+------+-------+

*******************************************/

CREATE TABLE tipo (
    id_tipo INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(60) NOT NULL,
    PRIMARY KEY (id_tipo)
);


-- 5.9.- proyecto
/********************************************
Cada proyecto es asigando a un equipo que será responsable de su desarrollo 
y soporte, estos son los que tienen acceso al proyecto y su documentación. 

+------------------------------------------------------------+
|                          Proyecto                          |
+---------------------+---------------+-------+------+-------+
| field               | data type     | null  | key  | extra |
+---------------------+---------------+-------+------+-------+
| id_proyecto         | INT           | NO    | PK   | AI    |
+---------------------+---------------+-------+------+-------+
| nombre_proyecto     | VARCHAR(100)  | NO    |      |       |
+---------------------+---------------+-------+------+-------+
| fecha_creacion      | TIMESTAMP      | NO    |      |       |
+---------------------+---------------+-------+------+-------+
| fecha_modificacion  | TIMESTAMP    | NO    |      |       |
+---------------------+---------------+-------+------+-------+
| equipo_id          | INT           | NO    | FK   |       |
+---------------------+---------------+-------+------+-------+
| estado_id           | INT           | NO    | FK   |       |
+---------------------+---------------+-------+------+-------+

*******************************************/

CREATE TABLE proyecto (
    id_proyecto INT NOT NULL AUTO_INCREMENT,
    fecha_creacion DATE,
    fecha_modificacion DATE,
    equipo_id INT NOT NULL,
    estado_id INT NOT NULL,
    PRIMARY KEY(id_proyecto),
    FOREIGN KEY (equipo_id)
		REFERENCES equipo(id_equipo),
	FOREIGN KEY (estado_id)
        REFERENCES estado (id_estado)
);

-- 5.10.- Documentos
/********************************************
Los documentos para almacenar serán las definiciones funcionales, manuales 
de usuarios y el documento que se realizó, la estructura de la tabla se 
espera contenga los datos necesarios para identificar el documento.

+----------------------------------------------------------+
|                         Documento                        |
+-------------------+---------------+-------+------+-------+
| field             | data type     | null  | key  | extra |
+-------------------+---------------+-------+------+-------+
| id_documento      | INT           | NO    | PK   | AI    |
+-------------------+---------------+-------+------+-------+
| nombre_doc        | VARCHAR(100)  | NO    |      |       |
+-------------------+---------------+-------+------+-------+
| documento         | BLOB          | SI    |      |       |
+-------------------+---------------+-------+------+-------+
| fecha_creacion    | DATETIME      | NO    |      |       |
+-------------------+---------------+-------+------+-------+
| fecha_moficacion  | DATETIME      | NO    |      |       |
+-------------------+---------------+-------+------+-------+
| prioridad_id      | INT           | NO    | FK   |       |
+-------------------+---------------+-------+------+-------+
| estado_id         | INT           | NO    | FK   |       |
+-------------------+---------------+-------+------+-------+
| usuario_id        | INT           | NO    | FK   |       |
+-------------------+---------------+-------+------+-------+
| proyecto_id       | INT           | NO    | FK   |       |
+-------------------+---------------+-------+------+-------+
| tipo_id           | INT           | NO    | FK   |       |
+-------------------+---------------+-------+------+-------+
********************************************/



CREATE TABLE documento (
    id_documento INT NOT NULL AUTO_INCREMENT,
    nombre_doc VARCHAR(100) NOT NULL,
    documento BLOB,
    fecha_creacion DATETIME NOT NULL,
    fecha_moficacion DATETIME NOT NULL,
    prioridad_id INT NOT NULL,
    estado_id INT NOT NULL,
    usuario_id INT NOT NULL,
    proyecto_id INT NOT NULL,
    tipo_id INT NOT NULL,
    PRIMARY KEY (id_documento),
    FOREIGN KEY (prioridad_id)
        REFERENCES prioridad (id_prioridad),
    FOREIGN KEY (estado_id)
        REFERENCES estado (id_estado),
    FOREIGN KEY (usuario_id)
        REFERENCES usuario (id_usuario),
    FOREIGN KEY (proyecto_id)
        REFERENCES proyecto (id_proyecto),
    FOREIGN KEY (tipo_id)
        REFERENCES tipo (id_tipo)
);

