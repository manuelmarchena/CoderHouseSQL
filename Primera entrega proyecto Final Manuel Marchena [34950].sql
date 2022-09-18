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
1.- CREATE DB 								30
2.- CREATE TABLE							35
	2.1.- departamento						37
    2.2.- estado							45
    2.3.- permisos							52
    2.4.- prioridad							60
    2.5.- rol								68
    2.6.- equipos							79
	2.7.- Usuarios							91
    2.8.- tipo								117
	2.9.- proyecto 							125
	2.10.- documento						140
*********************************************/

-- I.- Diagrama Entidad- Relacion 
-- https://drive.google.com/file/d/1gZYTrWMkQPZFyMJP-t8d_0thX_or1LZy/view?usp=sharing
-- 1.- CREATE DB 

CREATE DATABASE IF NOT EXISTS proyecto_final_SQL1;
USE proyecto_final_SQL1;

-- 2.- CREATE TABLE 

-- 2.1.- departamento

CREATE TABLE departamento (
    id_depto INT AUTO_INCREMENT NOT NULL,
    departamento ENUM('Admin', 'Desarrollo', 'Soporte', 'Infraestructura') NOT NULL,
	PRIMARY KEY(id_depto)
);

-- 2.2.- estado

CREATE TABLE estado (
    id_estado INT NOT NULL AUTO_INCREMENT,
    estado ENUM('Activo', 'Inactivo') NOT NULL,
    PRIMARY KEY (id_estado)
);
-- 2.3.- permisos

CREATE TABLE permisos(
id_permisos INT NOT NULL AUTO_INCREMENT,
permiso VARCHAR(60) NOT NULL,
PRIMARY KEY(id_permisos)
);

-- 2.4.- prioridad

CREATE TABLE prioridad (
    id_prioridad INT NOT NULL AUTO_INCREMENT,
    prioridad ENUM('Alta', 'Media', 'Baja') NOT NULL,
    PRIMARY KEY(id_prioridad)
);

-- 2.5.- rol

CREATE TABLE rol (
    id_rol INT NOT NULL AUTO_INCREMENT,
    nombre_rol VARCHAR(60) NOT NULL,
    permisos_id INT NOT NULL,
    PRIMARY KEY(id_rol),
    FOREIGN KEY(permisos_id) 
		REFERENCES permisos(id_permisos)
);

-- 2.6.- equipos

CREATE TABLE equipo (
    id_equipo INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    usuario_id INT NOT NULL,
    estado_id INT NOT NULL,
    PRIMARY KEY(id_equipo),
    FOREIGN KEY (estado_id)
        REFERENCES estado (id_estado)
);

-- 2.7.- Usuarios

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

-- 2.8.- tipo

CREATE TABLE tipo (
    id_tipo INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(60) NOT NULL,
    PRIMARY KEY (id_tipo)
);

-- 2.9.- proyecto

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

-- 2.10.- Documentos

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

