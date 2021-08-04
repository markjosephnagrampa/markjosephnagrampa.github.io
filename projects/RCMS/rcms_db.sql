-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 19, 2021 at 02:31 AM
-- Server version: 5.7.31
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rcms_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
CREATE TABLE IF NOT EXISTS `branches` (
  `BranchID` int(11) NOT NULL AUTO_INCREMENT,
  `BranchAddress` varchar(1000) COLLATE utf8_bin NOT NULL,
  `BranchContactNo` varchar(1000) COLLATE utf8_bin NOT NULL,
  `ManagerID` int(11) NOT NULL COMMENT 'Branch Manager''s ID',
  `BranchIsOpen` tinyint(1) NOT NULL,
  PRIMARY KEY (`BranchID`),
  KEY `ManagerID` (`ManagerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
CREATE TABLE IF NOT EXISTS `expenses` (
  `ExpenseID` int(11) NOT NULL AUTO_INCREMENT,
  `ExpenseName` varchar(1000) COLLATE utf8_bin NOT NULL,
  `ExpenseDateIncurred` date NOT NULL,
  `ExpenseIsDeleted` tinyint(1) NOT NULL,
  `BranchID` int(11) NOT NULL,
  `ExpenseAmount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ExpenseID`),
  KEY `BranchID` (`BranchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `itemavailability`
--

DROP TABLE IF EXISTS `itemavailability`;
CREATE TABLE IF NOT EXISTS `itemavailability` (
  `ItemAvailabilityID` int(11) NOT NULL AUTO_INCREMENT,
  `ItemID` int(11) NOT NULL,
  `BranchID` int(11) NOT NULL,
  `ItemIsAvailable` tinyint(1) NOT NULL,
  PRIMARY KEY (`ItemAvailabilityID`),
  KEY `ItemID` (`ItemID`),
  KEY `BranchID` (`BranchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `ItemID` int(11) NOT NULL AUTO_INCREMENT,
  `ItemName` varchar(1000) COLLATE utf8_bin NOT NULL,
  `ItemPrice` decimal(10,2) NOT NULL,
  `ItemIsDeleted` tinyint(1) NOT NULL,
  `ItemImageLocation` varchar(2048) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
CREATE TABLE IF NOT EXISTS `orderitems` (
  `OrderItemID` int(11) NOT NULL AUTO_INCREMENT,
  `ItemID` int(11) NOT NULL,
  `OrderItemQty` int(11) NOT NULL,
  `OrderItemSubtotal` decimal(10,2) NOT NULL,
  `OrderID` int(11) NOT NULL,
  `OrderItemIsDeleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`OrderItemID`),
  KEY `ItemID` (`ItemID`),
  KEY `OrderID` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `OrderID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderAddressee` varchar(1000) COLLATE utf8_bin NOT NULL,
  `WaiterID` int(11) NOT NULL,
  `OrderTotal` decimal(10,2) NOT NULL,
  `OrderDateCreated` datetime NOT NULL,
  `BranchID` int(11) NOT NULL,
  `OrderIsDeleted` tinyint(1) NOT NULL,
  `OrderIsDineIn` tinyint(1) NOT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `WaiterID` (`WaiterID`),
  KEY `BranchID` (`BranchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `tableorderitems`
--

DROP TABLE IF EXISTS `tableorderitems`;
CREATE TABLE IF NOT EXISTS `tableorderitems` (
  `TableOrderItemID` int(11) NOT NULL AUTO_INCREMENT,
  `TableID` int(11) DEFAULT NULL,
  `OrderItemID` int(11) NOT NULL,
  `RemainingQty` int(11) NOT NULL,
  `OrderID` int(11) DEFAULT NULL,
  `TableOrderItemIsDeleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`TableOrderItemID`),
  KEY `TableID` (`TableID`),
  KEY `OrderItemID` (`OrderItemID`),
  KEY `OrderID` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
CREATE TABLE IF NOT EXISTS `tables` (
  `TableID` int(11) NOT NULL AUTO_INCREMENT,
  `TableSeatingCapacity` int(11) NOT NULL,
  `TableIsOccupied` tinyint(1) NOT NULL COMMENT '0 - Vacant\r\n1 - Occupied',
  `TableIsDeleted` tinyint(1) NOT NULL COMMENT '0 - Not Deleted\r\n1 - Deleted',
  `BranchID` int(11) NOT NULL,
  `TableAddressee` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`TableID`),
  KEY `BranchID` (`BranchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(1000) COLLATE utf8_bin NOT NULL,
  `UserEmail` varchar(1000) COLLATE utf8_bin NOT NULL,
  `UserPassword` varchar(1000) COLLATE utf8_bin NOT NULL,
  `UserCellphone` varchar(1000) COLLATE utf8_bin NOT NULL,
  `UserImageLocation` varchar(2048) COLLATE utf8_bin DEFAULT NULL,
  `UserIsActive` tinyint(1) NOT NULL,
  `BranchID` int(11) DEFAULT NULL,
  `UserType` bit(1) NOT NULL COMMENT '1 - Owner\r\n2 - BranchManager\r\n3 - Waiter',
  PRIMARY KEY (`UserID`),
  KEY `BranchID` (`BranchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `branches`
--
ALTER TABLE `branches`
  ADD CONSTRAINT `branches_ibfk_1` FOREIGN KEY (`ManagerID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`BranchID`) REFERENCES `branches` (`BranchID`);

--
-- Constraints for table `itemavailability`
--
ALTER TABLE `itemavailability`
  ADD CONSTRAINT `itemavailability_ibfk_1` FOREIGN KEY (`BranchID`) REFERENCES `branches` (`BranchID`),
  ADD CONSTRAINT `itemavailability_ibfk_2` FOREIGN KEY (`ItemID`) REFERENCES `items` (`ItemID`);

--
-- Constraints for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`ItemID`) REFERENCES `items` (`ItemID`),
  ADD CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`WaiterID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`BranchID`) REFERENCES `branches` (`BranchID`);

--
-- Constraints for table `tableorderitems`
--
ALTER TABLE `tableorderitems`
  ADD CONSTRAINT `tableorderitems_ibfk_1` FOREIGN KEY (`TableID`) REFERENCES `tables` (`TableID`),
  ADD CONSTRAINT `tableorderitems_ibfk_2` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
  ADD CONSTRAINT `tableorderitems_ibfk_3` FOREIGN KEY (`OrderItemID`) REFERENCES `orderitems` (`OrderItemID`);

--
-- Constraints for table `tables`
--
ALTER TABLE `tables`
  ADD CONSTRAINT `tables_ibfk_1` FOREIGN KEY (`BranchID`) REFERENCES `branches` (`BranchID`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`BranchID`) REFERENCES `branches` (`BranchID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
