-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.21-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.0.0.6468
-- --------------------------------------------------------

/***********************************************
		TABLAS EXPORTADAS

- Departamento
- Documento
- Equipo
- Permisos
- Prioridad
- Proyecto
- Rol
- Rol_permisos
- Tipo
- Usuario

************************************************/


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Volcando estructura para tabla proyecto_final_sql.departamento
CREATE TABLE IF NOT EXISTS `departamento` (
  `id_depto` int(11) NOT NULL AUTO_INCREMENT,
  `depto` enum('Admin','Desarrollo','Soporte','Infraestructura') NOT NULL,
  PRIMARY KEY (`id_depto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='Departamentos que componen la empresa';

-- Volcando datos para la tabla proyecto_final_sql.departamento: ~4 rows (aproximadamente)
DELETE FROM `departamento`;
INSERT INTO `departamento` (`id_depto`, `depto`) VALUES
	(1, 'Admin'),
	(2, 'Desarrollo'),
	(3, 'Soporte'),
	(4, 'Infraestructura');

-- Volcando estructura para tabla proyecto_final_sql.documento
CREATE TABLE IF NOT EXISTS `documento` (
  `id_documento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_doc` varchar(100) NOT NULL,
  `documento` blob DEFAULT NULL COMMENT 'Para almacenar el .doc o .PDF',
  `fecha_creacion` date NOT NULL,
  `fecha_moficacion` date NOT NULL,
  `prioridad_id` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL COMMENT 'usuario que creó el dcumento',
  `proyecto_id` int(11) NOT NULL,
  `tipo_id` int(11) NOT NULL,
  PRIMARY KEY (`id_documento`),
  KEY `prioridad_id` (`prioridad_id`),
  KEY `estado_id` (`estado_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `proyecto_id` (`proyecto_id`),
  KEY `tipo_id` (`tipo_id`),
  CONSTRAINT `documento_ibfk_1` FOREIGN KEY (`prioridad_id`) REFERENCES `prioridad` (`id_prioridad`),
  CONSTRAINT `documento_ibfk_2` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id_estado`),
  CONSTRAINT `documento_ibfk_3` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `documento_ibfk_4` FOREIGN KEY (`proyecto_id`) REFERENCES `proyecto` (`id_proyecto`),
  CONSTRAINT `documento_ibfk_5` FOREIGN KEY (`tipo_id`) REFERENCES `tipo` (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COMMENT='Identificación y descripción del documento, prioridad, estado, usuario responsable, proyecto al que pertenece y tipo';

-- Volcando datos para la tabla proyecto_final_sql.documento: ~20 rows (aproximadamente)
DELETE FROM `documento`;
INSERT INTO `documento` (`id_documento`, `nombre_doc`, `documento`, `fecha_creacion`, `fecha_moficacion`, `prioridad_id`, `estado_id`, `usuario_id`, `proyecto_id`, `tipo_id`) VALUES
	(1, 'Konklux', NULL, '2022-10-28', '2022-10-28', 1, 1, 1, 1, 1),
	(2, 'Lotlux', NULL, '2022-10-28', '2022-10-28', 2, 2, 2, 2, 2),
	(3, 'Rank', NULL, '2022-10-28', '2022-10-28', 3, 1, 1, 3, 3),
	(4, 'Y-Solowarm', NULL, '2022-10-28', '2022-10-28', 1, 1, 2, 4, 4),
	(5, 'Hatity', NULL, '2022-10-28', '2022-10-28', 2, 2, 1, 5, 5),
	(6, 'Bamity', NULL, '2022-10-28', '2022-10-28', 3, 1, 2, 6, 1),
	(7, 'Solarbreeze', NULL, '2022-10-28', '2022-10-28', 1, 1, 1, 7, 2),
	(8, 'Stringtough', NULL, '2022-10-28', '2022-10-28', 2, 2, 2, 8, 3),
	(9, 'Alpha', NULL, '2022-10-28', '2022-10-28', 3, 1, 1, 9, 4),
	(10, 'Flowdesk', NULL, '2022-10-28', '2022-10-28', 1, 1, 2, 10, 5),
	(11, 'Voltsillam', NULL, '2022-10-28', '2022-10-28', 2, 2, 1, 1, 1),
	(12, 'Treeflex', NULL, '2022-10-28', '2022-10-28', 3, 1, 2, 2, 2),
	(13, 'Bigtax', NULL, '2022-10-28', '2022-10-28', 1, 1, 1, 3, 3),
	(14, 'Sonsing', NULL, '2022-10-28', '2022-10-28', 2, 2, 2, 4, 4),
	(15, 'Latlux', NULL, '2022-10-28', '2022-10-28', 3, 1, 1, 5, 5),
	(16, 'Greenlam', NULL, '2022-10-28', '2022-10-28', 1, 1, 2, 6, 1),
	(17, 'It', NULL, '2022-10-28', '2022-10-28', 2, 2, 1, 7, 2),
	(18, 'Domainer', NULL, '2022-10-28', '2022-10-28', 3, 1, 2, 8, 3),
	(19, 'It', NULL, '2022-10-28', '2022-10-28', 1, 1, 1, 9, 4),
	(23, 'Stringtough', NULL, '2022-10-28', '2022-10-28', 2, 2, 2, 10, 5);

-- Volcando estructura para tabla proyecto_final_sql.equipo
CREATE TABLE IF NOT EXISTS `equipo` (
  `id_equipo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id_equipo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='Conjunto de usuarios con capacidad de desarrollar una actividad';

-- Volcando datos para la tabla proyecto_final_sql.equipo: ~4 rows (aproximadamente)
DELETE FROM `equipo`;
INSERT INTO `equipo` (`id_equipo`, `nombre`) VALUES
	(1, 'Parque Patricios'),
	(2, 'Guemes 1'),
	(3, 'Guemes 2'),
	(4, 'Guemes 3');

-- Volcando estructura para tabla proyecto_final_sql.estado
CREATE TABLE IF NOT EXISTS `estado` (
  `id_estado` int(11) NOT NULL AUTO_INCREMENT,
  `estado` enum('Activo','Inactivo') NOT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='Estado Activo/Inactivo del Documento, Usuario o Equipo';

-- Volcando datos para la tabla proyecto_final_sql.estado: ~2 rows (aproximadamente)
DELETE FROM `estado`;
INSERT INTO `estado` (`id_estado`, `estado`) VALUES
	(1, 'Activo'),
	(2, 'Inactivo');

-- Volcando estructura para tabla proyecto_final_sql.permisos
CREATE TABLE IF NOT EXISTS `permisos` (
  `id_permisos` int(11) NOT NULL AUTO_INCREMENT,
  `permiso` varchar(60) NOT NULL,
  PRIMARY KEY (`id_permisos`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='Acciones que puede realizar un rol o Usuario';

-- Volcando datos para la tabla proyecto_final_sql.permisos: ~7 rows (aproximadamente)
DELETE FROM `permisos`;
INSERT INTO `permisos` (`id_permisos`, `permiso`) VALUES
	(1, 'Crear Usuario'),
	(2, 'Eliminar Usuario'),
	(3, 'Crear Documento'),
	(4, 'Editar Documento'),
	(5, 'Crear Proyecto'),
	(6, 'Eliminar Proyecto'),
	(7, 'Asignar Equipo');

-- Volcando estructura para tabla proyecto_final_sql.prioridad
CREATE TABLE IF NOT EXISTS `prioridad` (
  `id_prioridad` int(11) NOT NULL AUTO_INCREMENT,
  `prioridad` enum('Alta','Media','Baja') NOT NULL,
  PRIMARY KEY (`id_prioridad`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='Necesidad de finalizar rapidamente el documento';

-- Volcando datos para la tabla proyecto_final_sql.prioridad: ~3 rows (aproximadamente)
DELETE FROM `prioridad`;
INSERT INTO `prioridad` (`id_prioridad`, `prioridad`) VALUES
	(1, 'Alta'),
	(2, 'Media'),
	(3, 'Baja');

-- Volcando estructura para tabla proyecto_final_sql.proyecto
CREATE TABLE IF NOT EXISTS `proyecto` (
  `id_proyecto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_proyecto` varchar(70) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL,
  `equipo_id` int(11) NOT NULL,
  PRIMARY KEY (`id_proyecto`),
  KEY `equipo_id` (`equipo_id`),
  CONSTRAINT `proyecto_ibfk_1` FOREIGN KEY (`equipo_id`) REFERENCES `equipo` (`id_equipo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='Identificación del proyecto y el equipo responsable de su desarrollo y soporte';

-- Volcando datos para la tabla proyecto_final_sql.proyecto: ~10 rows (aproximadamente)
DELETE FROM `proyecto`;
INSERT INTO `proyecto` (`id_proyecto`, `nombre_proyecto`, `fecha_creacion`, `fecha_modificacion`, `equipo_id`) VALUES
	(1, 'Lotlux', '2022-01-11', '2021-10-12', 1),
	(2, 'Keylex', '2022-03-09', '2022-09-15', 2),
	(3, 'It', '2022-04-04', '2021-09-26', 3),
	(4, 'Voyatouch', '2022-06-20', '2022-09-13', 4),
	(5, 'Konklab', '2022-02-24', '2022-01-26', 1),
	(6, 'Cardify', '2022-05-03', '2021-11-11', 2),
	(7, 'Latlux', '2021-11-29', '2022-09-08', 3),
	(8, 'Lotlux', '2022-09-10', '2022-05-13', 4),
	(9, 'Pannier', '2022-05-13', '2022-02-13', 1),
	(10, 'Vagram', '2021-10-26', '2022-02-08', 2);

-- Volcando estructura para tabla proyecto_final_sql.rol
CREATE TABLE IF NOT EXISTS `rol` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(60) NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='Papel que desempeña dentro de la organización que le permite tener autoridad para realizar, o no, ciertas actividades';

-- Volcando datos para la tabla proyecto_final_sql.rol: ~6 rows (aproximadamente)
DELETE FROM `rol`;
INSERT INTO `rol` (`id_rol`, `nombre_rol`) VALUES
	(1, 'Lider Tecnico'),
	(2, 'Desarrollador'),
	(3, 'DBA'),
	(4, 'DevOps'),
	(5, 'Gerente Desarrollo'),
	(6, 'Analista Funcional');

-- Volcando estructura para tabla proyecto_final_sql.rol_permisos
CREATE TABLE IF NOT EXISTS `rol_permisos` (
  `id_rol_permisos` int(11) NOT NULL AUTO_INCREMENT,
  `rol_id` int(11) NOT NULL,
  `permisos_id` int(11) NOT NULL,
  PRIMARY KEY (`id_rol_permisos`),
  KEY `rol_id` (`rol_id`),
  KEY `permisos_id` (`permisos_id`),
  CONSTRAINT `rol_permisos_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`id_rol`),
  CONSTRAINT `rol_permisos_ibfk_2` FOREIGN KEY (`permisos_id`) REFERENCES `permisos` (`id_permisos`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='Tabla intermedia para hacar perfiles de permisos para cada rol';

-- Volcando datos para la tabla proyecto_final_sql.rol_permisos: ~18 rows (aproximadamente)
DELETE FROM `rol_permisos`;
INSERT INTO `rol_permisos` (`id_rol_permisos`, `rol_id`, `permisos_id`) VALUES
	(1, 1, 1),
	(2, 1, 2),
	(3, 1, 4),
	(4, 1, 3),
	(5, 2, 3),
	(6, 3, 3),
	(7, 3, 4),
	(8, 4, 3),
	(9, 4, 4),
	(10, 5, 1),
	(11, 5, 2),
	(12, 5, 3),
	(13, 5, 4),
	(14, 5, 5),
	(15, 5, 6),
	(16, 5, 7),
	(17, 6, 3),
	(18, 6, 4);

-- Volcando estructura para tabla proyecto_final_sql.tipo
CREATE TABLE IF NOT EXISTS `tipo` (
  `id_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(60) NOT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='Tipo de documento que se realiza, funcional, manu de usuario, entre otros...';

-- Volcando datos para la tabla proyecto_final_sql.tipo: ~6 rows (aproximadamente)
DELETE FROM `tipo`;
INSERT INTO `tipo` (`id_tipo`, `tipo`) VALUES
	(1, 'Analisis Funcional'),
	(2, 'Relevamiento de requisitos'),
	(3, 'Analisis Funcional [BackEnd]'),
	(4, 'Analisis Funcional [FrontEnd]'),
	(5, 'Analisis funcional [Refactorización]'),
	(6, 'Manual de usuario');

-- Volcando estructura para tabla proyecto_final_sql.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `DNI` bigint(20) NOT NULL,
  `usuario` varchar(30) NOT NULL,
  `contrasena` varchar(20) NOT NULL,
  `contacto` varchar(20) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  `fecha_modificacion` datetime NOT NULL,
  `estado_id` int(11) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `depto_id` int(11) NOT NULL COMMENT 'Departamento',
  `equipo_id` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `DNI` (`DNI`),
  UNIQUE KEY `usuario` (`usuario`),
  UNIQUE KEY `contacto` (`contacto`),
  KEY `estado_id` (`estado_id`),
  KEY `rol_id` (`rol_id`),
  KEY `depto_id` (`depto_id`),
  KEY `equipo_id` (`equipo_id`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id_estado`),
  CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`id_rol`),
  CONSTRAINT `usuario_ibfk_3` FOREIGN KEY (`depto_id`) REFERENCES `departamento` (`id_depto`),
  CONSTRAINT `usuario_ibfk_4` FOREIGN KEY (`equipo_id`) REFERENCES `equipo` (`id_equipo`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COMMENT='Persona responsable del desarrollo de actividades que pertenece a un equipo, tiene un rol con permisos e identificación';

-- Volcando datos para la tabla proyecto_final_sql.usuario: ~35 rows (aproximadamente)
DELETE FROM `usuario`;
INSERT INTO `usuario` (`id_usuario`, `nombre`, `apellido`, `DNI`, `usuario`, `contrasena`, `contacto`, `fecha_creacion`, `fecha_modificacion`, `estado_id`, `rol_id`, `depto_id`, `equipo_id`) VALUES
	(1, 'Queenie', 'Hugo', 5439748172, 'qhugo0', '6yqrVgDhMF', '920-267-0530', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 1, 1, 3),
	(2, 'Tanya', 'Selby', 5508336672, 'tselby1', 'CDBQcVJl', '937-268-7197', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 2, 2, 1),
	(3, 'Coralie', 'Linklet', 3840917263, 'clinklet2', 'JudrhTTM5PIe', '499-945-1540', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 3, 3, 2),
	(4, 'Wayland', 'Mennell', 3877391664, 'wmennell3', 'MrgsGryV1ak', '799-151-9103', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 2, 4, 4, 3),
	(5, 'Bryce', 'MacSporran', 5512381814, 'bmacsporran4', 'NgA2m4kInC', '294-766-6958', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 5, 1, 4),
	(6, 'Arnold', 'Grimley', 3657535519, 'agrimley5', 'ATlwCEgY6', '147-447-2079', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 1, 2, 1),
	(7, 'Barde', 'Knottley', 9621670624, 'bknottley6', 'jYa2wzM', '197-997-4838', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 2, 3, 2),
	(8, 'Bernette', 'McIndrew', 4601490715, 'bmcindrew7', 'UcIOlf', '996-306-8746', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 3, 4, 3),
	(9, 'Brigid', 'Hartley', 6209582796, 'bhartley8', 'MSvxP1ub', '551-236-7114', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 4, 1, 4),
	(10, 'Kristofer', 'Pape', 2136371061, 'kpape9', 'DKcRGSBJuG', '876-378-1005', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 5, 2, 1),
	(11, 'Erinna', 'McGrouther', 8563148192, 'emcgrouthera', 'XwJuq1OrN6ZA', '632-461-9229', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 1, 3, 2),
	(12, 'Kikelia', 'Mitcheson', 4430280991, 'kmitchesonb', 'KWkuwLWHXrb', '833-310-4697', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 2, 4, 3),
	(13, 'Agata', 'Vanetti', 4973277797, 'avanettic', 'rRw606LPASQ', '762-578-5988', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 2, 3, 1, 4),
	(14, 'Haydon', 'Laxon', 7409074523, 'hlaxond', '11E0LwK', '814-593-9980', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 4, 2, 1),
	(15, 'Lucy', 'Gliddon', 9892766512, 'lgliddone', '5XGwIc3uek', '391-501-4121', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 5, 3, 2),
	(16, 'Kristoffer', 'Ninotti', 3368589997, 'kninottif', 'P04yhEgeA8f', '769-858-6608', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 1, 4, 3),
	(17, 'Norine', 'McKernon', 663385652, 'nmckernong', 'yhHV73', '893-416-0942', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 2, 1, 4),
	(18, 'Petr', 'Boik', 6790865179, 'pboikh', '5EmmSdLo9', '594-533-5480', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 3, 2, 1),
	(19, 'Bourke', 'Thoresbie', 9848878963, 'bthoresbiei', 'KzB7atD', '354-268-6476', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 4, 3, 2),
	(20, 'Rodney', 'Flounders', 482635932, 'rfloundersj', '4Zno0g8', '260-600-1607', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 5, 4, 3),
	(21, 'Barbabas', 'Morrill', 8405496653, 'bmorrillk', '2eIr3nYhc', '-1659', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 2, 1, 4),
	(22, 'Jamie', 'Samuel', 3758373255, 'jsamuell', '2PCfKgk', '262-356-1860', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 2, 2, 1),
	(23, 'Verena', 'Luckcock', 7058523401, 'vluckcockm', 'yYwJ6Go', '692-619-5770', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 3, 3, 2),
	(24, 'Geoffry', 'Baldinotti', 2560967731, 'gbaldinottin', 'tGopjt', '996-321-4155', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 4, 4, 3),
	(25, 'Georgiana', 'Arden', 2944405772, 'gardeno', '0BSeWbuZ', '116-220-7033', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 5, 1, 4),
	(26, 'Conroy', 'O Lehane', 9334943068, 'colehanep', 'K6Qpf8mxn6', '260-408-9553', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 1, 2, 1),
	(27, 'Granthem', 'Melton', 5621932161, 'gmeltonq', 'lGBaqO', '373-813-8703', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 2, 3, 2),
	(28, 'Flinn', 'Haslock', 7196823648, 'fhaslockr', 'VbAV6sPy', '954-874-6870', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 3, 4, 3),
	(29, 'Nesta', 'Gerrelts', 3194592106, 'ngerreltss', 'LX7z9Xw2', '631-638-3775', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 4, 1, 4),
	(30, 'Roscoe', 'Rowell', 6385290581, 'rrowellt', 'ZAdQnz126ue', '810-410-3065', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 5, 2, 1),
	(31, 'Christabel', 'Gillison', 9137966189, 'cgillisonu', 'Mhc8BWa7tWP', '812-321-8291', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 1, 3, 2),
	(32, 'Cassaundra', 'McNeillie', 7947055912, 'cmcneilliev', 'o0J8tWo2AxkK', '672-891-2772', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 2, 4, 3),
	(33, 'Angelica', 'Emes', 4382042933, 'aemesw', 'UVO7PprFqhmF', '740-497-6739', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 3, 1, 4),
	(34, 'Luisa', 'Phelit', 7141145109, 'lphelitx', 'glxYBJm', '856-706-1863', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 4, 2, 1),
	(35, 'Mannie', 'Eagling', 1931546053, 'meaglingy', 'GISaxTUov', '626-577-1147', '2022-10-28 23:56:55', '2022-10-28 23:56:55', 1, 5, 3, 2);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
