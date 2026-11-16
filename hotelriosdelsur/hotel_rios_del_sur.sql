/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: hotel_rios_del_sur
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `hotel_rios_del_sur`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `hotel_rios_del_sur` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `hotel_rios_del_sur`;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add habitacion',7,'add_habitacion'),
(26,'Can change habitacion',7,'change_habitacion'),
(27,'Can delete habitacion',7,'delete_habitacion'),
(28,'Can view habitacion',7,'view_habitacion'),
(29,'Can add huesped',8,'add_huesped'),
(30,'Can change huesped',8,'change_huesped'),
(31,'Can delete huesped',8,'delete_huesped'),
(32,'Can view huesped',8,'view_huesped'),
(33,'Can add cliente',9,'add_cliente'),
(34,'Can change cliente',9,'change_cliente'),
(35,'Can delete cliente',9,'delete_cliente'),
(36,'Can view cliente',9,'view_cliente'),
(37,'Can add recepcionista',10,'add_recepcionista'),
(38,'Can change recepcionista',10,'change_recepcionista'),
(39,'Can delete recepcionista',10,'delete_recepcionista'),
(40,'Can view recepcionista',10,'view_recepcionista'),
(41,'Can add reserva',11,'add_reserva'),
(42,'Can change reserva',11,'change_reserva'),
(43,'Can delete reserva',11,'delete_reserva'),
(44,'Can view reserva',11,'view_reserva');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES
(1,'pbkdf2_sha256$1000000$VPm57MK0Zy1fiUx3khBqPD$iNHvIY83tV1yj0xUnu6Br8wgCJbZFL0dOHGsLelq6bA=','2026-11-07 21:33:43.761217',1,'benja','','','benjacraft309@gmail.com',1,1,'2026-10-30 22:21:42.241153'),
(2,'pbkdf2_sha256$1000000$pBUOKEMAmv6Rq8mERMd30J$LwrG79iDJvDRtuWLaafOUyAzTANNTX9nJpIAWZR4tNA=','2026-11-07 21:33:33.509757',0,'Benjotaxx1jr@','','','',0,1,'2026-10-31 21:57:18.000000'),
(3,'pbkdf2_sha256$1000000$kv9bbDeDalXLrZdlD8GfPp$BtI5crSmDGmLDdRXgXIuXCSCiz0bKanW0WG8yiFsYlo=','2026-11-01 14:51:40.999653',0,'pedro12','pedro','torres','pedro@gmail.com',0,1,'2026-10-31 23:51:29.007622'),
(4,'pbkdf2_sha256$720000$uD3ACERizVt7vXE4BnraS7$uBPuh0bLLkRMLG0pBNt6X3g08h7tvKM1CqHeJNmDvn4=','2026-11-15 21:54:28.132937',0,'proto','robert','brown','biprotoporos@proton.me',0,1,'2026-11-15 21:52:11.358967'),
(5,'pbkdf2_sha256$720000$yPMyxgisHOeEhVmObFR610$T7ve6OeNRU+JZj5FdCkAT8ZzXDxWOuY9+yXoS7c7KHk=','2026-11-15 22:07:23.161591',1,'protoporos','','','bios@gmail.com',1,1,'2026-11-15 21:54:16.528532');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES
(1,'2026-10-31 15:08:00.284943','1','Habitación 1 - doble',1,'[{\"added\": {}}]',7,1),
(2,'2026-10-31 21:57:19.895564','2','Benjotaxx1jr@',1,'[{\"added\": {}}]',4,1),
(3,'2026-10-31 21:57:57.944611','2','Benjotaxx1jr@',2,'[]',4,1),
(4,'2026-10-31 21:58:26.996382','1','Benjotaxx1jr@',1,'[{\"added\": {}}]',9,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(9,'hotelApp','cliente'),
(7,'hotelApp','habitacion'),
(8,'hotelApp','huesped'),
(10,'hotelApp','recepcionista'),
(11,'hotelApp','reserva'),
(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES
(1,'contenttypes','0001_initial','2026-10-30 21:55:28.588888'),
(2,'auth','0001_initial','2026-10-30 21:55:29.148612'),
(3,'admin','0001_initial','2026-10-30 21:55:29.274950'),
(4,'admin','0002_logentry_remove_auto_add','2026-10-30 21:55:29.285945'),
(5,'admin','0003_logentry_add_action_flag_choices','2026-10-30 21:55:29.300948'),
(6,'contenttypes','0002_remove_content_type_name','2026-10-30 21:55:29.389939'),
(7,'auth','0002_alter_permission_name_max_length','2026-10-30 21:55:29.473946'),
(8,'auth','0003_alter_user_email_max_length','2026-10-30 21:55:29.514655'),
(9,'auth','0004_alter_user_username_opts','2026-10-30 21:55:29.543487'),
(10,'auth','0005_alter_user_last_login_null','2026-10-30 21:55:29.606126'),
(11,'auth','0006_require_contenttypes_0002','2026-10-30 21:55:29.609120'),
(12,'auth','0007_alter_validators_add_error_messages','2026-10-30 21:55:29.621131'),
(13,'auth','0008_alter_user_username_max_length','2026-10-30 21:55:29.657116'),
(14,'auth','0009_alter_user_last_name_max_length','2026-10-30 21:55:29.696117'),
(15,'auth','0010_alter_group_name_max_length','2026-10-30 21:55:29.736120'),
(16,'auth','0011_update_proxy_permissions','2026-10-30 21:55:29.751123'),
(17,'auth','0012_alter_user_first_name_max_length','2026-10-30 21:55:29.787120'),
(18,'hotelApp','0001_initial','2026-10-30 21:55:30.246421'),
(19,'sessions','0001_initial','2026-10-30 21:55:30.299439'),
(20,'hotelApp','0002_reserva_cantidad_noches_reserva_precio_total','2026-11-01 15:58:56.267426'),
(21,'hotelApp','0003_habitacion_imagen','2026-11-15 21:41:25.045990'),
(22,'hotelApp','0004_alter_habitacion_imagen','2026-11-15 21:41:25.068551'),
(23,'hotelApp','0005_alter_habitacion_tipo','2026-11-15 23:03:52.872984'),
(24,'hotelApp','0006_alter_habitacion_tipo','2026-11-15 23:08:54.364603');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES
('6n4lezh165tirnau46rx3j8i5r5kkhwc','.eJxVjMsOwiAQRf-FtSE8hgIu3fsNZIBBqgaS0q6M_65NutDtPefcFwu4rTVsg5YwZ3Zmkp1-t4jpQW0H-Y7t1nnqbV3myHeFH3Twa8_0vBzu30HFUb-1AJgcQrQOIgiFGbx2yhBEb9FqFFHonLKxHshKZT0VVQiK9GaSPhX2_gDA3DdS:1xPo2h:RykRHuVq8R9pg16jLzaOUjTty-RBpjGYfd5g8vWuSRw','2026-11-21 21:33:43.765615'),
('eo421i6qo1isis5o7dkrz9rkcsphow3h','.eJxVjMsOwiAQRf-FtSE8hgIu3fsNZIBBqgaS0q6M_65NutDtPefcFwu4rTVsg5YwZ3Zmkp1-t4jpQW0H-Y7t1nnqbV3myHeFH3Twa8_0vBzu30HFUb-1AJgcQrQOIgiFGbx2yhBEb9FqFFHonLKxHshKZT0VVQiK9GaSPhX2_gDA3DdS:1xNVvT:CeHe7ciRlhVAI7cYBHWQArq_FKkfYRtNfp12-4eGmX4','2026-11-15 13:48:47.285938'),
('etox9kbliuje0roskfot5imsmm0u0mfn','.eJxVjMsOwiAQRf-FtSEMjwFcuvcbCAxUqgaS0q6M_65NutDtPefcFwtxW2vYRlnCnNmZGXb63VKkR2k7yPfYbp1Tb-syJ74r_KCDX3suz8vh_h3UOOq39iCsKIqMRgnROU1KOETlkaQzE8lkJSA4l0mCQiuNNiC8QD-R9qDZ-wOZmjWe:1xSiNf:9BGU_T67kTA2TGjaPff9hTLUshuy1F7qoc-iYmde1DY','2026-11-29 22:07:23.163347'),
('pbl4zy9qvxvli3wg3bjrcymc5osym5lo','.eJxVjDsOwjAQRO_iGln-hY0p6TmDtevd4ABypDipEHcnkVJAN5r3Zt4q4bqUtDaZ08jqorw6_XaE-Sl1B_zAep90nuoyj6R3RR-06dvE8roe7t9BwVa2NYgfQibA3pkotg_G2wjuHDxvwQ0YJThgQGeI2IQM2UJk6DI54c6ozxfKBzdv:1xNWuL:QkD5XKXOUJzIdez12QWa3uy_eIvbz1dQDj-Zf8HP4es','2026-11-15 14:51:41.004277');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotelApp_cliente`
--

DROP TABLE IF EXISTS `hotelApp_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotelApp_cliente` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rut` varchar(12) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rut` (`rut`),
  UNIQUE KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `hotelApp_cliente_usuario_id_2772615e_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotelApp_cliente`
--

LOCK TABLES `hotelApp_cliente` WRITE;
/*!40000 ALTER TABLE `hotelApp_cliente` DISABLE KEYS */;
INSERT INTO `hotelApp_cliente` VALUES
(1,'12.212.121.2','9 12345678',2),
(2,'12345678-9','9 12341234',3),
(3,'11222','222',4);
/*!40000 ALTER TABLE `hotelApp_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotelApp_habitacion`
--

DROP TABLE IF EXISTS `hotelApp_habitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotelApp_habitacion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `numero` int(10) unsigned NOT NULL CHECK (`numero` >= 0),
  `tipo` varchar(50) NOT NULL,
  `capacidad` int(10) unsigned NOT NULL CHECK (`capacidad` >= 0),
  `precio` decimal(10,2) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `imagen` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero` (`numero`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotelApp_habitacion`
--

LOCK TABLES `hotelApp_habitacion` WRITE;
/*!40000 ALTER TABLE `hotelApp_habitacion` DISABLE KEYS */;
INSERT INTO `hotelApp_habitacion` VALUES
(1,1,'doble',2,1000.00,'habilitada','Habitacion_1.jpg'),
(2,2,'doble',2,1200.00,'fuera_servicio','habitacion_2.jpg'),
(3,3,'individual',1,700.00,'habilitada','habitacion_3.jpg'),
(4,4,'doble',2,1200.00,'habilitada','habitacion_4.jpg'),
(5,268,'22',22,22222222.00,'habilitada','Habitacion_1.jpg'),
(6,222,'matrimonial',2,2.00,'habilitada','habitacion_2.jpg');
/*!40000 ALTER TABLE `hotelApp_habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotelApp_huesped`
--

DROP TABLE IF EXISTS `hotelApp_huesped`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotelApp_huesped` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `rut` varchar(12) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `correo` varchar(254) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rut` (`rut`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotelApp_huesped`
--

LOCK TABLES `hotelApp_huesped` WRITE;
/*!40000 ALTER TABLE `hotelApp_huesped` DISABLE KEYS */;
INSERT INTO `hotelApp_huesped` VALUES
(1,'juan','torres','21.321.542-9','9 23412133','dsadasd@adiweae.com'),
(2,'maria','gonzalez','12.123.231-1','9 23411234','asdfaf@alddw.com'),
(3,'benjamin','lopez','21.321.542-1','9 23412133','benjaminlv309@gmail.com'),
(4,'pedro','torres','12345678-9','9 12341234','pedro@gmail.com');
/*!40000 ALTER TABLE `hotelApp_huesped` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotelApp_recepcionista`
--

DROP TABLE IF EXISTS `hotelApp_recepcionista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotelApp_recepcionista` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rut` varchar(12) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rut` (`rut`),
  UNIQUE KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `hotelApp_recepcionista_usuario_id_dac2b0d7_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotelApp_recepcionista`
--

LOCK TABLES `hotelApp_recepcionista` WRITE;
/*!40000 ALTER TABLE `hotelApp_recepcionista` DISABLE KEYS */;
/*!40000 ALTER TABLE `hotelApp_recepcionista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotelApp_reserva`
--

DROP TABLE IF EXISTS `hotelApp_reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotelApp_reserva` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fecha_entrada` date NOT NULL,
  `fecha_salida` date NOT NULL,
  `estado` varchar(20) NOT NULL,
  `fecha_reserva` datetime(6) NOT NULL,
  `fecha_checkin` datetime(6) DEFAULT NULL,
  `fecha_checkout` datetime(6) DEFAULT NULL,
  `cliente_id` bigint(20) NOT NULL,
  `habitacion_id` bigint(20) NOT NULL,
  `huesped_id` bigint(20) NOT NULL,
  `cantidad_noches` int(10) unsigned NOT NULL CHECK (`cantidad_noches` >= 0),
  `precio_total` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hotelApp_reserva_cliente_id_029370e1_fk_hotelApp_cliente_id` (`cliente_id`),
  KEY `hotelApp_reserva_habitacion_id_9a6eac20_fk_hotelApp_` (`habitacion_id`),
  KEY `hotelApp_reserva_huesped_id_5b392d8c_fk_hotelApp_huesped_id` (`huesped_id`),
  CONSTRAINT `hotelApp_reserva_cliente_id_029370e1_fk_hotelApp_cliente_id` FOREIGN KEY (`cliente_id`) REFERENCES `hotelApp_cliente` (`id`),
  CONSTRAINT `hotelApp_reserva_habitacion_id_9a6eac20_fk_hotelApp_` FOREIGN KEY (`habitacion_id`) REFERENCES `hotelApp_habitacion` (`id`),
  CONSTRAINT `hotelApp_reserva_huesped_id_5b392d8c_fk_hotelApp_huesped_id` FOREIGN KEY (`huesped_id`) REFERENCES `hotelApp_huesped` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotelApp_reserva`
--

LOCK TABLES `hotelApp_reserva` WRITE;
/*!40000 ALTER TABLE `hotelApp_reserva` DISABLE KEYS */;
INSERT INTO `hotelApp_reserva` VALUES
(1,'2026-11-01','2026-11-03','cancelada','2026-10-31 22:00:50.675153',NULL,NULL,1,3,3,0,NULL),
(2,'2026-11-01','2026-11-03','confirmada','2026-10-31 22:37:09.180276',NULL,NULL,1,3,3,0,NULL),
(3,'2026-11-04','2026-11-06','pendiente','2026-10-31 22:37:29.291089',NULL,NULL,1,3,2,0,NULL),
(4,'2026-11-07','2026-11-11','cancelada','2026-11-01 00:34:14.631299',NULL,NULL,2,3,4,0,NULL),
(5,'2026-11-01','2026-11-04','pendiente','2026-11-01 13:52:15.404977',NULL,NULL,1,1,3,0,NULL),
(6,'2026-11-18','2026-11-22','pendiente','2026-11-01 14:18:59.641312',NULL,NULL,2,3,4,0,NULL),
(7,'2026-11-23','2026-11-26','pendiente','2026-11-01 14:22:10.425551',NULL,NULL,2,1,4,0,NULL),
(8,'2026-12-01','2026-12-04','pendiente','2026-11-01 16:11:50.756515',NULL,NULL,2,1,4,3,3000.00);
/*!40000 ALTER TABLE `hotelApp_reserva` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-15 20:38:55
