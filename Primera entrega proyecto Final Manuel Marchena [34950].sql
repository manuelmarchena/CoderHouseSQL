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
I.- Diagrama Entidad- Relacion 				41
1.- CREATE DB 								38
2.- CREATE TABLE							43
    2.1.- departamento						45
    2.2.- estado							53
    2.3.- permisos							61
    2.4.- prioridad							69
    2.5.- rol								77
    2.6.- rol-permisos						86
    2.7.- equipos							99
    2.8.- usuarios							111
    2.9.- tipo								138
    2.10.- proyecto 						146
    2.11.- documento						159
3.- INSERT INTO								185
	3.1.- Por Script						187
		3.1.1.- prioridad					189
		3.1.2.- tipo						195
		3.1.3.- estado						204
		3.1.4.- permisos					209
		3.1.5.- departamento				219
*********************************************/

-- I.- Diagrama Entidad- Relacion 
-- https://drive.google.com/file/d/1gZYTrWMkQPZFyMJP-t8d_0thX_or1LZy/view?usp=sharing
-- 1.- CREATE DB 

CREATE DATABASE IF NOT EXISTS proyecto_final_SQL;
USE proyecto_final_SQL;-

-- 2.- CREATE TABLE 

-- 2.1.- departamento

CREATE TABLE departamento (
    id_depto INT AUTO_INCREMENT NOT NULL,
    departamento ENUM('Admin', 'Desarrollo', 'Soporte', 'Infraestructura') NOT NULL,
	PRIMARY KEY(id_depto)
)COMMENT = 'Departamentos que componen la empresa';

-- 2.2.- estado

CREATE TABLE estado (
    id_estado INT NOT NULL AUTO_INCREMENT,
    estado ENUM('Activo', 'Inactivo') NOT NULL,
    PRIMARY KEY (id_estado)
)COMMENT = 'Estado Activo/Inactivo del Documento, Usuario o Equipo';

-- 2.3.- permisos

CREATE TABLE permisos(
id_permisos INT NOT NULL AUTO_INCREMENT,
permiso VARCHAR(60) NOT NULL,
PRIMARY KEY(id_permisos)
)COMMENT ='Acciones que puede realizar un rol o Usuario';

-- 2.4.- prioridad

CREATE TABLE prioridad (
    id_prioridad INT NOT NULL AUTO_INCREMENT,
    prioridad ENUM('Alta', 'Media', 'Baja') NOT NULL,
    PRIMARY KEY(id_prioridad)
)COMMENT ='Necesidad de finalizar rapidamente el documento';

-- 2.5.- rol

CREATE TABLE rol (
    id_rol INT NOT NULL AUTO_INCREMENT,
    nombre_rol VARCHAR(60) NOT NULL,
    PRIMARY KEY(id_rol)
)COMMENT='Papel que desempeña dentro de la organización que le permite tener autoridad para realizar o no ciertas actividades';

-- 2.6.- rol-permisos

CREATE TABLE rol_permisos (
id_rol_permiso INT NOT NULL AUTO_INCREMENT,
rol_id INT NOT NULL,
permisos_id INT NOT NULL,
PRIMARY KEY(id_rol_permiso),
FOREIGN KEY(rol_id)
REFERENCES rol(id_rol),
FOREIGN KEY(permisos_id) 
REFERENCES permisos(id_permisos)
) COMMENT = 'Tabla intermedia para hacar perfiles de permisos para cada rol';

-- 2.7.- equipos

CREATE TABLE equipo (
    id_equipo INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    estado_id INT NOT NULL,
    PRIMARY KEY(id_equipo),
    FOREIGN KEY (estado_id)
        REFERENCES estado (id_estado)
)COMMENT='Conjunto de usuarios con capacidad de desarrollar una actividad';

-- 2.8.- Usuarios

CREATE TABLE usuario (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    DNI BIGINT NOT NULL UNIQUE,
    usuario VARCHAR(30) NOT NULL UNIQUE,
    contrasena VARCHAR(20) NOT NULL,
    contacto VARCHAR(20) NOT NULL,
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
)COMMENT ='Persona responsable del desarrollo de actividades que pertenece a un equipo, tiene un rol con permisos e identificación';

-- 2.9.- tipo

CREATE TABLE tipo (
    id_tipo INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(60) NOT NULL,
    PRIMARY KEY (id_tipo)
)COMMENT='Tipo de documento que se realiza, funcional, manu de usuario, entre otros...';

-- 2.10.- proyecto

CREATE TABLE proyecto (
    id_proyecto INT NOT NULL AUTO_INCREMENT,
    nombre_proyecto VARCHAR(70),
    fecha_creacion DATE,
    fecha_modificacion DATE,
    equipo_id INT NOT NULL,
    PRIMARY KEY(id_proyecto),
    FOREIGN KEY (equipo_id)
		REFERENCES equipo(id_equipo)
)COMMENT='Identificación del proyecto y el equipo responsable de su desarrollo y soporte';

-- 2.11.- Documentos

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
)COMMENT='Identificación y descripción del documento, prioridad, estado, usuario responsable, proyecto al que pertenece y tipo';

-- 3.- INSERT INTO

-- 3.1.- Por Script

-- 3.1.1.- prioridad

INSERT INTO prioridad (prioridad) VALUES('Alta');
INSERT INTO prioridad (prioridad) VALUES('Media');
INSERT INTO prioridad (prioridad) VALUES('Baja');

-- 3.1.2 tipo

INSERT INTO tipo VALUES ('1', 'Analisis Funcional');
INSERT INTO tipo VALUES ('2', 'Relevamiento de requisitos');
INSERT INTO tipo VALUES ('3', 'Analisis Funcional [BackEnd]');
INSERT INTO tipo VALUES ('4', 'Analisis Funcional [FrontEnd]');
INSERT INTO tipo VALUES ('5', 'Analisis funcional [Refactorización]');
INSERT INTO tipo VALUES ('6', 'Manual de usuario');

-- 3.1.3 estado

INSERT INTO estado (id_estado, estado) VALUES('1','Activo');
INSERT INTO estado (id_estado, estado) VALUES('2','Inactivo');

-- 3.1.4 permisos

INSERT INTO permisos (permiso) VALUES ('Crear Usuario'); 
INSERT INTO permisos (permiso) VALUES ('Eliminar Usuario');
INSERT INTO permisos (permiso) VALUES ('Crear Documento');
INSERT INTO permisos (permiso) VALUES ('Editar Documento'); 
INSERT INTO permisos (permiso) VALUES ('Crear Proyecto');
INSERT INTO permisos (permiso) VALUES ('Eliminar Proyecto');
INSERT INTO permisos (permiso) VALUES ('Asignar Equipo');

-- 3.1.5 departamento

INSERT INTO departamento VALUES ('1','Admin'); 
INSERT INTO departamento VALUES ('2','Desarrollo');
INSERT INTO departamento VALUES ('3','Soporte');
INSERT INTO departamento VALUES ('4','Infraestructura');




