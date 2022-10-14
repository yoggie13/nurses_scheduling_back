/*
SQLyog Community v13.1.9 (64 bit)
MySQL - 8.0.30 : Database - nurses_scheduling
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`nurses_scheduling` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `nurses_scheduling`;

/*Table structure for table `assignements` */

DROP TABLE IF EXISTS `assignements`;

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

/*Data for the table `assignements` */

insert  into `assignements`(`ScheduleID`,`NurseID`,`Day`,`PatternID`) values 
(94,17,27,1),
(94,17,28,1),
(94,17,29,1),
(94,20,30,1),
(95,4,8,1),
(95,4,11,1),
(95,5,2,1),
(95,5,19,1),
(95,5,28,1),
(95,6,3,1),
(95,6,7,1),
(95,6,16,1),
(95,6,23,1),
(95,7,10,1),
(95,7,12,1),
(95,7,18,1),
(95,8,5,1),
(95,8,27,1),
(95,9,1,1),
(95,9,7,1),
(95,9,15,1),
(95,9,19,1),
(95,9,22,1),
(95,9,25,1),
(95,9,30,1),
(95,10,3,1),
(95,10,13,1),
(95,10,17,1),
(95,10,21,1),
(95,10,24,1),
(95,11,4,1),
(95,11,11,1),
(95,11,21,1),
(95,11,26,1),
(95,11,29,1),
(95,12,5,1),
(95,12,20,1),
(95,13,10,1),
(95,13,12,1),
(95,13,13,1),
(95,13,31,1),
(95,14,6,1),
(95,14,8,1),
(95,14,17,1),
(95,14,23,1),
(95,14,29,1),
(95,15,28,1),
(95,17,5,1),
(95,17,16,1),
(95,17,22,1),
(95,17,25,1),
(95,17,26,1),
(95,18,9,1),
(95,18,10,1),
(95,18,17,1),
(95,18,18,1),
(95,18,21,1),
(95,18,25,1),
(95,19,6,1),
(95,19,11,1),
(95,20,2,1),
(95,20,22,1),
(95,21,4,1),
(95,21,19,1),
(95,21,23,1),
(95,21,24,1),
(95,21,27,1),
(95,21,30,1),
(95,23,14,1),
(95,23,16,1),
(95,23,18,1),
(95,23,20,1),
(95,23,24,1),
(95,23,28,1),
(95,24,1,1),
(95,24,3,1),
(95,24,4,1),
(95,24,7,1),
(95,24,9,1),
(95,24,14,1),
(95,24,15,1),
(95,24,27,1),
(95,24,31,1),
(94,13,28,2),
(94,16,29,2),
(94,19,28,2),
(94,19,30,2),
(95,4,12,2),
(95,4,15,2),
(95,4,23,2),
(95,5,3,2),
(95,5,25,2),
(95,6,5,2),
(95,6,6,2),
(95,6,8,2),
(95,6,10,2),
(95,6,12,2),
(95,6,18,2),
(95,6,24,2),
(95,6,28,2),
(95,7,2,2),
(95,7,7,2),
(95,7,9,2),
(95,7,15,2),
(95,7,17,2),
(95,7,19,2),
(95,7,20,2),
(95,7,21,2),
(95,7,24,2),
(95,7,29,2),
(95,8,4,2),
(95,8,16,2),
(95,8,30,2),
(95,9,4,2),
(95,9,11,2),
(95,9,23,2),
(95,10,4,2),
(95,10,16,2),
(95,10,27,2),
(95,11,3,2),
(95,11,10,2),
(95,11,20,2),
(95,11,22,2),
(95,11,24,2),
(95,12,1,2),
(95,12,14,2),
(95,12,16,2),
(95,12,25,2),
(95,12,30,2),
(95,12,31,2),
(95,13,2,2),
(95,13,5,2),
(95,13,6,2),
(95,13,19,2),
(95,13,21,2),
(95,13,27,2),
(95,13,28,2),
(95,14,13,2),
(95,14,22,2),
(95,15,10,2),
(95,15,14,2),
(95,15,17,2),
(95,15,18,2),
(95,16,3,2),
(95,16,7,2),
(95,16,26,2),
(95,16,29,2),
(95,17,9,2),
(95,17,21,2),
(95,18,11,2),
(95,18,23,2),
(95,19,22,2),
(95,19,26,2),
(95,20,5,2),
(95,20,7,2),
(95,21,8,2),
(95,21,13,2),
(95,21,18,2),
(95,21,31,2),
(95,22,17,2),
(95,22,28,2),
(95,23,1,2),
(95,23,27,2),
(95,24,11,2),
(95,24,19,2),
(95,24,25,2),
(94,4,29,3),
(94,5,30,3),
(94,7,27,3),
(94,9,29,3),
(94,10,28,3),
(94,11,27,3),
(94,13,30,3),
(94,15,29,3),
(94,18,28,3),
(94,21,27,3),
(94,21,30,3),
(94,23,28,3),
(95,4,5,3),
(95,4,9,3),
(95,4,13,3),
(95,4,16,3),
(95,4,19,3),
(95,4,24,3),
(95,4,28,3),
(95,4,31,3),
(95,5,4,3),
(95,5,10,3),
(95,5,15,3),
(95,5,20,3),
(95,5,23,3),
(95,5,26,3),
(95,5,29,3),
(95,7,3,3),
(95,7,22,3),
(95,7,25,3),
(95,7,30,3),
(95,8,1,3),
(95,8,6,3),
(95,8,10,3),
(95,8,14,3),
(95,8,17,3),
(95,8,21,3),
(95,8,25,3),
(95,9,2,3),
(95,9,13,3),
(95,9,16,3),
(95,9,27,3),
(95,10,8,3),
(95,10,11,3),
(95,10,18,3),
(95,10,28,3),
(95,11,1,3),
(95,11,7,3),
(95,11,12,3),
(95,11,18,3),
(95,12,8,3),
(95,12,11,3),
(95,12,17,3),
(95,12,21,3),
(95,12,27,3),
(95,13,8,3),
(95,13,16,3),
(95,13,24,3),
(95,14,1,3),
(95,14,4,3),
(95,14,9,3),
(95,14,15,3),
(95,14,20,3),
(95,14,24,3),
(95,14,27,3),
(95,14,31,3),
(95,15,2,3),
(95,15,6,3),
(95,15,12,3),
(95,15,19,3),
(95,15,22,3),
(95,15,29,3),
(95,17,12,3),
(95,17,19,3),
(95,17,23,3),
(95,17,31,3),
(95,18,2,3),
(95,18,5,3),
(95,18,14,3),
(95,18,28,3),
(95,19,4,3),
(95,19,7,3),
(95,19,14,3),
(95,19,17,3),
(95,19,20,3),
(95,19,23,3),
(95,19,30,3),
(95,20,26,3),
(95,20,30,3),
(95,21,5,3),
(95,21,9,3),
(95,21,15,3),
(95,22,3,3),
(95,22,6,3),
(95,22,10,3),
(95,22,13,3),
(95,22,18,3),
(95,22,22,3),
(95,22,26,3),
(95,23,3,3),
(95,23,7,3),
(95,23,11,3),
(95,23,21,3),
(95,23,25,3),
(95,23,29,3),
(94,4,27,12),
(94,5,28,12),
(94,6,30,12),
(94,8,29,12),
(94,9,27,12),
(94,12,30,12),
(94,15,27,12),
(94,22,29,12),
(95,4,1,12),
(95,5,6,12),
(95,5,13,12),
(95,6,20,12),
(95,6,26,12),
(95,6,30,12),
(95,9,9,12),
(95,10,15,12),
(95,11,14,12),
(95,11,31,12),
(95,19,12,12),
(95,19,29,12),
(95,21,2,12),
(95,22,8,12);

