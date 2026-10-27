-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 27, 2026 at 07:54 AM
-- Server version: 8.4.7
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rfid_fare_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `full_name`, `created_at`) VALUES
(1, 'admin', '$2y$10$fVctwfCikWOVb.877PFRt.ZVmS2SUrb//nzw.KDlfFZHmw.ZpslM.', 'System Administrator', '2026-06-13 05:33:04');

-- --------------------------------------------------------

--
-- Table structure for table `balance_loads`
--

DROP TABLE IF EXISTS `balance_loads`;
CREATE TABLE IF NOT EXISTS `balance_loads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `passenger_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `reference_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loaded_by` int DEFAULT NULL,
  `load_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `loaded_by_role` enum('management','collector') COLLATE utf8mb4_unicode_ci DEFAULT 'collector',
  PRIMARY KEY (`id`),
  KEY `passenger_id` (`passenger_id`),
  KEY `loaded_by` (`loaded_by`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `balance_loads`
--

INSERT INTO `balance_loads` (`id`, `passenger_id`, `amount`, `reference_no`, `loaded_by`, `load_date`, `loaded_by_role`) VALUES
(1, 4, 1000.00, 'LOAD-20261014024437841', 1, '2026-10-14 02:44:37', 'collector');

-- --------------------------------------------------------

--
-- Table structure for table `balance_requests`
--

DROP TABLE IF EXISTS `balance_requests`;
CREATE TABLE IF NOT EXISTS `balance_requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `passenger_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_no` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_paid` date NOT NULL,
  `receipt_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `request_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `approved_by` int DEFAULT NULL,
  `approved_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_no` (`reference_no`),
  KEY `approved_by` (`approved_by`),
  KEY `idx_balance_requests_status` (`status`),
  KEY `idx_balance_requests_passenger` (`passenger_id`),
  KEY `idx_balance_requests_date` (`request_date`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `balance_requests`
--

INSERT INTO `balance_requests` (`id`, `passenger_id`, `amount`, `payment_method`, `reference_no`, `sender_name`, `date_paid`, `receipt_image`, `status`, `rejection_reason`, `request_date`, `approved_by`, `approved_date`) VALUES
(1, 1, 1000.00, 'GCash', '56456455', 'DAN CARTER YU', '2026-10-14', 'assets/uploads/requests/receipt_20261014_032557.png', 'approved', NULL, '2026-10-14 03:25:57', 1, '2026-10-14 03:26:10');

-- --------------------------------------------------------

--
-- Table structure for table `collectors`
--

DROP TABLE IF EXISTS `collectors`;
CREATE TABLE IF NOT EXISTS `collectors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `employee_number` (`employee_number`),
  KEY `created_by` (`created_by`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `collectors`
--

INSERT INTO `collectors` (`id`, `employee_number`, `first_name`, `middle_name`, `last_name`, `password`, `full_name`, `contact`, `status`, `created_by`, `created_at`) VALUES
(1, 'VGL001', 'DAN CARTER', '', 'YU', '$2y$10$zgcOjbn1svFeB3AePShvA.XXtDsr4fu/sqHrxuHrhiEzhiIIAnV3S', '', '', 'inactive', 1, '2026-10-12 04:40:33'),
(2, 'VGL002', 'BELLA', '', 'RIVERO', '$2y$10$XIu/CIxJuGUizaEA5QL6fuZuIyIgDRGWXe22o3886aPuRcvOoxZTS', '', '', 'active', 1, '2026-10-14 03:00:46'),
(3, 'VGL003', 'GRESA', '', 'NAVIDAD', '$2y$10$37ToAluEbuLCYAvgDxBjZ.jgLgBtQp6ayeGdaoyqha9.Vyvk2OQWW', '', '', 'active', 1, '2026-10-14 03:01:00'),
(4, 'VGL004', 'RITCHEL', '', 'EMFIMO', '$2y$10$khiEi5jFIPPJxnONi.O4pOCJ87ZNN43ydPsazVraOHu8MuUynPQ2.', '', '', 'active', 1, '2026-10-14 03:01:16');

-- --------------------------------------------------------

--
-- Table structure for table `collector_assignments`
--

DROP TABLE IF EXISTS `collector_assignments`;
CREATE TABLE IF NOT EXISTS `collector_assignments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `collector_id` int NOT NULL,
  `destination_id` int NOT NULL,
  `assigned_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_destination` (`destination_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `collector_assignments`
--

INSERT INTO `collector_assignments` (`id`, `collector_id`, `destination_id`, `assigned_at`) VALUES
(1, 1, 1, '2026-10-12 04:46:07'),
(2, 2, 4, '2026-10-24 07:02:42'),
(3, 3, 2, '2026-10-24 07:03:06');

-- --------------------------------------------------------

--
-- Table structure for table `destinations`
--

DROP TABLE IF EXISTS `destinations`;
CREATE TABLE IF NOT EXISTS `destinations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `origin` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `destination` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vessel_id` int DEFAULT NULL,
  `aircon_fare` decimal(10,2) DEFAULT '0.00',
  `non_aircon_fare` decimal(10,2) DEFAULT '0.00',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_route` (`origin`,`destination`,`vessel_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `destinations`
--

INSERT INTO `destinations` (`id`, `origin`, `destination`, `vessel_id`, `aircon_fare`, `non_aircon_fare`, `is_active`, `created_at`) VALUES
(1, 'SC', 'DI', 1, 0.00, 450.00, 1, '2026-10-12 04:45:57'),
(2, 'SURIGAO CITY', 'DAPA, SIARGAO', 4, 0.00, 480.00, 1, '2026-10-14 03:12:05'),
(3, 'DAPA, SIARGAO', 'SURIGAO CITY', 2, 0.00, 480.00, 1, '2026-10-14 03:14:32'),
(4, 'SURIGAO CITY', 'SAN JOSE, DINAGAT ISLANDS', 3, 0.00, 240.00, 1, '2026-10-14 03:22:20');

-- --------------------------------------------------------

--
-- Table structure for table `discount_types`
--

DROP TABLE IF EXISTS `discount_types`;
CREATE TABLE IF NOT EXISTS `discount_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `percentage` decimal(5,2) DEFAULT '0.00',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `discount_types`
--

INSERT INTO `discount_types` (`id`, `name`, `percentage`, `is_active`, `created_at`) VALUES
(11, 'infant', 100.00, 1, '2026-09-01 12:27:13'),
(12, 'child', 50.00, 1, '2026-09-01 12:27:13'),
(13, 'student', 20.00, 1, '2026-09-01 12:27:13'),
(14, 'senior', 20.00, 1, '2026-09-01 12:27:13'),
(15, 'pwd', 20.00, 1, '2026-09-01 12:27:13'),
(16, 'regular', 0.00, 1, '2026-09-01 12:27:13');

-- --------------------------------------------------------

--
-- Table structure for table `group_passengers`
--

DROP TABLE IF EXISTS `group_passengers`;
CREATE TABLE IF NOT EXISTS `group_passengers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` int NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `sex` enum('M','F') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `passenger_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'regular',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `transaction_id` (`transaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loyalty_settings`
--

DROP TABLE IF EXISTS `loyalty_settings`;
CREATE TABLE IF NOT EXISTS `loyalty_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `points_per_peso` decimal(5,2) DEFAULT '0.10',
  `points_per_travel` int DEFAULT '1',
  `min_fare_for_points` decimal(10,2) DEFAULT '10.00',
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `updated_by` (`updated_by`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loyalty_settings`
--

INSERT INTO `loyalty_settings` (`id`, `points_per_peso`, `points_per_travel`, `min_fare_for_points`, `updated_by`, `updated_at`, `is_enabled`) VALUES
(1, 0.10, 1, 10.00, 1, '2026-09-01 12:32:53', 1);

-- --------------------------------------------------------

--
-- Table structure for table `manifests`
--

DROP TABLE IF EXISTS `manifests`;
CREATE TABLE IF NOT EXISTS `manifests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `trip_id` int NOT NULL,
  `passenger_id` int NOT NULL,
  `passenger_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int DEFAULT NULL,
  `sex` enum('M','F') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `passenger_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'regular',
  `section` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'aircon',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `transaction_id` int DEFAULT NULL,
  `fare_paid` decimal(10,2) DEFAULT '0.00',
  `discount_amount` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `trip_id` (`trip_id`),
  KEY `passenger_id` (`passenger_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `manifests`
--

INSERT INTO `manifests` (`id`, `trip_id`, `passenger_id`, `passenger_name`, `age`, `sex`, `address`, `passenger_type`, `section`, `created_at`, `transaction_id`, `fare_paid`, `discount_amount`) VALUES
(1, 4, 4, 'GEFERSON SAMSON', 21, 'M', 'SURIGAO CITY', 'regular', 'non_aircon', '2026-10-14 02:44:45', 1, 450.00, 0.00),
(2, 13, 4, 'GEFERSON SAMSON', 21, 'M', 'SURIGAO CITY', 'student', 'non_aircon', '2026-10-24 07:10:31', 2, 384.00, 96.00),
(3, 13, 1, 'DAN CARTER YU', 22, 'M', 'SURIGAO CITY', 'student', 'non_aircon', '2026-10-24 07:10:41', 3, 384.00, 96.00),
(4, 14, 4, 'GEFERSON SAMSON', 21, 'M', 'SURIGAO CITY', 'regular', 'non_aircon', '2026-10-24 07:12:44', 4, 480.00, 0.00),
(5, 14, 0, 'INFANT NAME', 2, 'F', 'SURIGAO DEL SUR', 'Infant (100.00% off)', 'non_aircon', '2026-10-24 07:12:44', 4, 0.00, 480.00);

-- --------------------------------------------------------

--
-- Table structure for table `passengers`
--

DROP TABLE IF EXISTS `passengers`;
CREATE TABLE IF NOT EXISTS `passengers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rfid_uid` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `sex` enum('M','F') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `balance` decimal(10,2) DEFAULT '0.00',
  `loyalty_points` int DEFAULT '0',
  `discount_type_id` int DEFAULT '4',
  `status` enum('active','lost','blocked') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by_role` enum('management','collector') COLLATE utf8mb4_unicode_ci DEFAULT 'management',
  PRIMARY KEY (`id`),
  UNIQUE KEY `rfid_uid` (`rfid_uid`),
  KEY `discount_type_id` (`discount_type_id`),
  KEY `created_by` (`created_by`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `passengers`
--

INSERT INTO `passengers` (`id`, `rfid_uid`, `first_name`, `middle_name`, `last_name`, `password`, `full_name`, `email`, `contact`, `date_of_birth`, `sex`, `address`, `balance`, `loyalty_points`, `discount_type_id`, `status`, `created_by`, `created_at`, `created_by_role`) VALUES
(1, '3212471044', 'DAN CARTER', '', 'YU', '$2y$10$ILsLaeMiZQKlioGhlR1vNuF7AyC6cEmDpYmTMF5yOOsSQfdq7Pn5u', '', '', '', '2004-02-12', 'M', 'SURIGAO CITY', 616.00, 1, 4, 'active', 'admin', '2026-10-12 01:33:55', 'management'),
(2, '3211421460', 'GRACE', '', 'ROMERO', '$2y$10$/y8qT46wM5L7C0uybc3KIOi47tWkvhlRc3wOmiP0KkFJ5asPN1rOC', '', '', '', '2005-06-07', 'F', 'SURIGAO CITY', 0.00, 0, 4, 'active', 'admin', '2026-10-12 01:34:32', 'management'),
(3, '3484554904', 'JOHN ANGEL', '', 'YTAC', '$2y$10$DDUGyfP4h2Bmi9ujI217z.Ve6oDLqmWfm5zb0UFDs2NtRLdoIysfq', '', '', '', '2003-01-23', 'M', 'DINAGAT ISLAND', 0.00, 0, 4, 'active', 'admin', '2026-10-12 01:35:09', 'management'),
(4, '3213920020', 'GEFERSON', '', 'SAMSON', '$2y$10$hLihpY.gUhQz1Jm7QErmZejpp2tQ9LFgVvpPMACR34Vcf7cXPEMoK', '', '', '', '2004-12-31', 'M', 'SURIGAO CITY', 136.00, 3, 4, 'active', 'admin', '2026-10-12 01:35:43', 'management');

-- --------------------------------------------------------

--
-- Table structure for table `redemptions`
--

DROP TABLE IF EXISTS `redemptions`;
CREATE TABLE IF NOT EXISTS `redemptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `passenger_id` int NOT NULL,
  `balance_amount` decimal(10,2) NOT NULL,
  `points_used` int NOT NULL,
  `status` enum('completed','pending','failed') COLLATE utf8mb4_unicode_ci DEFAULT 'completed',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `passenger_id` (`passenger_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `redemption_settings`
--

DROP TABLE IF EXISTS `redemption_settings`;
CREATE TABLE IF NOT EXISTS `redemption_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `balance_amount` decimal(10,2) NOT NULL,
  `points_required` int NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `redemption_settings`
--

INSERT INTO `redemption_settings` (`id`, `balance_amount`, `points_required`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 20.00, 25, 1, '2026-09-01 12:44:42', '2026-09-01 12:44:42'),
(2, 50.00, 60, 1, '2026-09-01 12:44:42', '2026-09-01 12:44:42'),
(3, 100.00, 120, 1, '2026-09-01 12:44:42', '2026-09-01 12:44:42'),
(4, 200.00, 240, 1, '2026-09-01 12:44:42', '2026-09-01 12:44:42');

-- --------------------------------------------------------

--
-- Table structure for table `refunds`
--

DROP TABLE IF EXISTS `refunds`;
CREATE TABLE IF NOT EXISTS `refunds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` int NOT NULL,
  `passenger_id` int NOT NULL,
  `trip_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `points_deducted` int NOT NULL DEFAULT '0',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refunded_by` int DEFAULT NULL,
  `refunded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `passenger_id` (`passenger_id`),
  KEY `trip_id` (`trip_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refunds`
--

INSERT INTO `refunds` (`id`, `transaction_id`, `passenger_id`, `trip_id`, `amount`, `points_deducted`, `reason`, `refunded_by`, `refunded_at`) VALUES
(1, 1, 4, 4, 450.00, 1, 'Trip cancelled', 1, '2026-10-14 02:45:09');

-- --------------------------------------------------------

--
-- Table structure for table `rfid_replacements`
--

DROP TABLE IF EXISTS `rfid_replacements`;
CREATE TABLE IF NOT EXISTS `rfid_replacements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `passenger_id` int NOT NULL,
  `old_rfid_uid` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `new_rfid_uid` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'lost',
  `replaced_by` int DEFAULT NULL,
  `replacement_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `passenger_id` (`passenger_id`),
  KEY `replaced_by` (`replaced_by`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `receipt_no` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `passenger_id` int NOT NULL,
  `collector_id` int NOT NULL,
  `destination_id` int NOT NULL,
  `trip_id` int DEFAULT NULL,
  `base_fare` decimal(10,2) NOT NULL,
  `discount_percentage` decimal(5,2) DEFAULT '0.00',
  `discount_amount` decimal(10,2) DEFAULT '0.00',
  `net_payment` decimal(10,2) NOT NULL,
  `balance_before` decimal(10,2) NOT NULL,
  `balance_after` decimal(10,2) NOT NULL,
  `loyalty_points_earned` int DEFAULT '0',
  `is_group` enum('0','1') COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `passenger_count` int DEFAULT '1',
  `card_holder_boarding` enum('0','1') COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `transaction_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_refunded` tinyint(1) DEFAULT '0',
  `refunded_at` timestamp NULL DEFAULT NULL,
  `points_deducted` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `receipt_no` (`receipt_no`),
  KEY `passenger_id` (`passenger_id`),
  KEY `collector_id` (`collector_id`),
  KEY `destination_id` (`destination_id`),
  KEY `trip_id` (`trip_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `receipt_no`, `passenger_id`, `collector_id`, `destination_id`, `trip_id`, `base_fare`, `discount_percentage`, `discount_amount`, `net_payment`, `balance_before`, `balance_after`, `loyalty_points_earned`, `is_group`, `passenger_count`, `card_holder_boarding`, `transaction_date`, `is_refunded`, `refunded_at`, `points_deducted`) VALUES
(1, 'RC-20261014024445356', 4, 1, 1, 4, 450.00, 0.00, 0.00, 450.00, 1000.00, 550.00, 1, '0', 1, '1', '2026-10-14 02:44:45', 1, '2026-10-14 02:45:09', 1),
(2, 'RC-20261024071031611', 4, 3, 2, 13, 480.00, 20.00, 96.00, 384.00, 1000.00, 616.00, 1, '0', 1, '1', '2026-10-24 07:10:31', 0, NULL, 0),
(3, 'RC-20261024071041199', 1, 3, 2, 13, 480.00, 20.00, 96.00, 384.00, 1000.00, 616.00, 1, '0', 1, '1', '2026-10-24 07:10:41', 0, NULL, 0),
(4, 'GRP-20261024071244452', 4, 3, 2, 14, 0.00, 0.00, 0.00, 480.00, 616.00, 136.00, 2, '1', 2, '1', '2026-10-24 07:12:44', 0, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `trips`
--

DROP TABLE IF EXISTS `trips`;
CREATE TABLE IF NOT EXISTS `trips` (
  `id` int NOT NULL AUTO_INCREMENT,
  `schedule_id` int NOT NULL,
  `trip_date` date NOT NULL,
  `status` enum('upcoming','accepting','sailed','arrived','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'upcoming',
  `aircon_capacity` int DEFAULT '0',
  `non_aircon_capacity` int DEFAULT '0',
  `aircon_count` int DEFAULT '0',
  `non_aircon_count` int DEFAULT '0',
  `actual_departure` datetime DEFAULT NULL,
  `actual_arrival` datetime DEFAULT NULL,
  `passenger_count` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `schedule_id` (`schedule_id`,`trip_date`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trips`
--

INSERT INTO `trips` (`id`, `schedule_id`, `trip_date`, `status`, `aircon_capacity`, `non_aircon_capacity`, `aircon_count`, `non_aircon_count`, `actual_departure`, `actual_arrival`, `passenger_count`, `created_at`) VALUES
(1, 1, '2026-10-12', 'upcoming', 0, 100, 0, 0, NULL, NULL, 0, '2026-10-12 04:46:10'),
(2, 2, '2026-10-12', 'cancelled', 0, 100, 0, 0, NULL, NULL, 0, '2026-10-12 04:46:10'),
(3, 1, '2026-10-14', 'upcoming', 0, 100, 0, 0, NULL, NULL, 0, '2026-10-14 02:44:14'),
(4, 2, '2026-10-14', 'cancelled', 0, 100, 0, 1, NULL, NULL, 1, '2026-10-14 02:44:14'),
(5, 3, '2026-10-14', 'upcoming', 0, 206, 0, 0, NULL, NULL, 0, '2026-10-14 03:27:02'),
(6, 4, '2026-10-14', 'upcoming', 0, 206, 0, 0, NULL, NULL, 0, '2026-10-14 03:27:02'),
(7, 5, '2026-10-14', 'upcoming', 0, 206, 0, 0, NULL, NULL, 0, '2026-10-14 03:27:02'),
(8, 6, '2026-10-14', 'upcoming', 0, 206, 0, 0, NULL, NULL, 0, '2026-10-14 03:27:02'),
(9, 7, '2026-10-14', 'upcoming', 0, 180, 0, 0, NULL, NULL, 0, '2026-10-14 03:27:02'),
(10, 8, '2026-10-14', 'upcoming', 0, 180, 0, 0, NULL, NULL, 0, '2026-10-14 03:27:02'),
(11, 1, '2026-10-24', 'upcoming', 0, 100, 0, 0, NULL, NULL, 0, '2026-10-24 07:06:38'),
(12, 2, '2026-10-24', 'upcoming', 0, 100, 0, 0, NULL, NULL, 0, '2026-10-24 07:06:38'),
(13, 3, '2026-10-24', 'arrived', 0, 206, 0, 2, '2026-10-24 15:11:24', '2026-10-24 15:11:39', 2, '2026-10-24 07:06:38'),
(14, 4, '2026-10-24', 'arrived', 0, 206, 0, 2, '2026-10-24 15:13:41', '2026-10-24 15:13:45', 2, '2026-10-24 07:06:38'),
(15, 5, '2026-10-24', 'upcoming', 0, 206, 0, 0, NULL, NULL, 0, '2026-10-24 07:06:38'),
(16, 6, '2026-10-24', 'upcoming', 0, 206, 0, 0, NULL, NULL, 0, '2026-10-24 07:06:38'),
(17, 7, '2026-10-24', 'upcoming', 0, 180, 0, 0, NULL, NULL, 0, '2026-10-24 07:06:38'),
(18, 8, '2026-10-24', 'upcoming', 0, 180, 0, 0, NULL, NULL, 0, '2026-10-24 07:06:38'),
(19, 1, '2026-10-26', 'upcoming', 0, 100, 0, 0, NULL, NULL, 0, '2026-10-26 01:53:10'),
(20, 2, '2026-10-26', 'upcoming', 0, 100, 0, 0, NULL, NULL, 0, '2026-10-26 01:53:10'),
(21, 3, '2026-10-26', 'upcoming', 0, 206, 0, 0, NULL, NULL, 0, '2026-10-26 01:53:10'),
(22, 4, '2026-10-26', 'upcoming', 0, 206, 0, 0, NULL, NULL, 0, '2026-10-26 01:53:10'),
(23, 5, '2026-10-26', 'upcoming', 0, 206, 0, 0, NULL, NULL, 0, '2026-10-26 01:53:10'),
(24, 6, '2026-10-26', 'upcoming', 0, 206, 0, 0, NULL, NULL, 0, '2026-10-26 01:53:10'),
(25, 7, '2026-10-26', 'upcoming', 0, 180, 0, 0, NULL, NULL, 0, '2026-10-26 01:53:10'),
(26, 8, '2026-10-26', 'upcoming', 0, 180, 0, 0, NULL, NULL, 0, '2026-10-26 01:53:10');

-- --------------------------------------------------------

--
-- Table structure for table `trip_schedules`
--

DROP TABLE IF EXISTS `trip_schedules`;
CREATE TABLE IF NOT EXISTS `trip_schedules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `destination_id` int NOT NULL,
  `departure_time` time NOT NULL,
  `arrival_time` time NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `destination_id` (`destination_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trip_schedules`
--

INSERT INTO `trip_schedules` (`id`, `destination_id`, `departure_time`, `arrival_time`, `is_active`, `created_at`) VALUES
(1, 1, '13:00:00', '15:00:00', 1, '2026-10-12 04:45:57'),
(2, 1, '06:00:00', '08:00:00', 1, '2026-10-12 04:45:57'),
(3, 2, '09:30:00', '11:00:00', 1, '2026-10-14 03:12:05'),
(4, 2, '15:00:00', '16:30:00', 1, '2026-10-14 03:12:05'),
(5, 3, '06:30:00', '08:00:00', 1, '2026-10-14 03:14:32'),
(6, 3, '12:30:00', '14:00:00', 1, '2026-10-14 03:14:32'),
(7, 4, '06:30:00', '08:00:00', 1, '2026-10-14 03:22:20'),
(8, 4, '12:30:00', '14:00:00', 1, '2026-10-14 03:22:20');

-- --------------------------------------------------------

--
-- Table structure for table `vessels`
--

DROP TABLE IF EXISTS `vessels`;
CREATE TABLE IF NOT EXISTS `vessels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('aircon','non_aircon','both') COLLATE utf8mb4_unicode_ci DEFAULT 'both',
  `aircon_capacity` int DEFAULT '0',
  `non_aircon_capacity` int DEFAULT '0',
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vessels`
--

INSERT INTO `vessels` (`id`, `name`, `type`, `aircon_capacity`, `non_aircon_capacity`, `status`, `created_at`) VALUES
(1, 'VESSEL NAME', 'non_aircon', 0, 100, 'active', '2026-10-12 04:44:23'),
(2, 'VINCE GABRIEL 1', 'non_aircon', 0, 206, 'active', '2026-10-14 02:59:17'),
(3, 'VINCE GABRIEL 2', 'non_aircon', 0, 180, 'active', '2026-10-14 02:59:30'),
(4, 'VINCE GABRIEL 3', 'non_aircon', 0, 206, 'active', '2026-10-14 03:03:18');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
