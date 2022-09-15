-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: nurseschedulingdb
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `assignements`
--

DROP TABLE IF EXISTS `assignements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignements` (
  `ScheduleID` int NOT NULL,
  `NurseID` int NOT NULL,
  `Day` int NOT NULL,
  `PatternID` int DEFAULT NULL,
  PRIMARY KEY (`ScheduleID`,`NurseID`,`Day`),
  KEY `ass_nurse_idx` (`NurseID`),
  KEY `ass_patt_idx` (`PatternID`),
  CONSTRAINT `ass_nurse` FOREIGN KEY (`NurseID`) REFERENCES `nurses` (`NurseID`),
  CONSTRAINT `ass_patt` FOREIGN KEY (`PatternID`) REFERENCES `patterns` (`PatternID`),
  CONSTRAINT `ass_sched` FOREIGN KEY (`ScheduleID`) REFERENCES `schedules` (`ScheduleID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignements`
--

LOCK TABLES `assignements` WRITE;
/*!40000 ALTER TABLE `assignements` DISABLE KEYS */;
INSERT INTO `assignements` VALUES (92,1,26,1),(92,2,1,1),(92,2,4,1),(92,2,20,1),(92,2,26,1),(92,2,29,1),(92,5,11,1),(92,5,19,1),(92,5,23,1),(92,5,30,1),(92,6,1,1),(92,6,3,1),(92,6,5,1),(92,6,7,1),(92,6,8,1),(92,6,14,1),(92,6,16,1),(92,6,22,1),(92,6,25,1),(92,7,17,1),(92,8,2,1),(92,8,3,1),(92,8,19,1),(92,8,30,1),(92,9,9,1),(92,9,13,1),(92,9,18,1),(92,9,28,1),(92,10,4,1),(92,10,6,1),(92,10,10,1),(92,10,15,1),(92,10,21,1),(92,11,12,1),(92,11,18,1),(92,11,24,1),(92,11,27,1),(92,11,31,1),(92,12,1,1),(92,12,2,1),(92,12,9,1),(92,12,17,1),(92,12,30,1),(92,13,6,1),(92,13,29,1),(92,14,4,1),(92,15,20,1),(92,16,17,1),(92,17,5,1),(92,17,11,1),(92,18,3,1),(92,18,8,1),(92,18,16,1),(92,18,21,1),(92,18,27,1),(92,19,8,1),(92,19,10,1),(92,19,18,1),(92,19,27,1),(92,20,9,1),(92,20,14,1),(92,20,24,1),(92,20,31,1),(92,21,1,1),(92,21,12,1),(92,21,19,1),(92,21,23,1),(92,21,28,1),(92,22,13,1),(92,22,21,1),(92,22,24,1),(92,22,25,1),(92,22,28,1),(92,23,5,1),(92,23,7,1),(92,23,10,1),(92,23,11,1),(92,23,25,1),(92,24,2,1),(92,24,4,1),(92,24,15,1),(92,24,23,1),(92,24,26,1),(92,25,7,1),(92,25,13,1),(92,25,22,1),(92,25,29,1),(92,25,31,1),(92,26,6,1),(92,26,15,1),(92,26,16,1),(92,26,20,1),(92,26,30,1),(92,27,12,1),(92,27,14,1),(92,27,22,1),(92,27,29,1),(92,1,17,2),(92,1,31,2),(92,2,8,2),(92,2,9,2),(92,2,16,2),(92,2,22,2),(92,3,7,2),(92,3,13,2),(92,3,15,2),(92,3,20,2),(92,3,27,2),(92,3,30,2),(92,4,3,2),(92,4,7,2),(92,4,14,2),(92,4,22,2),(92,4,24,2),(92,4,28,2),(92,5,1,2),(92,5,4,2),(92,5,6,2),(92,5,13,2),(92,5,15,2),(92,6,10,2),(92,6,18,2),(92,6,19,2),(92,6,20,2),(92,6,28,2),(92,6,30,2),(92,7,2,2),(92,7,10,2),(92,7,23,2),(92,7,28,2),(92,8,4,2),(92,8,11,2),(92,8,12,2),(92,8,26,2),(92,8,29,2),(92,9,2,2),(92,9,17,2),(92,9,21,2),(92,9,24,2),(92,10,5,2),(92,10,12,2),(92,10,25,2),(92,11,7,2),(92,11,9,2),(92,11,11,2),(92,11,19,2),(92,12,23,2),(92,13,1,2),(92,13,2,2),(92,13,3,2),(92,13,13,2),(92,13,18,2),(92,13,24,2),(92,13,31,2),(92,14,6,2),(92,14,12,2),(92,14,20,2),(92,14,27,2),(92,15,1,2),(92,15,3,2),(92,15,4,2),(92,15,10,2),(92,15,11,2),(92,15,13,2),(92,15,19,2),(92,15,26,2),(92,15,30,2),(92,16,8,2),(92,16,14,2),(92,16,21,2),(92,16,27,2),(92,17,15,2),(92,17,19,2),(92,17,22,2),(92,17,23,2),(92,17,25,2),(92,18,31,2),(92,19,6,2),(92,19,11,2),(92,19,16,2),(92,19,21,2),(92,19,25,2),(92,20,3,2),(92,20,10,2),(92,20,12,2),(92,20,16,2),(92,20,30,2),(92,21,5,2),(92,22,4,2),(92,22,8,2),(92,22,29,2),(92,23,17,2),(92,24,9,2),(92,25,15,2),(92,26,1,2),(92,26,14,2),(92,26,26,2),(92,26,29,2),(92,27,1,2),(92,27,5,2),(92,27,9,2),(92,27,11,2),(92,27,18,2),(92,1,9,3),(92,1,10,3),(92,1,15,3),(92,1,21,3),(92,1,27,3),(92,1,28,3),(92,2,2,3),(92,2,12,3),(92,2,24,3),(92,3,3,3),(92,3,11,3),(92,3,16,3),(92,3,23,3),(92,3,31,3),(92,5,7,3),(92,5,17,3),(92,5,26,3),(92,7,6,3),(92,7,13,3),(92,7,19,3),(92,7,24,3),(92,7,31,3),(92,8,8,3),(92,8,15,3),(92,8,22,3),(92,9,5,3),(92,9,25,3),(92,9,30,3),(92,10,1,3),(92,10,18,3),(92,10,29,3),(92,11,4,3),(92,11,14,3),(92,11,20,3),(92,12,6,3),(92,12,13,3),(92,12,20,3),(92,12,26,3),(92,13,9,3),(92,13,14,3),(92,13,21,3),(92,13,27,3),(92,14,1,3),(92,14,9,3),(92,14,16,3),(92,14,23,3),(92,14,29,3),(92,15,8,3),(92,15,17,3),(92,15,22,3),(92,15,31,3),(92,16,4,3),(92,16,11,3),(92,16,18,3),(92,16,23,3),(92,16,28,3),(92,17,1,3),(92,17,7,3),(92,17,13,3),(92,17,29,3),(92,18,6,3),(92,18,12,3),(92,18,18,3),(92,18,24,3),(92,19,3,3),(92,19,14,3),(92,19,31,3),(92,20,7,3),(92,20,20,3),(92,20,27,3),(92,21,3,3),(92,21,8,3),(92,21,16,3),(92,21,25,3),(92,22,5,3),(92,22,10,3),(92,22,17,3),(92,23,2,3),(92,23,15,3),(92,23,21,3),(92,23,28,3),(92,24,5,3),(92,24,12,3),(92,24,19,3),(92,24,30,3),(92,25,4,3),(92,25,11,3),(92,25,19,3),(92,25,26,3),(92,26,4,3),(92,26,10,3),(92,26,22,3),(92,27,2,3),(92,27,25,3),(92,27,30,3);
/*!40000 ALTER TABLE `assignements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupingrules`
--

DROP TABLE IF EXISTS `groupingrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groupingrules` (
  `GroupingRuleID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PatternID` int DEFAULT NULL,
  `Duration` int DEFAULT NULL,
  `Max` int DEFAULT NULL,
  PRIMARY KEY (`GroupingRuleID`),
  KEY `FK_GroupingRules_Patern_idx` (`PatternID`),
  CONSTRAINT `fk_grr_patern` FOREIGN KEY (`PatternID`) REFERENCES `patterns` (`PatternID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupingrules`
--

LOCK TABLES `groupingrules` WRITE;
/*!40000 ALTER TABLE `groupingrules` DISABLE KEYS */;
INSERT INTO `groupingrules` VALUES (1,'Noćna smena sme da se pojavi najviše 1 put u 5 dana',3,5,1),(2,'Celodnevna sme da se pojavi najviše 1 put u 4 dana',12,4,1),(3,'1. smena sme da se pojavi najviše 3 puta u 5 dana',1,5,3),(4,'Noćna smena ne sme ni jednom da se pojavi',3,NULL,0),(5,'Noćna smena sme da se pojavi najviše 1 put u 3 dana',3,3,1),(6,'Celodnevna smena sme da se pojavi više 1 put u 3 dana',12,3,1),(7,'Druga smena ne sme nijednom da se pojavi',2,NULL,0),(8,'Celodnevna smena ne sme nijednom da se pojavi',12,NULL,0);
/*!40000 ALTER TABLE `groupingrules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mustworkshifts`
--

DROP TABLE IF EXISTS `mustworkshifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mustworkshifts` (
  `ScheduleID` int NOT NULL,
  `NurseID` int NOT NULL,
  `ShiftID` int NOT NULL,
  `DateFrom` int NOT NULL,
  `DateUntil` int DEFAULT NULL,
  PRIMARY KEY (`ScheduleID`,`DateFrom`,`ShiftID`,`NurseID`),
  KEY `mustworkshifts_nurses_nid_idx` (`NurseID`),
  KEY `mustworkshifts_nurses_shid_idx` (`ShiftID`),
  CONSTRAINT `mustworkshifts_nurses_nid` FOREIGN KEY (`NurseID`) REFERENCES `nurses` (`NurseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mustworkshifts_nurses_shid` FOREIGN KEY (`ShiftID`) REFERENCES `shifts` (`ShiftID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mws_shed` FOREIGN KEY (`ScheduleID`) REFERENCES `schedules` (`ScheduleID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mustworkshifts`
--

LOCK TABLES `mustworkshifts` WRITE;
/*!40000 ALTER TABLE `mustworkshifts` DISABLE KEYS */;
INSERT INTO `mustworkshifts` VALUES (92,1,1,1,5),(92,1,1,8,12),(92,12,3,13,13),(92,1,1,15,19),(92,1,1,22,26),(92,1,1,29,31);
/*!40000 ALTER TABLE `mustworkshifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nonworkingdays`
--

DROP TABLE IF EXISTS `nonworkingdays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nonworkingdays` (
  `ScheduleID` int NOT NULL,
  `NurseID` int NOT NULL,
  `DateFrom` int NOT NULL,
  `DateUntil` int NOT NULL,
  `NonWorkingDayTypeID` int DEFAULT NULL,
  `Must` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ScheduleID`,`NurseID`,`DateFrom`),
  KEY `FK_NonWorkingDays_NonWorkingDayTypes` (`NonWorkingDayTypeID`),
  KEY `FK_NonWorkingDays_Nurses` (`NurseID`),
  CONSTRAINT `FK_NonWorkingDays_NonWorkingDayTypes` FOREIGN KEY (`NonWorkingDayTypeID`) REFERENCES `nonworkingdaytypes` (`NonWorkingDayTypeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NonWorkingDays_Nurses` FOREIGN KEY (`NurseID`) REFERENCES `nurses` (`NurseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_nwd_sched` FOREIGN KEY (`ScheduleID`) REFERENCES `schedules` (`ScheduleID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nonworkingdays`
--

LOCK TABLES `nonworkingdays` WRITE;
/*!40000 ALTER TABLE `nonworkingdays` DISABLE KEYS */;
INSERT INTO `nonworkingdays` VALUES (92,4,8,12,2,1),(92,4,15,19,2,1),(92,5,16,16,1,0);
/*!40000 ALTER TABLE `nonworkingdays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nonworkingdaytypes`
--

DROP TABLE IF EXISTS `nonworkingdaytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nonworkingdaytypes` (
  `NonWorkingDayTypeID` int NOT NULL AUTO_INCREMENT,
  `Name` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Symbol` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NumberOfHours` float DEFAULT NULL,
  PRIMARY KEY (`NonWorkingDayTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nonworkingdaytypes`
--

LOCK TABLES `nonworkingdaytypes` WRITE;
/*!40000 ALTER TABLE `nonworkingdaytypes` DISABLE KEYS */;
INSERT INTO `nonworkingdaytypes` VALUES (1,'Slobodan dan','*',0),(2,'Godišnji odmor','go',7),(3,'Osmi mart','8III',7.25);
/*!40000 ALTER TABLE `nonworkingdaytypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nonworkingshifts`
--

DROP TABLE IF EXISTS `nonworkingshifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nonworkingshifts` (
  `ScheduleID` int NOT NULL,
  `NurseID` int NOT NULL,
  `DateFrom` int NOT NULL,
  `DateUntil` int NOT NULL,
  `ShiftID` int NOT NULL,
  `Must` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ScheduleID`,`NurseID`,`DateFrom`,`ShiftID`),
  KEY `FK_NonWorkingShifts_Shifts` (`ShiftID`),
  KEY `FK_NonWorkingShifts_Nurses` (`NurseID`),
  CONSTRAINT `FK_NonWorkingShifts_Nurses` FOREIGN KEY (`NurseID`) REFERENCES `nurses` (`NurseID`),
  CONSTRAINT `FK_NonWorkingShifts_Shifts` FOREIGN KEY (`ShiftID`) REFERENCES `shifts` (`ShiftID`),
  CONSTRAINT `fk_nws_sched` FOREIGN KEY (`ScheduleID`) REFERENCES `schedules` (`ScheduleID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nonworkingshifts`
--

LOCK TABLES `nonworkingshifts` WRITE;
/*!40000 ALTER TABLE `nonworkingshifts` DISABLE KEYS */;
INSERT INTO `nonworkingshifts` VALUES (92,8,25,25,1,1),(92,8,25,25,2,1);
/*!40000 ALTER TABLE `nonworkingshifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurses`
--

DROP TABLE IF EXISTS `nurses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurses` (
  `NurseID` int NOT NULL AUTO_INCREMENT,
  `Name` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Surname` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Experienced` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`NurseID`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurses`
--

LOCK TABLES `nurses` WRITE;
/*!40000 ALTER TABLE `nurses` DISABLE KEYS */;
INSERT INTO `nurses` VALUES (1,'Ružica','Nikolić',1),(2,'Snežana','Zdravković',1),(3,'Marija','Sokolov',1),(4,'Ana','Marković',1),(5,'Jelena','Cvetković',1),(6,'Dragana','Rister',1),(7,'Dragana','Pavlović',1),(8,'Ivana','Petković',1),(9,'Dijana','Skrčevski',1),(10,'Dragana','Vasiljević',1),(11,'Dragana','Hrnjački',1),(12,'Branislava','Jovčić',0),(13,'Slavica','Dušić',0),(14,'Stanislava','Hrnjak',0),(15,'Katarina','Mladenović',0),(16,'Milan','Spasojević',0),(17,'Ljiljana','Radović',0),(18,'Tanja','Pavlović',0),(19,'Danijela','Ilić',0),(20,'Sara','Ilić',0),(21,'Milica','Đurić',0),(22,'Danijela','Filiposki',0),(23,'Jelena','Ivetić',0),(24,'Marina','Ćetković',0),(25,'Branka','Bajić',0),(26,'Sanja','Simić',0),(27,'Nela','Stojković',0);
/*!40000 ALTER TABLE `nurses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurses_groupingrules`
--

DROP TABLE IF EXISTS `nurses_groupingrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurses_groupingrules` (
  `GroupingRuleID` int NOT NULL,
  `NurseID` int NOT NULL,
  PRIMARY KEY (`GroupingRuleID`,`NurseID`),
  KEY `FK_Grouping_Nurse_idx` (`GroupingRuleID`),
  KEY `FK_Nurse_Grouping` (`NurseID`),
  CONSTRAINT `FK_Grouping_Nurse` FOREIGN KEY (`GroupingRuleID`) REFERENCES `groupingrules` (`GroupingRuleID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Nurse_Grouping` FOREIGN KEY (`NurseID`) REFERENCES `nurses` (`NurseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurses_groupingrules`
--

LOCK TABLES `nurses_groupingrules` WRITE;
/*!40000 ALTER TABLE `nurses_groupingrules` DISABLE KEYS */;
INSERT INTO `nurses_groupingrules` VALUES (1,2),(1,3),(1,5),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),(1,22),(1,23),(1,24),(1,25),(1,26),(1,27),(2,2),(2,3),(2,5),(2,7),(2,8),(2,9),(2,10),(2,11),(2,12),(2,13),(2,14),(2,15),(2,17),(2,18),(2,19),(2,20),(2,21),(2,22),(2,23),(2,24),(2,25),(2,26),(2,27),(3,2),(3,3),(3,5),(3,7),(3,8),(3,9),(3,10),(3,11),(3,12),(3,13),(3,14),(3,15),(3,16),(3,17),(3,18),(3,19),(3,20),(3,21),(3,22),(3,23),(3,24),(3,25),(3,26),(3,27),(4,1),(4,6),(5,4),(6,4),(7,1),(8,1);
/*!40000 ALTER TABLE `nurses_groupingrules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurses_sequencerules`
--

DROP TABLE IF EXISTS `nurses_sequencerules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurses_sequencerules` (
  `SequenceRuleID` int NOT NULL,
  `NurseID` int NOT NULL,
  PRIMARY KEY (`SequenceRuleID`,`NurseID`),
  KEY `nsr_nurses_idx` (`NurseID`),
  CONSTRAINT `nsr_nurses` FOREIGN KEY (`NurseID`) REFERENCES `nurses` (`NurseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `nsr_sr` FOREIGN KEY (`SequenceRuleID`) REFERENCES `sequencerules` (`SequenceRuleID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurses_sequencerules`
--

LOCK TABLES `nurses_sequencerules` WRITE;
/*!40000 ALTER TABLE `nurses_sequencerules` DISABLE KEYS */;
INSERT INTO `nurses_sequencerules` VALUES (1,1),(2,1),(3,1),(4,1),(6,1),(7,1),(1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(1,3),(2,3),(3,3),(4,3),(5,3),(6,3),(7,3),(1,4),(2,4),(3,4),(4,4),(5,4),(6,4),(7,4),(1,5),(2,5),(3,5),(4,5),(5,5),(6,5),(7,5),(1,6),(2,6),(3,6),(4,6),(5,6),(6,6),(7,6),(1,7),(2,7),(3,7),(4,7),(5,7),(6,7),(7,7),(1,8),(2,8),(3,8),(4,8),(5,8),(6,8),(7,8),(1,9),(2,9),(3,9),(4,9),(5,9),(6,9),(7,9),(1,10),(2,10),(3,10),(4,10),(5,10),(6,10),(7,10),(1,11),(2,11),(3,11),(4,11),(5,11),(6,11),(7,11),(1,12),(2,12),(3,12),(4,12),(5,12),(6,12),(7,12),(1,13),(2,13),(3,13),(4,13),(5,13),(6,13),(7,13),(1,14),(2,14),(3,14),(4,14),(5,14),(6,14),(7,14),(1,15),(2,15),(3,15),(4,15),(5,15),(6,15),(7,15),(1,16),(2,16),(3,16),(4,16),(5,16),(6,16),(7,16),(1,17),(2,17),(3,17),(4,17),(5,17),(6,17),(7,17),(1,18),(2,18),(3,18),(4,18),(5,18),(6,18),(7,18),(1,19),(2,19),(3,19),(4,19),(5,19),(6,19),(7,19),(1,20),(2,20),(3,20),(4,20),(5,20),(6,20),(7,20),(1,21),(2,21),(3,21),(4,21),(5,21),(6,21),(7,21),(1,22),(2,22),(3,22),(4,22),(5,22),(6,22),(7,22),(1,23),(2,23),(3,23),(4,23),(5,23),(6,23),(7,23),(1,24),(2,24),(3,24),(4,24),(5,24),(6,24),(7,24),(1,25),(2,25),(3,25),(4,25),(5,25),(6,25),(7,25),(1,26),(2,26),(3,26),(4,26),(5,26),(6,26),(7,26),(1,27),(2,27),(3,27),(4,27),(5,27),(6,27),(7,27);
/*!40000 ALTER TABLE `nurses_sequencerules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parameters`
--

DROP TABLE IF EXISTS `parameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parameters` (
  `ParameterID` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` char(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Number` int DEFAULT NULL,
  PRIMARY KEY (`ParameterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parameters`
--

LOCK TABLES `parameters` WRITE;
/*!40000 ALTER TABLE `parameters` DISABLE KEYS */;
INSERT INTO `parameters` VALUES ('M1','Težina odstupanja od kriterijuma 1. prioriteta',1000000),('M2','Težina odstupanja od kriterijuma 2. prioriteta',10000),('M3','Težina odstupanja od kriterijuma 3. prioriteta',1000),('M4','Težina odstupanja od kriterijuma 4. prioriteta',1000),('M5','Težina odstušanja od kriterijuma 5. prioriteta',1),('ne','Minimalni broj iskusnih sestara u svakoj smeni',1),('ns','Minimalan broj sestara potreban u smeni jakog intenziteta',2),('nsi','Idealan broj sestara potreban u smeni slabog intenziteta',3),('nw','Minimalan broj sestara potreban u smeni slabog intenziteta',2),('nwi','Idealan broj sestara potreban u smeni slabog intenziteta',3),('wtwd','Obračunsko vreme radnog dana',7);
/*!40000 ALTER TABLE `parameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pattern_shift`
--

DROP TABLE IF EXISTS `pattern_shift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pattern_shift` (
  `PatternID` int NOT NULL,
  `ShiftID` int NOT NULL,
  `Includes` bit(1) NOT NULL,
  PRIMARY KEY (`PatternID`,`ShiftID`),
  KEY `ps_shift_idx` (`ShiftID`),
  CONSTRAINT `ps_pattern` FOREIGN KEY (`PatternID`) REFERENCES `patterns` (`PatternID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ps_shift` FOREIGN KEY (`ShiftID`) REFERENCES `shifts` (`ShiftID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pattern_shift`
--

LOCK TABLES `pattern_shift` WRITE;
/*!40000 ALTER TABLE `pattern_shift` DISABLE KEYS */;
INSERT INTO `pattern_shift` VALUES (0,1,_binary '\0'),(0,2,_binary '\0'),(0,3,_binary '\0'),(1,1,_binary ''),(1,2,_binary '\0'),(1,3,_binary '\0'),(2,1,_binary '\0'),(2,2,_binary ''),(2,3,_binary '\0'),(3,1,_binary '\0'),(3,2,_binary '\0'),(3,3,_binary ''),(12,1,_binary ''),(12,2,_binary ''),(12,3,_binary '\0');
/*!40000 ALTER TABLE `pattern_shift` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patterns`
--

DROP TABLE IF EXISTS `patterns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patterns` (
  `PatternID` int NOT NULL,
  `Duration` float DEFAULT NULL,
  `Name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Symbol` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PatternID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patterns`
--

LOCK TABLES `patterns` WRITE;
/*!40000 ALTER TABLE `patterns` DISABLE KEYS */;
INSERT INTO `patterns` VALUES (0,0,'Neradna','0'),(1,7.25,'Prva smena','1'),(2,6.25,'Druga smena','2'),(3,12.25,'Treća smena','3'),(12,12.25,'Celodnevna smena','12');
/*!40000 ALTER TABLE `patterns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedules` (
  `ScheduleID` int NOT NULL AUTO_INCREMENT,
  `GeneratedOn` date DEFAULT NULL,
  `Month` int DEFAULT NULL,
  `Year` int DEFAULT NULL,
  `Name` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Percentage` double DEFAULT NULL,
  `NumberOfDays` int DEFAULT NULL,
  `WorkingDays` int DEFAULT NULL,
  `Chosen` bit(1) DEFAULT b'0',
  PRIMARY KEY (`ScheduleID`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
INSERT INTO `schedules` VALUES (92,'2022-08-29',8,2022,'avg',NULL,31,22,_binary '');
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequencerules`
--

DROP TABLE IF EXISTS `sequencerules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequencerules` (
  `SequenceRuleID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SequenceRuleID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequencerules`
--

LOCK TABLES `sequencerules` WRITE;
/*!40000 ALTER TABLE `sequencerules` DISABLE KEYS */;
INSERT INTO `sequencerules` VALUES (1,'Posle noćne smene ne može da bude 1. smena'),(2,'Posle noćne smene ne može da bude 2. smena'),(3,'Posle noćne smene ne može da bude celodnevna smena'),(4,'Ne sme više od 3 neradna dana za redom'),(5,'1. smena najviše 2 puta za redom'),(6,'Posle celodnevne smene ne može 1. smena'),(7,'Posle celodnevne smene ne može celodnevna smena');
/*!40000 ALTER TABLE `sequencerules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequencerulesmembers`
--

DROP TABLE IF EXISTS `sequencerulesmembers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequencerulesmembers` (
  `SequenceRuleID` int NOT NULL,
  `SequenceRuleMemberID` int NOT NULL,
  `PatternID` int DEFAULT NULL,
  PRIMARY KEY (`SequenceRuleID`,`SequenceRuleMemberID`),
  KEY `SequenceRuleID_idx` (`SequenceRuleID`),
  KEY `FK_Shift_SeqRulMem_idx` (`PatternID`),
  CONSTRAINT `FK_SeqRul_SeqRulMem` FOREIGN KEY (`SequenceRuleID`) REFERENCES `sequencerules` (`SequenceRuleID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_srm_patern` FOREIGN KEY (`PatternID`) REFERENCES `patterns` (`PatternID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequencerulesmembers`
--

LOCK TABLES `sequencerulesmembers` WRITE;
/*!40000 ALTER TABLE `sequencerulesmembers` DISABLE KEYS */;
INSERT INTO `sequencerulesmembers` VALUES (4,1,0),(4,2,0),(4,3,0),(4,4,0),(1,2,1),(5,1,1),(5,2,1),(5,3,1),(6,2,1),(2,2,2),(1,1,3),(2,1,3),(3,1,3),(3,2,12),(6,1,12),(7,1,12),(7,2,12);
/*!40000 ALTER TABLE `sequencerulesmembers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shifts`
--

DROP TABLE IF EXISTS `shifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shifts` (
  `ShiftID` int NOT NULL AUTO_INCREMENT,
  `StrongIntensity` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ShiftID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shifts`
--

LOCK TABLES `shifts` WRITE;
/*!40000 ALTER TABLE `shifts` DISABLE KEYS */;
INSERT INTO `shifts` VALUES (1,1),(2,0),(3,0);
/*!40000 ALTER TABLE `shifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialneedsshifts`
--

DROP TABLE IF EXISTS `specialneedsshifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialneedsshifts` (
  `ScheduleID` int NOT NULL,
  `Day` int NOT NULL,
  `ShiftID` int NOT NULL,
  `NumberOfNurses` int DEFAULT NULL,
  PRIMARY KEY (`ScheduleID`,`Day`,`ShiftID`),
  KEY `specialneedshifts_shifts_shid_idx` (`ShiftID`),
  CONSTRAINT `specialneedshifts_shifts_schid` FOREIGN KEY (`ScheduleID`) REFERENCES `schedules` (`ScheduleID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `specialneedshifts_shifts_shid` FOREIGN KEY (`ShiftID`) REFERENCES `shifts` (`ShiftID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialneedsshifts`
--

LOCK TABLES `specialneedsshifts` WRITE;
/*!40000 ALTER TABLE `specialneedsshifts` DISABLE KEYS */;
INSERT INTO `specialneedsshifts` VALUES (92,4,1,4),(92,4,2,4),(92,4,3,4),(92,30,1,4),(92,30,2,4);
/*!40000 ALTER TABLE `specialneedsshifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysdiagrams`
--

DROP TABLE IF EXISTS `sysdiagrams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysdiagrams` (
  `name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `principal_id` int NOT NULL,
  `diagram_id` int NOT NULL,
  `version` int DEFAULT NULL,
  `definition` longblob,
  PRIMARY KEY (`diagram_id`),
  UNIQUE KEY `UK_principal_name` (`principal_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysdiagrams`
--

LOCK TABLES `sysdiagrams` WRITE;
/*!40000 ALTER TABLE `sysdiagrams` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysdiagrams` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-15 15:33:28
