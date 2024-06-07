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
-- Temporary view structure for view `navi`
--

DROP TABLE IF EXISTS `navi`;
/*!50001 DROP VIEW IF EXISTS `navi`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `navi` AS SELECT 
 1 AS `版块名`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `userview`
--

DROP TABLE IF EXISTS `userview`;
/*!50001 DROP VIEW IF EXISTS `userview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `userview` AS SELECT 
 1 AS `我的ID`,
 1 AS `我的用户名`,
 1 AS `我的密码`,
 1 AS `我的学工号`,
 1 AS `我的身份`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `suspensionview`
--

DROP TABLE IF EXISTS `suspensionview`;
/*!50001 DROP VIEW IF EXISTS `suspensionview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `suspensionview` AS SELECT 
 1 AS `suspensionID`,
 1 AS `我被封禁的版块`,
 1 AS `封禁理由`,
 1 AS `解封时间`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `postview`
--

DROP TABLE IF EXISTS `postview`;
/*!50001 DROP VIEW IF EXISTS `postview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `postview` AS SELECT 
 1 AS `postID`,
 1 AS `发言内容`,
 1 AS `发言者用户名`,
 1 AS `发言者身份`,
 1 AS `发言时间`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `managementview`
--

DROP TABLE IF EXISTS `managementview`;
/*!50001 DROP VIEW IF EXISTS `managementview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `managementview` AS SELECT 
 1 AS `managerID`,
 1 AS `我的权限ID`,
 1 AS `我管理的版块`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `boradview`
--

DROP TABLE IF EXISTS `boradview`;
/*!50001 DROP VIEW IF EXISTS `boradview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `boradview` AS SELECT 
 1 AS `boradID`,
 1 AS `贴子标题`,
 1 AS `发帖人用户名`,
 1 AS `发帖者身份`,
 1 AS `发帖时间`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `topview`
--

DROP TABLE IF EXISTS `topview`;
/*!50001 DROP VIEW IF EXISTS `topview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `topview` AS SELECT 
 1 AS `boradID`,
 1 AS `置顶帖标题`,
 1 AS `发帖人用户名`,
 1 AS `置顶时间`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `navi`
--

/*!50001 DROP VIEW IF EXISTS `navi`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `navi` AS select `borads`.`boradName` AS `版块名` from `borads` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `userview`
--

/*!50001 DROP VIEW IF EXISTS `userview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `userview` AS select `users`.`userID` AS `我的ID`,`users`.`userName` AS `我的用户名`,`users`.`userPassword` AS `我的密码`,`realusers`.`realID` AS `我的学工号`,`realusers`.`identity` AS `我的身份` from (`users` join `realusers`) where (`users`.`realID` = `realusers`.`realID`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `suspensionview`
--

/*!50001 DROP VIEW IF EXISTS `suspensionview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `suspensionview` AS select `suspensions`.`suspensionID` AS `suspensionID`,`borads`.`boradName` AS `我被封禁的版块`,`suspensions`.`reason` AS `封禁理由`,`suspensions`.`endTime` AS `解封时间` from (`suspensions` join `borads`) where (`suspensions`.`boradID` = `borads`.`boradID`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `postview`
--

/*!50001 DROP VIEW IF EXISTS `postview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `postview` AS select `posts`.`postID` AS `postID`,`statements`.`statement` AS `发言内容`,`users`.`userName` AS `发言者用户名`,`realusers`.`identity` AS `发言者身份`,`statements`.`statementTime` AS `发言时间` from (((`posts` join `statements`) join `users`) join `realusers`) where ((`posts`.`postID` = `statements`.`postID`) and (`statements`.`speakerID` = `users`.`userID`) and (`users`.`realID` = `realusers`.`realID`)) order by `statements`.`statementTime` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `managementview`
--

/*!50001 DROP VIEW IF EXISTS `managementview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `managementview` AS select `managements`.`managerID` AS `managerID`,`managements`.`managementID` AS `我的权限ID`,`borads`.`boradName` AS `我管理的版块` from (`managements` join `borads`) where (`managements`.`boradID` = `borads`.`boradID`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `boradview`
--

/*!50001 DROP VIEW IF EXISTS `boradview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `boradview` AS select `borads`.`boradID` AS `boradID`,`posts`.`postName` AS `贴子标题`,`posts`.`posterID` AS `发帖人用户名`,`realusers`.`identity` AS `发帖者身份`,`posts`.`postTime` AS `发帖时间` from ((((`borads` join `posts`) join `statements`) join `users`) join `realusers`) where ((`borads`.`boradID` = `posts`.`boradID`) and (`statements`.`postID` = `posts`.`postID`) and (`users`.`userID` = `posts`.`posterID`) and (`realusers`.`realID` = `users`.`realID`)) order by `statements`.`statementTime` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `topview`
--

/*!50001 DROP VIEW IF EXISTS `topview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `topview` AS select `borads`.`boradID` AS `boradID`,`posts`.`postName` AS `置顶帖标题`,`posts`.`posterID` AS `发帖人用户名`,`posts`.`postTime` AS `置顶时间` from (`borads` join `posts`) where ((`posts`.`topMark` = '是') and (`borads`.`boradID` = `posts`.`boradID`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-09 16:15:55