/*Table structure for table `groupingrules` */

DROP TABLE IF EXISTS `groupingrules`;

CREATE TABLE `groupingrules` (
  `GroupingRuleID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PatternID` int DEFAULT NULL,
  `Duration` int DEFAULT NULL,
  `MaxOccurences` int DEFAULT NULL,
  `Active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`GroupingRuleID`),
  KEY `FK_GroupingRules_Patern_idx` (`PatternID`),
  CONSTRAINT `fk_grr_patern` FOREIGN KEY (`PatternID`) REFERENCES `patterns` (`PatternID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `groupingrules` */

insert  into `groupingrules`(`GroupingRuleID`,`Name`,`PatternID`,`Duration`,`MaxOccurences`,`Active`) values 
(1,'Noćna smena sme da se pojavi najviše 1 put u 3 dana',3,3,1,1),
(2,'Celodnevna sme da se pojavi najviše 1 put u 3 dana',12,3,1,1),
(3,'1. smena sme da se pojavi najviše 3 puta u 5 dana',1,5,3,1),
(4,'Noćna smena ne sme ni jednom da se pojavi',3,NULL,0,1),
(5,'Noćna smena sme da se pojavi najviše 1 put u 3 dana',3,3,1,1),
(6,'Celodnevna smena sme da se pojavi više 1 put u 3 dana',12,3,1,1),
(7,'Druga smena ne sme nijednom da se pojavi',2,NULL,0,1),
(8,'Celodnevna smena ne sme nijednom da se pojavi',12,NULL,0,1);

/*Table structure for table `mustworkshifts` */

DROP TABLE IF EXISTS `mustworkshifts`;

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

/*Data for the table `mustworkshifts` */

insert  into `mustworkshifts`(`ScheduleID`,`NurseID`,`ShiftID`,`DateFrom`,`DateUntil`) values 
(94,1,1,1,2),
(94,1,1,5,9),
(94,1,1,26,30);

/*Table structure for table `nonworkingdays` */

DROP TABLE IF EXISTS `nonworkingdays`;

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

/*Data for the table `nonworkingdays` */

insert  into `nonworkingdays`(`ScheduleID`,`NurseID`,`DateFrom`,`DateUntil`,`NonWorkingDayTypeID`,`Must`) values 
(94,2,2,2,1,1),
(94,5,15,16,2,1),
(94,5,19,19,2,1),
(94,16,10,9,2,1),
(94,16,12,16,2,1),
(94,18,22,22,1,1),
(95,1,5,6,1,1),
(95,1,12,13,1,1),
(95,4,18,18,1,1),
(95,4,25,26,4,1),
(95,5,22,22,1,1),
(95,7,26,28,5,1),
(95,8,8,8,1,1),
(95,8,18,19,3,1),
(95,10,9,9,1,1),
(95,11,9,9,1,1),
(95,11,16,16,1,1),
(95,13,22,23,4,1),
(95,14,18,19,4,1),
(95,15,23,24,4,1),
(95,16,8,9,1,1),
(95,16,10,14,2,1),
(95,16,15,16,1,1),
(95,16,17,21,2,1),
(95,16,22,23,1,1),
(95,17,1,3,1,1),
(95,17,27,28,4,1),
(95,20,8,9,1,1),
(95,20,10,14,2,1),
(95,20,15,16,1,1),
(95,20,17,20,2,1),
(95,23,6,6,3,1),
(95,24,20,21,4,1);

/*Table structure for table `nonworkingdaytypes` */

DROP TABLE IF EXISTS `nonworkingdaytypes`;

CREATE TABLE `nonworkingdaytypes` (
  `NonWorkingDayTypeID` int NOT NULL AUTO_INCREMENT,
  `Name` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Symbol` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NumberOfHours` float DEFAULT NULL,
  `Active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`NonWorkingDayTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `nonworkingdaytypes` */

insert  into `nonworkingdaytypes`(`NonWorkingDayTypeID`,`Name`,`Symbol`,`NumberOfHours`,`Active`) values 
(1,'Slobodan dan','*',0,1),
(2,'Godišnji odmor','go',8,1),
(3,'Osmi mart','8III',7.25,1),
(4,'Vakcina','v',7.25,1),
(5,'Slava','s',7.25,1),
(6,'Plaćeni slobodan dan','pl',7.25,1);

/*Table structure for table `nonworkingshifts` */

DROP TABLE IF EXISTS `nonworkingshifts`;

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

/*Data for the table `nonworkingshifts` */

insert  into `nonworkingshifts`(`ScheduleID`,`NurseID`,`DateFrom`,`DateUntil`,`ShiftID`,`Must`) values 
(94,5,17,18,1,1),
(94,5,17,18,2,1),
(94,5,17,18,3,1),
(94,8,21,24,1,1),
(94,8,21,24,2,1),
(94,16,10,11,1,1),
(94,16,10,11,2,1),
(94,16,10,11,3,1),
(94,16,17,18,1,1),
(94,16,17,18,2,1),
(94,16,17,18,3,1),
(95,16,15,16,1,1),
(95,16,15,16,2,1),
(95,16,15,16,3,1),
(95,16,22,23,1,1),
(95,16,22,23,2,1),
(95,16,22,23,3,1),
(95,20,8,9,1,1),
(95,20,8,9,2,1),
(95,20,8,9,3,1),
(95,20,15,16,1,1),
(95,20,15,16,2,1),
(95,20,15,16,3,1);

/*Table structure for table `nurses` */

DROP TABLE IF EXISTS `nurses`;

CREATE TABLE `nurses` (
  `NurseID` int NOT NULL AUTO_INCREMENT,
  `Name` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Surname` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Experienced` tinyint(1) DEFAULT NULL,
  `Main` tinyint(1) DEFAULT '0',
  `Active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`NurseID`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `nurses` */

insert  into `nurses`(`NurseID`,`Name`,`Surname`,`Experienced`,`Main`,`Active`) values 
(1,'Ružica','Nikolić',1,1,1),
(2,'Snežana','Zdravković',1,1,1),
(3,'Marija','Sokolov',1,1,1),
(4,'Ana','Marković',1,0,1),
(5,'Jelena','Cvetković',1,0,1),
(6,'Dragana','Rister',1,0,1),
(7,'Dragana','Pavlović',1,0,1),
(8,'Ivana','Petković',1,0,1),
(9,'Dijana','Skrčevski',1,0,1),
(10,'Dragana','Vasiljević',1,0,1),
(11,'Dragana','Hrnjački',1,0,1),
(12,'Branislava','Jovčić',0,0,1),
(13,'Slavica','Dušić',0,0,1),
(14,'Stanislavka','Hrnjak',0,0,1),
(15,'Katarina','Mladenović',0,0,1),
(16,'Milan','Spasojević',0,0,1),
(17,'Ljiljana','Radović',0,0,1),
(18,'Tanja','Pavlović',0,0,1),
(19,'Danijela','Ilić',0,0,1),
(20,'Sara','Ilić',0,0,1),
(21,'Milica','Đurić',0,0,1),
(22,'Danijela','Filiposki',0,0,1),
(23,'Nina','Ilić',0,0,1),
(24,'Jelena','Ivetić',0,0,1),
(25,'Branka','Bajić',0,0,0),
(26,'Sanja','Simić',0,0,0),
(27,'Nela','Stojković',0,0,0),
(87,'Test','Test',0,0,0);

/*Table structure for table `nurses_groupingrules` */

DROP TABLE IF EXISTS `nurses_groupingrules`;

CREATE TABLE `nurses_groupingrules` (
  `GroupingRuleID` int NOT NULL,
  `NurseID` int NOT NULL,
  PRIMARY KEY (`GroupingRuleID`,`NurseID`),
  KEY `FK_Grouping_Nurse_idx` (`GroupingRuleID`),
  KEY `FK_Nurse_Grouping` (`NurseID`),
  CONSTRAINT `FK_Grouping_Nurse` FOREIGN KEY (`GroupingRuleID`) REFERENCES `groupingrules` (`GroupingRuleID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Nurse_Grouping` FOREIGN KEY (`NurseID`) REFERENCES `nurses` (`NurseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `nurses_groupingrules` */

insert  into `nurses_groupingrules`(`GroupingRuleID`,`NurseID`) values 
(1,4),
(1,5),
(1,7),
(1,8),
(1,9),
(1,10),
(1,11),
(1,12),
(1,13),
(1,14),
(1,15),
(1,16),
(1,17),
(1,18),
(1,19),
(1,20),
(1,21),
(1,22),
(1,23),
(1,24),
(2,5),
(2,7),
(2,8),
(2,9),
(2,10),
(2,11),
(2,12),
(2,13),
(2,14),
(2,15),
(2,17),
(2,18),
(2,19),
(2,20),
(2,21),
(2,22),
(2,23),
(2,24),
(3,5),
(3,7),
(3,8),
(3,9),
(3,10),
(3,11),
(3,12),
(3,13),
(3,14),
(3,15),
(3,16),
(3,17),
(3,18),
(3,19),
(3,20),
(3,21),
(3,22),
(3,23),
(3,24),
(4,6),
(4,24),
(5,4),
(6,4),
(8,24);

/*Table structure for table `nurses_sequencerules` */

DROP TABLE IF EXISTS `nurses_sequencerules`;

CREATE TABLE `nurses_sequencerules` (
  `SequenceRuleID` int NOT NULL,
  `NurseID` int NOT NULL,
  PRIMARY KEY (`SequenceRuleID`,`NurseID`),
  KEY `nsr_nurses_idx` (`NurseID`),
  CONSTRAINT `nsr_nurses` FOREIGN KEY (`NurseID`) REFERENCES `nurses` (`NurseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `nsr_sr` FOREIGN KEY (`SequenceRuleID`) REFERENCES `sequencerules` (`SequenceRuleID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `nurses_sequencerules` */

insert  into `nurses_sequencerules`(`SequenceRuleID`,`NurseID`) values 
(1,4),
(2,4),
(3,4),
(4,4),
(5,4),
(6,4),
(7,4),
(1,5),
(2,5),
(3,5),
(4,5),
(5,5),
(6,5),
(7,5),
(1,6),
(2,6),
(3,6),
(4,6),
(5,6),
(6,6),
(7,6),
(1,7),
(2,7),
(3,7),
(4,7),
(5,7),
(6,7),
(7,7),
(1,8),
(2,8),
(3,8),
(4,8),
(5,8),
(6,8),
(7,8),
(1,9),
(2,9),
(3,9),
(4,9),
(5,9),
(6,9),
(7,9),
(1,10),
(2,10),
(3,10),
(4,10),
(5,10),
(6,10),
(7,10),
(1,11),
(2,11),
(3,11),
(4,11),
(5,11),
(6,11),
(7,11),
(1,12),
(2,12),
(3,12),
(4,12),
(5,12),
(6,12),
(7,12),
(1,13),
(2,13),
(3,13),
(4,13),
(5,13),
(6,13),
(7,13),
(1,14),
(2,14),
(3,14),
(4,14),
(5,14),
(6,14),
(7,14),
(1,15),
(2,15),
(3,15),
(4,15),
(5,15),
(6,15),
(7,15),
(1,16),
(2,16),
(3,16),
(4,16),
(5,16),
(6,16),
(7,16),
(1,17),
(2,17),
(3,17),
(4,17),
(6,17),
(7,17),
(1,18),
(2,18),
(3,18),
(4,18),
(5,18),
(6,18),
(7,18),
(1,19),
(2,19),
(3,19),
(4,19),
(5,19),
(6,19),
(7,19),
(1,20),
(2,20),
(3,20),
(4,20),
(5,20),
(6,20),
(7,20),
(1,21),
(2,21),
(3,21),
(4,21),
(5,21),
(6,21),
(7,21),
(1,22),
(2,22),
(3,22),
(4,22),
(5,22),
(6,22),
(7,22),
(1,23),
(2,23),
(3,23),
(4,23),
(5,23),
(6,23),
(7,23),
(1,24),
(2,24),
(3,24),
(4,24),
(5,24),
(6,24),
(7,24);

/*Table structure for table `parameters` */

DROP TABLE IF EXISTS `parameters`;

CREATE TABLE `parameters` (
  `ParameterID` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` char(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Number` int DEFAULT NULL,
  PRIMARY KEY (`ParameterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `parameters` */

insert  into `parameters`(`ParameterID`,`Name`,`Number`) values 
('M1','Težina odstupanja od kriterijuma 1. prioriteta',1000000),
('M2','Težina odstupanja od kriterijuma 2. prioriteta',10000),
('M3','Težina odstupanja od kriterijuma 3. prioriteta',1000),
('M4','Težina odstupanja od kriterijuma 4. prioriteta',1000),
('M5','Težina odstušanja od kriterijuma 5. prioriteta',1),
('ne','Minimalni broj iskusnih sestara u svakoj smeni',1),
('ns','Minimalan broj sestara potreban u smeni jakog intenziteta',3),
('nsi','Idealan broj sestara potreban u smeni jakog intenziteta',3),
('nw','Minimalan broj sestara potreban u smeni slabog intenziteta',3),
('nwi','Idealan broj sestara potreban u smeni slabog intenziteta',3),
('wtwd','Obračunsko vreme radnog dana',7);

/*Table structure for table `pattern_shift` */

DROP TABLE IF EXISTS `pattern_shift`;

CREATE TABLE `pattern_shift` (
  `PatternID` int NOT NULL,
  `ShiftID` int NOT NULL,
  `Includes` tinyint(1) NOT NULL,
  PRIMARY KEY (`PatternID`,`ShiftID`),
  KEY `ps_shift_idx` (`ShiftID`),
  CONSTRAINT `ps_pattern` FOREIGN KEY (`PatternID`) REFERENCES `patterns` (`PatternID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ps_shift` FOREIGN KEY (`ShiftID`) REFERENCES `shifts` (`ShiftID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `pattern_shift` */

insert  into `pattern_shift`(`PatternID`,`ShiftID`,`Includes`) values 
(0,1,0),
(0,2,0),
(0,3,0),
(1,1,1),
(1,2,0),
(1,3,0),
(2,1,0),
(2,2,1),
(2,3,0),
(3,1,0),
(3,2,0),
(3,3,1),
(12,1,1),
(12,2,1),
(12,3,0);

/*Table structure for table `patterns` */

DROP TABLE IF EXISTS `patterns`;

CREATE TABLE `patterns` (
  `PatternID` int NOT NULL,
  `Duration` float DEFAULT NULL,
  `Name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Symbol` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PatternID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `patterns` */

insert  into `patterns`(`PatternID`,`Duration`,`Name`,`Symbol`) values 
(0,0,'Neradna','0'),
(1,7.25,'Prva smena','1'),
(2,6.25,'Druga smena','2'),
(3,12.25,'Treća smena','3'),
(12,12.25,'Celodnevna smena','12');

/*Table structure for table `schedules` */

DROP TABLE IF EXISTS `schedules`;

CREATE TABLE `schedules` (
  `ScheduleID` int NOT NULL AUTO_INCREMENT,
  `GeneratedOn` date DEFAULT NULL,
  `Month` int DEFAULT NULL,
  `Year` int DEFAULT NULL,
  `Name` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NumberOfDays` int DEFAULT NULL,
  `WorkingDays` int DEFAULT NULL,
  `Chosen` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ScheduleID`)
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `schedules` */

insert  into `schedules`(`ScheduleID`,`GeneratedOn`,`Month`,`Year`,`Name`,`NumberOfDays`,`WorkingDays`,`Chosen`) values 
(94,'2022-09-23',9,2022,'tests',30,20,1),
(95,'2022-09-25',10,2022,'Oktobar',31,23,1);

/*Table structure for table `sequencerules` */

DROP TABLE IF EXISTS `sequencerules`;

CREATE TABLE `sequencerules` (
  `SequenceRuleID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`SequenceRuleID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `sequencerules` */

insert  into `sequencerules`(`SequenceRuleID`,`Name`,`Active`) values 
(1,'Posle noćne smene ne može da bude 1. smena',1),
(2,'Posle noćne smene ne može da bude 2. smena',1),
(3,'Posle noćne smene ne može da bude celodnevna smena',1),
(4,'Ne sme više od 3 neradna dana za redom',1),
(5,'1. smena najviše 2 puta za redom',1),
(6,'Posle celodnevne smene ne može 1. smena',1),
(7,'Posle celodnevne smene ne može celodnevna smena',1),
(10,'Ne može 4 dana zaredom 1122',1),
(11,'Ne može 4 dana zaredom 2211',1),
(12,'Ne može 4 dana zaredom 1212',1),
(13,'Ne može 4 dana zaredom 2121',1),
(14,'Ne može 4 dana zaredom 2221',1),
(15,'Ne može 4 dana zaredom 2122',1),
(16,'Ne može 4 dana zaredom 1222',1),
(17,'Ne može 4 dana zaredom 2222',1),
(18,NULL,1);

/*Table structure for table `sequencerulesmembers` */

DROP TABLE IF EXISTS `sequencerulesmembers`;

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

/*Data for the table `sequencerulesmembers` */

insert  into `sequencerulesmembers`(`SequenceRuleID`,`SequenceRuleMemberID`,`PatternID`) values 
(4,1,0),
(4,2,0),
(4,3,0),
(4,4,0),
(1,2,1),
(5,1,1),
(5,2,1),
(5,3,1),
(6,2,1),
(10,1,1),
(10,2,1),
(11,3,1),
(11,4,1),
(12,1,1),
(12,3,1),
(13,2,1),
(13,4,1),
(14,4,1),
(15,2,1),
(16,1,1),
(18,2,1),
(18,3,1),
(2,2,2),
(10,3,2),
(10,4,2),
(11,1,2),
(11,2,2),
(12,2,2),
(12,4,2),
(13,1,2),
(13,3,2),
(14,1,2),
(14,2,2),
(14,3,2),
(15,1,2),
(15,3,2),
(15,4,2),
(16,2,2),
(16,3,2),
(16,4,2),
(17,1,2),
(17,2,2),
(17,3,2),
(17,4,2),
(18,1,2),
(1,1,3),
(2,1,3),
(3,1,3),
(3,2,12),
(6,1,12),
(7,1,12),
(7,2,12);

/*Table structure for table `shifts` */

DROP TABLE IF EXISTS `shifts`;

CREATE TABLE `shifts` (
  `ShiftID` int NOT NULL AUTO_INCREMENT,
  `StrongIntensity` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ShiftID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `shifts` */

insert  into `shifts`(`ShiftID`,`StrongIntensity`) values 
(1,1),
(2,0),
(3,0);

/*Table structure for table `specialneedsshifts` */

DROP TABLE IF EXISTS `specialneedsshifts`;

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

/*Data for the table `specialneedsshifts` */

insert  into `specialneedsshifts`(`ScheduleID`,`Day`,`ShiftID`,`NumberOfNurses`) values 
(94,16,2,4),
(94,16,3,4);

/*Table structure for table `sysdiagrams` */

DROP TABLE IF EXISTS `sysdiagrams`;

CREATE TABLE `sysdiagrams` (
  `name` varchar(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `principal_id` int NOT NULL,
  `diagram_id` int NOT NULL,
  `version` int DEFAULT NULL,
  `definition` longblob,
  PRIMARY KEY (`diagram_id`),
  UNIQUE KEY `UK_principal_name` (`principal_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `sysdiagrams` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
