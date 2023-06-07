-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 07 juin 2023 à 15:43
-- Version du serveur : 10.4.27-MariaDB
-- Version de PHP : 8.2.0

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

CREATE TABLE `instruments` (
  `id` int(11) NOT NULL,
  `instrument` varchar(127) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `prix` int(11) DEFAULT NULL,
  `marques_id` int(11) DEFAULT NULL,
  `types_id` int(11) DEFAULT NULL,
  `date_modif` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
DELIMITER $$
CREATE TRIGGER `trigger_suppression_instrument` AFTER DELETE ON `instruments` FOR EACH ROW BEGIN
    INSERT INTO suprresion_instrument (instruments_id, instrument, description, stock, prix, marques_id, types_id)
    VALUES (OLD.id, OLD.instrument, OLD.description, OLD.stock, OLD.prix, OLD.marques_id, OLD.types_id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `liste_instru`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `liste_instru` (
`id` int(11)
,`instrument` varchar(127)
,`description` mediumtext
,`marques_id` int(11)
,`types_id` int(11)
,`marque` varchar(63)
,`type` varchar(63)
);

-- --------------------------------------------------------

--
-- Structure de la table `marques`
--

CREATE TABLE `marques` (
  `id` int(11) NOT NULL,
  `marque` varchar(63) NOT NULL,
  `date_modif` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `suprresion_instrument` (
  `id` int(11) NOT NULL,
  `instruments_id` int(11) NOT NULL,
  `instrument` varchar(127) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `prix` int(11) DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `marques_id` int(11) NOT NULL,
  `types_id` int(11) NOT NULL,
  `date_suppression` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `suprresion_instrument`
--

INSERT INTO `suprresion_instrument` (`id`, `instruments_id`, `instrument`, `description`, `prix`, `stock`, `marques_id`, `types_id`, `date_suppression`) VALUES
(3, 21, 'essai', 'xqfef', 10, 10, 2, 2, '2023-06-04 12:25:20');

-- --------------------------------------------------------

--
-- Structure de la table `types`
--

CREATE TABLE `types` (
  `id` int(11) NOT NULL,
  `type` varchar(63) NOT NULL,
  `date_modif` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Structure de la vue `liste_instru`
--
DROP TABLE IF EXISTS `liste_instru`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `liste_instru`  AS SELECT `id` AS `id`, `instrument` AS `instrument`, `description` AS `description`, `marques_id` AS `marques_id`, `types_id` AS `types_id`, `marques`.`marque` AS `marque`, `types`.`type` AS `type` FROM ((`instruments` left join `marques` on(`marques`.`id` = `marques_id`)) left join `types` on(`types`.`id` = `types_id`))  ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `instruments`
--
ALTER TABLE `instruments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `instrument` (`instrument`),
  ADD KEY `marques_id` (`marques_id`),
  ADD KEY `types_id` (`types_id`);

--
-- Index pour la table `marques`
--
ALTER TABLE `marques`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `marque` (`marque`);

--
-- Index pour la table `suprresion_instrument`
--
ALTER TABLE `suprresion_instrument`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `types`
--
ALTER TABLE `types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `type` (`type`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `instruments`
--
ALTER TABLE `instruments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `marques`
--
ALTER TABLE `marques`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `suprresion_instrument`
--
ALTER TABLE `suprresion_instrument`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `types`
--
ALTER TABLE `types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
