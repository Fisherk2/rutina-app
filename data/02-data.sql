/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.11-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: RutinasDB
-- ------------------------------------------------------
-- Server version	10.11.11-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `confirmaciones`
--

LOCK TABLES `confirmaciones` WRITE;
/*!40000 ALTER TABLE `confirmaciones` DISABLE KEYS */;
INSERT INTO `confirmaciones` VALUES
(1,'Juan Pérez',28,75.50,178.00,'M','2025-03-02'),
(2,'María López',34,62.00,165.00,'F','2025-03-02'),
(3,'Carlos Ramírez',22,80.00,180.00,'M','2025-03-02'),
(4,'Ana Gómez',29,58.50,168.00,'F','2025-03-02'),
(5,'Luis Fernández',31,70.00,175.00,'M','2025-03-02'),
(6,'Sofía Torres',26,65.00,170.00,'F','2025-03-02'),
(7,'Diego Morales',27,78.00,179.00,'M','2025-03-02'),
(8,'Valeria Castro',30,60.00,167.00,'F','2025-03-02'),
(9,'Javier Mendoza',33,82.00,182.00,'M','2025-03-02'),
(10,'Laura Sánchez',25,55.00,163.00,'F','2025-03-02'),
(11,'Fisher',27,85.00,176.00,'M','2025-03-20');
/*!40000 ALTER TABLE `confirmaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `rutinas`
--

LOCK TABLES `rutinas` WRITE;
/*!40000 ALTER TABLE `rutinas` DISABLE KEYS */;
INSERT INTO `rutinas` VALUES
(1,'2025-03-01','Sentadillas, Flexiones, Plancha'),
(2,'2025-03-02','Correr 3 km, Abdominales, Estiramientos'),
(3,'2025-03-03','Zancadas, Elevaciones laterales, Burpees'),
(4,'2025-03-04','Saltos de cuerda, Sentadillas, Flexiones'),
(5,'2025-03-05','Ciclismo, Plancha, Abdominales'),
(6,'2025-03-06','Sentadillas con pesas, Flexiones diamante, Estiramientos'),
(7,'2025-03-07','Correr 5 km, Zancadas, Elevaciones frontales'),
(8,'2025-03-08','Burpees, Plancha lateral, Saltos de cuerda'),
(9,'2025-03-09','Flexiones explosivas, Sentadillas, Abdominales'),
(10,'2025-03-10','Estiramientos, Ciclismo, Zancadas'),
(11,'2025-03-11','Sentadillas búlgaras, Flexiones inclinadas, Plancha abdominal'),
(12,'2025-03-12','Correr 4 km, Abdominales oblicuos, Estiramientos dinámicos'),
(13,'2025-03-13','Zancadas inversas, Elevaciones frontales, Burpees modificados'),
(14,'2025-03-14','Saltos de tijera, Sentadillas sumo, Flexiones cerradas'),
(15,'2025-03-15','Ciclismo en interiores, Plancha con brazos extendidos, Abdominales inferiores'),
(16,'2025-03-16','Sentadillas con salto, Flexiones explosivas, Estiramientos profundos'),
(17,'2025-03-17','Correr 6 km, Zancadas con pesas, Elevaciones laterales con mancuernas'),
(18,'2025-03-18','Burpees con salto, Plancha frontal, Saltos de cuerda dobles'),
(19,'2025-03-19','Flexiones diamante, Sentadillas búlgaras, Abdominales cruzados'),
(20,'2025-03-20','Estiramientos activos, Ciclismo al aire libre, Zancadas alternas'),
(21,'2025-03-21','Sentadillas sumo, Flexiones inclinadas, Plancha lateral izquierda'),
(22,'2025-03-22','Correr 3 km, Abdominales inferiores, Estiramientos estáticos'),
(23,'2025-03-23','Zancadas con salto, Elevaciones frontales con banda elástica, Burpees lentos'),
(24,'2025-03-24','Saltos de cuerda simples, Sentadillas con banda elástica, Flexiones abiertas'),
(25,'2025-03-25','Ciclismo en montaña, Plancha con rodillas, Abdominales con elevación de piernas'),
(26,'2025-03-26','Sentadillas con peso corporal, Flexiones explosivas, Estiramientos de espalda'),
(27,'2025-03-27','Correr 5 km, Zancadas largas, Elevaciones laterales con pesas'),
(28,'2025-03-28','Burpees con flexión, Plancha frontal con apoyo, Saltos de cuerda triples'),
(29,'2025-03-29','Flexiones cerradas, Sentadillas sumo, Abdominales oblicuos intensos'),
(30,'2025-03-30','Estiramientos de piernas, Ciclismo en grupo, Zancadas cortas'),
(31,'2025-03-31','Sentadillas explosivas, Flexiones diamante, Plancha abdominal completa'),
(32,'2025-04-01','Sentadillas, Flexiones, Plancha'),
(33,'2025-04-02','Correr 3 km, Abdominales, Estiramientos'),
(34,'2025-04-03','Zancadas, Elevaciones laterales, Burpees'),
(35,'2025-04-04','Saltos de cuerda, Sentadillas, Flexiones'),
(36,'2025-04-05','Ciclismo, Plancha, Abdominales'),
(37,'2025-04-06','Sentadillas con pesas, Flexiones diamante, Estiramientos'),
(38,'2025-04-07','Correr 5 km, Zancadas, Elevaciones frontales'),
(39,'2025-04-08','Burpees, Plancha lateral, Saltos de cuerda'),
(40,'2025-04-09','Flexiones explosivas, Sentadillas, Abdominales'),
(41,'2025-04-10','Estiramientos, Ciclismo, Zancadas'),
(42,'2025-04-11','Sentadillas búlgaras, Flexiones inclinadas, Plancha abdominal'),
(43,'2025-04-12','Correr 4 km, Abdominales oblicuos, Estiramientos dinámicos'),
(44,'2025-04-13','Zancadas inversas, Elevaciones frontales, Burpees modificados'),
(45,'2025-04-14','Saltos de tijera, Sentadillas sumo, Flexiones cerradas'),
(46,'2025-04-15','Ciclismo en interiores, Plancha con brazos extendidos, Abdominales inferiores'),
(47,'2025-04-16','Sentadillas con salto, Flexiones explosivas, Estiramientos profundos'),
(48,'2025-04-17','Correr 6 km, Zancadas con pesas, Elevaciones laterales con mancuernas'),
(49,'2025-04-18','Burpees con salto, Plancha frontal, Saltos de cuerda dobles'),
(50,'2025-04-19','Flexiones diamante, Sentadillas búlgaras, Abdominales cruzados'),
(51,'2025-04-20','Estiramientos activos, Ciclismo al aire libre, Zancadas alternas'),
(52,'2025-04-21','Sentadillas sumo, Flexiones inclinadas, Plancha lateral izquierda'),
(53,'2025-04-22','Correr 3 km, Abdominales inferiores, Estiramientos estáticos'),
(54,'2025-04-23','Zancadas con salto, Elevaciones frontales con banda elástica, Burpees lentos'),
(55,'2025-04-24','Saltos de cuerda simples, Sentadillas con banda elástica, Flexiones abiertas'),
(56,'2025-04-25','Ciclismo en montaña, Plancha con rodillas, Abdominales con elevación de piernas'),
(57,'2025-04-26','Sentadillas con peso corporal, Flexiones explosivas, Estiramientos de espalda'),
(58,'2025-04-27','Correr 5 km, Zancadas largas, Elevaciones laterales con pesas'),
(59,'2025-04-28','Burpees con flexión, Plancha frontal con apoyo, Saltos de cuerda triples'),
(60,'2025-04-29','Flexiones cerradas, Sentadillas sumo, Abdominales oblicuos intensos'),
(61,'2025-04-30','Estiramientos de piernas, Ciclismo en grupo, Zancadas cortas'),
(62,'2025-05-01','Sentadillas, Flexiones, Plancha'),
(63,'2025-05-02','Correr 3 km, Abdominales, Estiramientos'),
(64,'2025-05-03','Zancadas, Elevaciones laterales, Burpees'),
(65,'2025-05-04','Saltos de cuerda, Sentadillas, Flexiones'),
(66,'2025-05-05','Ciclismo, Plancha, Abdominales'),
(67,'2025-05-06','Sentadillas con pesas, Flexiones diamante, Estiramientos'),
(68,'2025-05-07','Correr 5 km, Zancadas, Elevaciones frontales'),
(69,'2025-05-08','Burpees, Plancha lateral, Saltos de cuerda'),
(70,'2025-05-09','Flexiones explosivas, Sentadillas, Abdominales'),
(71,'2025-05-10','Estiramientos, Ciclismo, Zancadas'),
(72,'2025-05-11','Sentadillas búlgaras, Flexiones inclinadas, Plancha abdominal'),
(73,'2025-05-12','Correr 4 km, Abdominales oblicuos, Estiramientos dinámicos'),
(74,'2025-05-13','Zancadas inversas, Elevaciones frontales, Burpees modificados'),
(75,'2025-05-14','Saltos de tijera, Sentadillas sumo, Flexiones cerradas'),
(76,'2025-05-15','Ciclismo en interiores, Plancha con brazos extendidos, Abdominales inferiores'),
(77,'2025-05-16','Sentadillas con salto, Flexiones explosivas, Estiramientos profundos'),
(78,'2025-05-17','Correr 6 km, Zancadas con pesas, Elevaciones laterales con mancuernas'),
(79,'2025-05-18','Burpees con salto, Plancha frontal, Saltos de cuerda dobles'),
(80,'2025-05-19','Flexiones diamante, Sentadillas búlgaras, Abdominales cruzados'),
(81,'2025-05-20','Estiramientos activos, Ciclismo al aire libre, Zancadas alternas'),
(82,'2025-05-21','Sentadillas sumo, Flexiones inclinadas, Plancha lateral izquierda'),
(83,'2025-05-22','Correr 3 km, Abdominales inferiores, Estiramientos estáticos'),
(84,'2025-05-23','Zancadas con salto, Elevaciones frontales con banda elástica, Burpees lentos'),
(85,'2025-05-24','Saltos de cuerda simples, Sentadillas con banda elástica, Flexiones abiertas'),
(86,'2025-05-25','Ciclismo en montaña, Plancha con rodillas, Abdominales con elevación de piernas'),
(87,'2025-05-26','Sentadillas con peso corporal, Flexiones explosivas, Estiramientos de espalda'),
(88,'2025-05-27','Correr 5 km, Zancadas largas, Elevaciones laterales con pesas'),
(89,'2025-05-28','Burpees con flexión, Plancha frontal con apoyo, Saltos de cuerda triples'),
(90,'2025-05-29','Flexiones cerradas, Sentadillas sumo, Abdominales oblicuos intensos'),
(91,'2025-05-30','Estiramientos de piernas, Ciclismo en grupo, Zancadas cortas'),
(92,'2025-05-31','Sentadillas explosivas, Flexiones diamante, Plancha abdominal completa');
/*!40000 ALTER TABLE `rutinas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-28 12:30:34
