-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : dim. 04 juin 2023 à 17:51
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `instruments`
--

-- --------------------------------------------------------

--
-- Structure de la table `instruments`
--

DROP TABLE IF EXISTS `instruments`;
CREATE TABLE IF NOT EXISTS `instruments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `instrument` varchar(127) COLLATE utf8mb4_general_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_general_ci,
  `stock` int NOT NULL DEFAULT '0',
  `prix` int DEFAULT NULL,
  `marques_id` int DEFAULT NULL,
  `types_id` int DEFAULT NULL,
  `date_modif` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `instrument` (`instrument`),
  KEY `marques_id` (`marques_id`),
  KEY `types_id` (`types_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `instruments`
--

INSERT INTO `instruments` (`id`, `instrument`, `description`, `stock`, `prix`, `marques_id`, `types_id`, `date_modif`) VALUES
(14, 'GK Pro Negra', NULL, 2, 1666, 1, 3, '2023-06-04 12:12:43'),
(15, 'F7 Flamenco Iberia', NULL, 0, 539, 1, 3, '2023-06-04 12:12:43'),
(16, 'AC110 Open Pore', NULL, 1, 88, 2, 4, '2023-06-04 12:12:43'),
(17, 'KX100 METALLIC ASH', NULL, 2, 365, 2, 5, '2023-06-04 12:18:33'),
(18, 'GB34JJ SUNBURST', NULL, 2, 278, 2, 2, '2023-06-04 12:18:33'),
(19, '514CE 2018 GRAND AUDITORIUM', NULL, 1, 3598, 3, 1, '2023-06-04 12:18:33');

--
-- Déclencheurs `instruments`
--
DROP TRIGGER IF EXISTS `trigger_suppression_instrument`;
DELIMITER $$
CREATE TRIGGER `trigger_suppression_instrument` AFTER DELETE ON `instruments` FOR EACH ROW BEGIN
    INSERT INTO suprresion_instrument (instruments_id, instrument, description, stock, prix, marques_id, types_id)
    VALUES (OLD.id, OLD.instrument, OLD.description, OLD.stock, OLD.prix, OLD.marques_id, OLD.types_id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `marques`
--

DROP TABLE IF EXISTS `marques`;
CREATE TABLE IF NOT EXISTS `marques` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marque` varchar(63) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modif` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `marque` (`marque`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `marques`
--

INSERT INTO `marques` (`id`, `marque`, `date_modif`) VALUES
(1, 'Cordoba', '2023-06-04 11:59:17'),
(2, 'Cort', '2023-06-04 11:59:17'),
(3, 'Taylor', '2023-06-04 11:59:17'),
(4, 'Esteve', '2023-06-04 17:15:06'),
(6, 'une marque au hazad', '2023-06-04 18:42:51');

-- --------------------------------------------------------

--
-- Structure de la table `suprresion_instrument`
--

DROP TABLE IF EXISTS `suprresion_instrument`;
CREATE TABLE IF NOT EXISTS `suprresion_instrument` (
  `id` int NOT NULL AUTO_INCREMENT,
  `instruments_id` int NOT NULL,
  `instrument` varchar(127) COLLATE utf8mb4_general_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_general_ci,
  `prix` int DEFAULT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `marques_id` int NOT NULL,
  `types_id` int NOT NULL,
  `date_suppression` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `suprresion_instrument`
--

INSERT INTO `suprresion_instrument` (`id`, `instruments_id`, `instrument`, `description`, `prix`, `stock`, `marques_id`, `types_id`, `date_suppression`) VALUES
(3, 21, 'essai', 'xqfef', 10, 10, 2, 2, '2023-06-04 12:25:20');

-- --------------------------------------------------------

--
-- Structure de la table `types`
--

DROP TABLE IF EXISTS `types`;
CREATE TABLE IF NOT EXISTS `types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(63) COLLATE utf8mb4_general_ci NOT NULL,
  `date_modif` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `types`
--

INSERT INTO `types` (`id`, `type`, `date_modif`) VALUES
(1, 'Folk', '2023-06-04 12:00:56'),
(2, 'Basse', '2023-06-04 12:00:56'),
(3, 'Flamenco', '2023-06-04 12:00:56'),
(4, 'Classique', '2023-06-04 12:00:56'),
(5, 'Electrique', '2023-06-04 12:00:56');

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vue_instruments`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vue_instruments`;
CREATE TABLE IF NOT EXISTS `vue_instruments` (
`date_modif` datetime
,`description` mediumtext
,`instrument` varchar(127)
,`instruments_id` int
,`marque` varchar(63)
,`marques_id` int
,`prix` int
,`stock` int
,`type` varchar(63)
,`types_id` int
);

-- --------------------------------------------------------

--
-- Structure de la vue `vue_instruments`
--
DROP TABLE IF EXISTS `vue_instruments`;

DROP VIEW IF EXISTS `vue_instruments`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vue_instruments`  AS SELECT `id` AS `instruments_id`, `instrument` AS `instrument`, `description` AS `description`, `stock` AS `stock`, `prix` AS `prix`, `date_modif` AS `date_modif`, `marques_id` AS `marques_id`, `marques`.`marque` AS `marque`, `types_id` AS `types_id`, `types`.`type` AS `type` FROM ((`instruments` left join `marques` on((`marques`.`id` = `marques_id`))) left join `types` on((`types`.`id` = `types_id`)))  ;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `instruments`
--
ALTER TABLE `instruments`
  ADD CONSTRAINT `instruments_ibfk_1` FOREIGN KEY (`marques_id`) REFERENCES `marques` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `instruments_ibfk_2` FOREIGN KEY (`types_id`) REFERENCES `types` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
