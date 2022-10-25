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
I.- Diagrama Entidad- Relacion 				37
1.- CREATE DB 						39
2.- CREATE TABLE					45
    2.1.- departamento					47
    2.2.- estado					55
    2.3.- permisos					63
    2.4.- prioridad					71
    2.5.- rol						79
    2.6.- rol-permisos					87
    2.7.- equipos					100
    2.8.- usuarios					108
    2.9.- tipo						135
    2.10.- proyecto 					143
    2.11.- documento					156
3.- INSERT INTO						182
	3.1.- Por Script				184
		3.1.1.- prioridad			186		
		3.1.2.- tipo				192
		3.1.3.- estado				201
		3.1.4.- permisos			206
        3.1.5.- departamento				216
4.- INSERT INTO para poblar DB 				223
*********************************************/

-- I.- Diagrama Entidad- Relacion 
-- https://drive.google.com/file/d/1gZYTrWMkQPZFyMJP-t8d_0thX_or1LZy/view?usp=sharing
-- 1.- CREATE DB 

CREATE DATABASE IF NOT EXISTS proyecto_final_SQL1;
USE proyecto_final_SQL1;-

-- 2.- CREATE TABLE 

-- 2.1.- departamento

CREATE TABLE IF NOT EXISTS departamento (
    id_depto INT AUTO_INCREMENT NOT NULL,
    depto ENUM('Admin', 'Desarrollo', 'Soporte', 'Infraestructura') NOT NULL,
	PRIMARY KEY(id_depto)
)COMMENT = 'Departamentos que componen la empresa';

-- 2.2.- estado

CREATE TABLE IF NOT EXISTS estado (
    id_estado INT NOT NULL AUTO_INCREMENT,
    estado ENUM('Activo', 'Inactivo') NOT NULL,
    PRIMARY KEY (id_estado)
)COMMENT = 'Estado Activo/Inactivo del Documento, Usuario o Equipo';

-- 2.3.- permisos

CREATE TABLE IF NOT EXISTS permisos(
id_permisos INT NOT NULL AUTO_INCREMENT,
permiso VARCHAR(60) NOT NULL,
PRIMARY KEY(id_permisos)
)COMMENT ='Acciones que puede realizar un rol o Usuario';

-- 2.4.- prioridad

CREATE TABLE IF NOT EXISTS prioridad (
    id_prioridad INT NOT NULL AUTO_INCREMENT,
    prioridad ENUM('Alta', 'Media', 'Baja') NOT NULL,
    PRIMARY KEY(id_prioridad)
)COMMENT ='Necesidad de finalizar rapidamente el documento';

-- 2.5.- rol

CREATE TABLE IF NOT EXISTS rol (
    id_rol INT NOT NULL AUTO_INCREMENT,
    nombre_rol VARCHAR(60) NOT NULL,
    PRIMARY KEY(id_rol)
)COMMENT='Papel que desempeña dentro de la organización que le permite tener autoridad para realizar, o no, ciertas actividades';

-- 2.6.- rol-permisos

CREATE TABLE IF NOT EXISTS rol_permisos (
id_rol_permisos INT NOT NULL AUTO_INCREMENT,
rol_id INT NOT NULL,
permisos_id INT NOT NULL,
PRIMARY KEY(id_rol_permisoS),
FOREIGN KEY(rol_id)
REFERENCES rol(id_rol),
FOREIGN KEY(permisos_id) 
REFERENCES permisos(id_permisos)
) COMMENT = 'Tabla intermedia para hacar perfiles de permisos para cada rol';

-- 2.7.- equipos

CREATE TABLE IF NOT EXISTS equipo (
    id_equipo INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    PRIMARY KEY(id_equipo)
)COMMENT='Conjunto de usuarios con capacidad de desarrollar una actividad';

-- 2.8.- Usuarios

