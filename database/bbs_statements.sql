-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: bbs
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `statements`
--

DROP TABLE IF EXISTS `statements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statements` (
  `statementID` int NOT NULL,
  `statement` varchar(200) NOT NULL,
  `speakerID` int DEFAULT NULL,
  `postID` int DEFAULT NULL,
  `statementTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleteMark` enum('是','否') DEFAULT '否',
  PRIMARY KEY (`statementID`),
  KEY `fk_Statements_01` (`speakerID`),
  KEY `fk_Statements_02` (`postID`),
  CONSTRAINT `statements_ibfk_1` FOREIGN KEY (`speakerID`) REFERENCES `users` (`userID`),
  CONSTRAINT `statements_ibfk_2` FOREIGN KEY (`postID`) REFERENCES `posts` (`postID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statements`
--

LOCK TABLES `statements` WRITE;
/*!40000 ALTER TABLE `statements` DISABLE KEYS */;
INSERT INTO `statements` VALUES (1,'论坛创建初始化信息',1004,1,'2022-11-29 11:45:05','否'),(2,'我发布了一条贴子，快来看看吧',1001,2,'2022-11-29 12:36:52','否'),(3,'我发布了一条贴子，快来看看吧',1005,3,'2022-12-30 02:12:11','否'),(4,'录像中发布一条留言\n',1005,3,'2022-12-30 02:12:32','否'),(5,'我发布了一条贴子，快来看看吧',1001,4,'2023-12-09 06:29:43','否'),(6,'是这样的\n',1001,4,'2023-12-09 06:30:00','否');
/*!40000 ALTER TABLE `statements` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-09 16:15:55
