-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 23, 2021 at 05:03 AM
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
-- Database: `bsp_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_thread_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reply_to_id` int(11) DEFAULT NULL,
  `message` varchar(2000) COLLATE utf8_bin NOT NULL,
  `datetime_created` datetime NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `item_thread_id` (`item_thread_id`),
  KEY `user_id` (`user_id`),
  KEY `reply_to_id` (`reply_to_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
CREATE TABLE IF NOT EXISTS `companies` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) COLLATE utf8_bin NOT NULL,
  `email` varchar(1000) COLLATE utf8_bin NOT NULL,
  `address` varchar(1000) COLLATE utf8_bin NOT NULL,
  `contact_no` varchar(1000) COLLATE utf8_bin NOT NULL,
  `image_location` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`company_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

DROP TABLE IF EXISTS `complaints`;
CREATE TABLE IF NOT EXISTS `complaints` (
  `complaint_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` varchar(2000) COLLATE utf8_bin NOT NULL,
  `date_created` date NOT NULL,
  `is_sent_by_buyer` tinyint(1) NOT NULL,
  `image_location` varchar(2000) COLLATE utf8_bin NOT NULL,
  `complaint_type` enum('Failure to pay','Foul/Obscene messages or comments','Spamming','Promoting content of competitors','Failure to deliver purchased items','Damaged item','Fake company info','Other') COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`complaint_id`),
  KEY `company_id` (`company_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `item_threads`
--

DROP TABLE IF EXISTS `item_threads`;
CREATE TABLE IF NOT EXISTS `item_threads` (
  `item_thread_id` int(11) NOT NULL AUTO_INCREMENT,
  `book_title` varchar(1000) COLLATE utf8_bin NOT NULL,
  `binding_type` enum('Case Binding (Hardcover)','Perfect Binding (Softcover)','Saddle Stitch Binding','Spiral Binding','Other') COLLATE utf8_bin NOT NULL,
  `author` varchar(1000) COLLATE utf8_bin NOT NULL,
  `genre` varchar(1000) COLLATE utf8_bin NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_location` varchar(2000) COLLATE utf8_bin NOT NULL,
  `company_id` int(11) NOT NULL,
  `date_created` date NOT NULL,
  `is_closed` tinyint(1) NOT NULL,
  PRIMARY KEY (`item_thread_id`),
  KEY `company_id` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `message` varchar(2000) COLLATE utf8_bin NOT NULL,
  `datetime_created` datetime NOT NULL,
  `is_sent_by_buyer` tinyint(1) NOT NULL,
  `is_admin_announcement` tinyint(1) NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `company_id` (`company_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(1000) COLLATE utf8_bin NOT NULL,
  `name` varchar(1000) COLLATE utf8_bin NOT NULL,
  `user_type` enum('admin','seller','buyer') COLLATE utf8_bin NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `image_location` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `contact_no` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`item_thread_id`) REFERENCES `item_threads` (`item_thread_id`),
  ADD CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`reply_to_id`) REFERENCES `comments` (`comment_id`);

--
-- Constraints for table `companies`
--
ALTER TABLE `companies`
  ADD CONSTRAINT `companies_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `complaints_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `item_threads`
--
ALTER TABLE `item_threads`
  ADD CONSTRAINT `item_threads_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