CREATE TABLE IF NOT EXISTS usuario (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    DNI BIGINT NOT NULL UNIQUE,
    usuario VARCHAR(30) NOT NULL UNIQUE,
    contrasena VARCHAR(20) NOT NULL,
    contacto VARCHAR(20) NOT NULL UNIQUE,
    fecha_creacion DATETIME NOT NULL,
    fecha_modificacion DATETIME NOT NULL,
    estado_id INT NOT NULL,
    rol_id INT NOT NULL,
    depto_id INT NOT NULL COMMENT 'Departamento',
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

CREATE TABLE IF NOT EXISTS tipo (
    id_tipo INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(60) NOT NULL,
    PRIMARY KEY (id_tipo)
)COMMENT='Tipo de documento que se realiza, funcional, manu de usuario, entre otros...';

-- 2.10.- proyecto

CREATE TABLE IF NOT EXISTS proyecto (
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

CREATE TABLE IF NOT EXISTS documento (
    id_documento INT NOT NULL AUTO_INCREMENT,
    nombre_doc VARCHAR(100) NOT NULL,
    documento BLOB COMMENT 'Para almacenar el .doc o .PDF',
    fecha_creacion DATETIME NOT NULL,
    fecha_moficacion DATETIME NOT NULL,
    prioridad_id INT NOT NULL,
    estado_id INT NOT NULL,
    usuario_id INT NOT NULL COMMENT 'usuario que creó el dcumento',
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

-- INSERT INTO para poblar DB 

-- equipo
INSERT INTO equipo VALUES('1', 'Parque Patricios' );
INSERT INTO equipo VALUES('2', 'Guemes 1' );
INSERT INTO equipo VALUES('3', 'Guemes 2' );
INSERT INTO equipo VALUES('4', 'Guemes 3' );

-- proyectos
INSERT INTO proyecto VALUES('1', 'Lotlux', '2022-01-11', '2021-10-12', '1');
INSERT INTO proyecto VALUES('2', 'Keylex', '2022-03-09', '2022-09-15', '2');
INSERT INTO proyecto VALUES('3', 'It', '2022-04-04', '2021-09-26', '3');
INSERT INTO proyecto VALUES('4', 'Voyatouch', '2022-06-20', '2022-09-13', '4');
INSERT INTO proyecto VALUES('5', 'Konklab', '2022-02-24', '2022-01-26', '1');
INSERT INTO proyecto VALUES('6', 'Cardify', '2022-05-03', '2021-11-11', '2');
INSERT INTO proyecto VALUES('7', 'Latlux', '2021-11-29', '2022-09-08', '3');
INSERT INTO proyecto VALUES('8', 'Lotlux', '2022-09-10', '2022-05-13', '4');
INSERT INTO proyecto VALUES('9', 'Pannier', '2022-05-13', '2022-02-13', '1');
INSERT INTO proyecto VALUES('10', 'Vagram', '2021-10-26', '2022-02-08', '2');

-- rol
INSERT INTO rol VALUES('1', 'Lider Tecnico');
INSERT INTO rol VALUES('2', 'Desarrollador');
INSERT INTO rol VALUES('3', 'DBA');
INSERT INTO rol VALUES('4', 'DevOps');
INSERT INTO rol VALUES('5', 'Gerente Desarrollo');
INSERT INTO rol VALUES('6', 'Analista Funcional');

-- rol-permisos
INSERT INTO rol_permisos VALUES('1', '1', '1');			
INSERT INTO rol_permisos VALUES('2', '1', '2');			
INSERT INTO rol_permisos VALUES('3', '1', '4');			
INSERT INTO rol_permisos VALUES('4', '1', '3');			
INSERT INTO rol_permisos VALUES('5', '2', '3');			
INSERT INTO rol_permisos VALUES('6', '3', '3');			
INSERT INTO rol_permisos VALUES('7', '3', '4');			
INSERT INTO rol_permisos VALUES('8', '4', '3');			
INSERT INTO rol_permisos VALUES('9', '4', '4');			
INSERT INTO rol_permisos VALUES('10', '5', '1');			
INSERT INTO rol_permisos VALUES('11', '5', '2');			
INSERT INTO rol_permisos VALUES('12', '5', '3');			
INSERT INTO rol_permisos VALUES('13', '5', '4');			
INSERT INTO rol_permisos VALUES('14', '5', '5');			
INSERT INTO rol_permisos VALUES('15', '5', '6');			
INSERT INTO rol_permisos VALUES('16', '5', '7');			
INSERT INTO rol_permisos VALUES('17', '6', '3');			
INSERT INTO rol_permisos VALUES('18', '6', '4');			

-- usuario
INSERT INTO usuario VALUES('1', 'Queenie', 'Hugo', '5439748172', 'qhugo0', '6yqrVgDhMF', '920-267-0530', NOW(), NOW(), '1', '1', '1', '3');
INSERT INTO usuario VALUES('2', 'Tanya', 'Selby', '5508336672', 'tselby1', 'CDBQcVJl', '937-268-7197', NOW(), NOW(), '1', '2', '2', '1');
INSERT INTO usuario VALUES('3', 'Coralie', 'Linklet', '3840917263', 'clinklet2', 'JudrhTTM5PIe', '499-945-1540', NOW(), NOW(), '1', '3', '3', '2');
INSERT INTO usuario VALUES('4', 'Wayland', 'Mennell', '3877391664', 'wmennell3', 'MrgsGryV1ak', '799-151-9103', NOW(), NOW(), '2', '4', '4', '3');
INSERT INTO usuario VALUES('5', 'Bryce', 'MacSporran', '5512381814', 'bmacsporran4', 'NgA2m4kInC', '294-766-6958', NOW(), NOW(), '1', '5', '1', '4');
INSERT INTO usuario VALUES('6', 'Arnold', 'Grimley', '3657535519', 'agrimley5', 'ATlwCEgY6', '147-447-2079', NOW(), NOW(), '1', '1', '2', '1');
INSERT INTO usuario VALUES('7', 'Barde', 'Knottley', '9621670624', 'bknottley6', 'jYa2wzM', '197-997-4838', NOW(), NOW(), '1', '2', '3', '2');
INSERT INTO usuario VALUES('8', 'Bernette', 'McIndrew', '4601490715', 'bmcindrew7', 'UcIOlf', '996-306-8746', NOW(), NOW(), '1', '3', '4', '3');
INSERT INTO usuario VALUES('9', 'Brigid', 'Hartley', '6209582796', 'bhartley8', 'MSvxP1ub', '551-236-7114', NOW(), NOW(), '1', '4', '1', '4');
INSERT INTO usuario VALUES('10', 'Kristofer', 'Pape', '2136371061', 'kpape9', 'DKcRGSBJuG', '876-378-1005', NOW(), NOW(), '1', '5', '2', '1');
INSERT INTO usuario VALUES('11', 'Erinna', 'McGrouther', '8563148192', 'emcgrouthera', 'XwJuq1OrN6ZA', '632-461-9229', NOW(), NOW(), '1', '1', '3', '2');
INSERT INTO usuario VALUES('12', 'Kikelia', 'Mitcheson', '4430280991', 'kmitchesonb', 'KWkuwLWHXrb', '833-310-4697', NOW(), NOW(), '1', '2', '4', '3');
INSERT INTO usuario VALUES('13', 'Agata', 'Vanetti', '4973277797', 'avanettic', 'rRw606LPASQ', '762-578-5988', NOW(), NOW(), '2', '3', '1', '4');
INSERT INTO usuario VALUES('14', 'Haydon', 'Laxon', '7409074523', 'hlaxond', '11E0LwK', '814-593-9980', NOW(), NOW(), '1', '4', '2', '1');
INSERT INTO usuario VALUES('15', 'Lucy', 'Gliddon', '9892766512', 'lgliddone', '5XGwIc3uek', '391-501-4121', NOW(), NOW(), '1', '5', '3', '2');
INSERT INTO usuario VALUES('16', 'Kristoffer', 'Ninotti', '3368589997', 'kninottif', 'P04yhEgeA8f', '769-858-6608', NOW(), NOW(), '1', '1', '4', '3');
INSERT INTO usuario VALUES('17', 'Norine', 'McKernon', '663385652', 'nmckernong', 'yhHV73', '893-416-0942', NOW(), NOW(), '1', '2', '1', '4');
INSERT INTO usuario VALUES('18', 'Petr', 'Boik', '6790865179', 'pboikh', '5EmmSdLo9', '594-533-5480', NOW(), NOW(), '1', '3', '2', '1');
INSERT INTO usuario VALUES('19', 'Bourke', 'Thoresbie', '9848878963', 'bthoresbiei', 'KzB7atD', '354-268-6476', NOW(), NOW(), '1', '4', '3', '2');
INSERT INTO usuario VALUES('20', 'Rodney', 'Flounders', '482635932', 'rfloundersj', '4Zno0g8', '260-600-1607', NOW(), NOW(), '1', '5', '4', '3');
INSERT INTO usuario VALUES('21', 'Barbabas', 'Morrill', '8405496653', 'bmorrillk', '2eIr3nYhc', '165-459-0398', NOW(), NOW(), '1', '1', '1', '4');
INSERT INTO usuario VALUES('22', 'Jamie', 'Samuel', '3758373255', 'jsamuell', '2PCfKgk', '262-356-1860', NOW(), NOW(), '1', '2', '2', '1');
INSERT INTO usuario VALUES('23', 'Verena', 'Luckcock', '7058523401', 'vluckcockm', 'yYwJ6Go', '692-619-5770', NOW(), NOW(), '1', '3', '3', '2');
INSERT INTO usuario VALUES('24', 'Geoffry', 'Baldinotti', '2560967731', 'gbaldinottin', 'tGopjt', '996-321-4155', NOW(), NOW(), '1', '4', '4', '3');
INSERT INTO usuario VALUES('25', 'Georgiana', 'Arden', '2944405772', 'gardeno', '0BSeWbuZ', '116-220-7033', NOW(), NOW(), '1', '5', '1', '4');
INSERT INTO usuario VALUES('26', 'Conroy', 'O Lehane', '9334943068', 'colehanep', 'K6Qpf8mxn6', '260-408-9553', NOW(), NOW(), '1', '1', '2', '1');
INSERT INTO usuario VALUES('27', 'Granthem', 'Melton', '5621932161', 'gmeltonq', 'lGBaqO', '373-813-8703', NOW(), NOW(), '1', '2', '3', '2');
INSERT INTO usuario VALUES('28', 'Flinn', 'Haslock', '7196823648', 'fhaslockr', 'VbAV6sPy', '954-874-6870', NOW(), NOW(), '1', '3', '4', '3');
INSERT INTO usuario VALUES('29', 'Nesta', 'Gerrelts', '3194592106', 'ngerreltss', 'LX7z9Xw2', '631-638-3775', NOW(), NOW(), '1', '4', '1', '4');
INSERT INTO usuario VALUES('30', 'Roscoe', 'Rowell', '6385290581', 'rrowellt', 'ZAdQnz126ue', '810-410-3065', NOW(), NOW(), '1', '5', '2', '1');
INSERT INTO usuario VALUES('31', 'Christabel', 'Gillison', '9137966189', 'cgillisonu', 'Mhc8BWa7tWP', '812-321-8291', NOW(), NOW(), '1', '1', '3', '2');
INSERT INTO usuario VALUES('32', 'Cassaundra', 'McNeillie', '7947055912', 'cmcneilliev', 'o0J8tWo2AxkK', '672-891-2772', NOW(), NOW(), '1', '2', '4', '3');
INSERT INTO usuario VALUES('33', 'Angelica', 'Emes', '4382042933', 'aemesw', 'UVO7PprFqhmF', '740-497-6739', NOW(), NOW(), '1', '3', '1', '4');
INSERT INTO usuario VALUES('34', 'Luisa', 'Phelit', '7141145109', 'lphelitx', 'glxYBJm', '856-706-1863', NOW(), NOW(), '1', '4', '2', '1');
INSERT INTO usuario VALUES('35', 'Mannie', 'Eagling', '1931546053', 'meaglingy', 'GISaxTUov', '626-577-1147', NOW(), NOW(), '1', '5', '3', '2');


-- documentos
INSERT INTO documento VALUES('1', 'Konklux', '2022-04-05', '2021-11-07', '1', '1', '1', '1', '1', '1');
INSERT INTO documento VALUES('2', 'Lotlux', '2022-06-19', '2022-03-28', '2', '2', '2', '2', '2', '2');
INSERT INTO documento VALUES('3', 'Rank', '2022-04-19', '2021-12-20', '3', '3', '1', '3', '3', '3');
INSERT INTO documento VALUES('4', 'Y-Solowarm', '2022-04-20', '2022-06-16', '1', '1', '2', '4', '4', '4');
INSERT INTO documento VALUES('5', 'Hatity', '2022-04-20', '2022-04-13', '2', '2', '1', '5', '5', '5');
INSERT INTO documento VALUES('6', 'Bamity', '2022-04-23', '2021-12-08', '3', '3', '2', '6', '1', '6');
INSERT INTO documento VALUES('7', 'Solarbreeze', '2022-08-30', '2021-09-29', '1', '1', '1', '7', '2', '1');
INSERT INTO documento VALUES('8', 'Stringtough', '2022-08-09', '2022-07-31', '2', '2', '2', '8', '3', '2');
INSERT INTO documento VALUES('9', 'Alpha', '2022-03-28', '2022-01-18', '3', '3', '1', '9', '4', '3');
INSERT INTO documento VALUES('10', 'Flowdesk', '2022-09-05', '2022-09-19', '1', '1', '2', '10', '5', '4');
INSERT INTO documento VALUES('11', 'Voltsillam', '2022-04-08', '2022-01-30', '2', '2', '1', '11', '1', '5');
INSERT INTO documento VALUES('12', 'Treeflex', '2021-10-08', '2022-03-19', '3', '3', '2', '12', '2', '6');
INSERT INTO documento VALUES('13', 'Bigtax', '2022-06-15', '2021-09-26', '1', '1', '1', '13', '3', '1');
INSERT INTO documento VALUES('14', 'Sonsing', '2021-09-24', '2022-01-30', '2', '2', '2', '14', '4', '2');
INSERT INTO documento VALUES('15', 'Latlux', '2022-03-18', '2021-11-26', '3', '3', '1', '15', '5', '3');
INSERT INTO documento VALUES('16', 'Greenlam', '2022-03-26', '2021-12-11', '1', '1', '2', '16', '1', '4');
INSERT INTO documento VALUES('17', 'It', '2022-06-12', '2021-10-20', '2', '2', '1', '17', '2', '5');
INSERT INTO documento VALUES('18', 'Domainer', '2022-04-20', '2022-07-17', '3', '3', '2', '18', '3', '6');
INSERT INTO documento VALUES('19', 'It', '2022-02-23', '2022-05-16', '1', '1', '1', '19', '4', '1');
INSERT INTO documento VALUES('20', 'Stringtough', '2021-10-31', '2022-01-04', '2', '2', '2', '20', '5', '2');
INSERT INTO documento VALUES('25', 'Tringtough', DATE('2021-10-31'), DATE(curdate()), '2', '2', '2', '20', '5', '2');

-- **********************
-- ****** TRIGGERS ******

CREATE TABLE log_documentos (
    registro INT AUTO_INCREMENT,
    usuario_id INT,
    id_documento INT,
    fecha_eliminado DATE,
	hora_eliminado TIME,
    PRIMARY KEY (registro)
    ) COMMENT ='Se registra la modificación de documentos';
    
CREATE TABLE log_eliminados (
doc_eliminados INT AUTO_INCREMENT,
id_documento INT,
fecha_eliminado DATE,
hora_eliminado TIME,
usuario_id INT,
documento BLOB,
proyecto_id INT,
PRIMARY KEY (doc_eliminados)
) COMMENT = 'Se registran los documentos eliminados';

CREATE TABLE log_cambio_rol (
cambio_rol INT AUTO_INCREMENT,
usuario VARCHAR(60),
id_usuario INT,
rol_id INT,
rol_nuevo INT,
fecha_eliminado DATE,
hora_eliminado TIME,
PRIMARY KEY(cambio_rol)
);

CREATE TABLE log_old_records (
  doc_baja int(11) NOT NULL AUTO_INCREMENT,
  id_documento int(11) DEFAULT NULL,
  fecha_eliminado date DEFAULT NULL,
  hora_eliminado time DEFAULT NULL,
  usuario_id int(11) DEFAULT NULL,
  documento blob DEFAULT NULL,
  proyecto_id int(11) DEFAULT NULL,
  PRIMARY KEY (doc_baja)
);

-- Para probar trigger BEFORE DELETE [documento]
DELETE FROM documento 
WHERE
    id_documento = 100;

-- Para probar trigger AFTER INSERT [documento]
INSERT INTO documento VALUES(NULl, 'Tringtough', NOW(), NOW(), '2', '2', '2', '20', '5', '2');

-- Para probar trigger AFTER INSERT [usuario]
SELECT * FROM usuario;
UPDATE usuario
SET rol_id = 2
WHERE id_usuario = 34;

-- Para probar trigger AFTER y BEFORE [usuario]
INSERT INTO usuario VALUES('39', 'Mannie', 'Eagling', '961546053', 'meaglingYY', 'GISaxTUov', '65-577-1147', NOW() , NOW(), '1', '5', '3', '2');

SHOW TRIGGERS FROM proyecto_final_sql;
