-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 03, 2017 at 11:40 AM
-- Server version: 5.7.20-0ubuntu0.17.04.1
-- PHP Version: 7.0.22-0ubuntu0.17.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ECFregatte`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `distance_moyenne` (IN `challenge_id` INT(11))  SELECT c.challenge_nom , AVG(r.regatta_distance) AS moyenne
FROM regatta r
INNER JOIN challenge c  ON r.challenge_id = c.challenge_id
WHERE r.challenge_id = challenge_id
GROUP BY c.challenge_nom$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `equipage_voilier` (IN `regate_id` INT(11), IN `bateau_id` INT(11))  NO SQL
BEGIN
SELECT p.personne_nom AS nom_equipier, p.personne_prenom AS prenom_equipier,b.bateau_nom AS voilier, z.personne_nom AS skipper_nom, z.personne_prenom AS skipper_prenom
FROM equipage e
INNER JOIN bateau b ON e.bateau_id =b.bateau_id
INNER JOIN participant par ON e.participant_id = par.participant_id
INNER JOIN personne p ON par.personne_id = p.personne_id
INNER JOIN skipper s ON e.skipper_id = s.skipper_id
INNER JOIN participant part ON s.participant_id = part.participant_id
INNER JOIN personne z ON part.personne_id = z.personne_id
WHERE e.regatta_id = regate_id AND e.bateau_id=bateau_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `intervention_commissaire` (IN `date_debut` DATE, IN `date_fin` DATE, IN `challenge` INT(11))  NO SQL
BEGIN
SELECT p.personne_nom,p.personne_prenom,c.comitee_nom,r.regatta_nom,r.regatta_date
FROM regatta r
INNER JOIN commissaire co ON r.commissaire_id = co.commissaire_id
INNER JOIN comite_regional reg ON co.comitee_id = reg.comitee_id
INNER JOIN personne p ON co.personne_id =p.personne_id
WHERE r.challenge_id= challenge 
AND r.regatta_date> date_debut
AND r.regatta_date<date_fin;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `code_regate` (`challenge_id` INT(11), `date_regate` DATE) RETURNS VARCHAR(20) CHARSET latin1 BEGIN
DECLARE codeChallenge VARCHAR(4);
DECLARE regateCount INT;
SELECT  c.challenge_code
INTO codeChallenge
FROM challenge c
WHERE c.challenge_id = challenge_id;
SELECT COUNT(r.regatta_id)
INTO regateCount
FROM regatta r
WHERE r.challenge_id=challenge_id;

RETURN CONCAT(codeChallenge,'/',MONTH(date_regate),'/',regateCount);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bateau`
--

CREATE TABLE `bateau` (
  `bateau_id` int(11) NOT NULL,
  `bateau_nom` varchar(255) NOT NULL,
  `bateau_voile` int(11) NOT NULL,
  `proprietaire_id` int(11) NOT NULL,
  `classe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bateau`
--

INSERT INTO `bateau` (`bateau_id`, `bateau_nom`, `bateau_voile`, `proprietaire_id`, `classe_id`) VALUES
(1, 'le petit moussaillon', 255, 1, 5),
(2, 'la grosse Bertha', 256, 2, 9);

-- --------------------------------------------------------

--
-- Table structure for table `challenge`
--

CREATE TABLE `challenge` (
  `challenge_id` int(11) NOT NULL,
  `challenge_nom` varchar(255) NOT NULL,
  `challenge_date_debut` date NOT NULL,
  `challenge_date_fin` date NOT NULL,
  `challenge_code` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `challenge`
--

INSERT INTO `challenge` (`challenge_id`, `challenge_nom`, `challenge_date_debut`, `challenge_date_fin`, `challenge_code`) VALUES
(1, 'les régates de la baie de St Brieuc', '2017-11-16', '2017-12-18', 'rbsb'),
(2, 'les régates de la baie de Morlaix', '2016-11-16', '2016-12-16', 'rbmo');

-- --------------------------------------------------------

--
-- Table structure for table `classe`
--

CREATE TABLE `classe` (
  `classe_id` int(11) NOT NULL,
  `classe_name` varchar(50) NOT NULL,
  `classe_coeff` float NOT NULL,
  `serie_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `classe`
--

INSERT INTO `classe` (`classe_id`, `classe_name`, `classe_coeff`, `serie_id`) VALUES
(5, 'Corsaire', 0.3, 1),
(6, 'Surprise', 0.4, 1),
(7, '8 mètres', 0.5, 1),
(8, 'Maraudeur', 0.6, 1),
(9, 'Figaro', 0.7, 1),
(10, 'Flying Fifteen', 0.8, 2),
(11, 'Soling', 0.9, 2),
(12, 'star', 1, 2),
(13, 'Tempest', 1.3, 2),
(14, 'yngling', 1.4, 2),
(15, '5.5', 1.3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `club`
--

CREATE TABLE `club` (
  `club_id` int(11) NOT NULL,
  `club_nom` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `club`
--

INSERT INTO `club` (`club_id`, `club_nom`) VALUES
(1, 'YC Val André'),
(2, 'YC BINC'),
(3, 'YC le legué'),
(4, 'YC st Quay');

-- --------------------------------------------------------

--
-- Table structure for table `code`
--

CREATE TABLE `code` (
  `code_id` int(11) NOT NULL,
  `code_abreviation` varchar(3) NOT NULL,
  `code_description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `code`
--

INSERT INTO `code` (`code_id`, `code_abreviation`, `code_description`) VALUES
(1, 'DNC', 'N’a pas pris le départ (n’est pas venu sur la zone de course)'),
(2, 'DNS', 'N’a pas pris le départ dans les temps'),
(3, 'OCS', 'Départ prématuré sous pavillon P ou I'),
(4, 'ZFP', 'Départ prématuré, pénalité de 20 % (départ sous pavillon Z)'),
(5, 'BFD', 'Départ prématuré sous pavillon noir = disqualifié'),
(6, 'DNF', 'N’a pas fini'),
(7, 'RAF', 'A abandonné après avoir fini (pour les gens fair-play)'),
(8, 'DSQ', 'Disqualification'),
(9, 'DNE', 'Disqualification qui ne peut être retirée (faute grave genre tricherie)'),
(10, 'DGM', 'Disqualification qui ne peut être retirée (faute grave genre tricherie)');

-- --------------------------------------------------------

--
-- Table structure for table `comite_regional`
--

CREATE TABLE `comite_regional` (
  `comitee_id` int(11) NOT NULL,
  `comitee_nom` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comite_regional`
--

INSERT INTO `comite_regional` (`comitee_id`, `comitee_nom`) VALUES
(1, 'comité de bretagne');

-- --------------------------------------------------------

--
-- Table structure for table `commissaire`
--

CREATE TABLE `commissaire` (
  `commissaire_id` int(11) NOT NULL,
  `personne_id` int(11) NOT NULL,
  `comitee_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `commissaire`
--

INSERT INTO `commissaire` (`commissaire_id`, `personne_id`, `comitee_id`) VALUES
(1, 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `equipage`
--

CREATE TABLE `equipage` (
  `equipage_id` int(11) NOT NULL,
  `participant_id` int(11) NOT NULL,
  `skipper_id` int(11) NOT NULL,
  `bateau_id` int(11) NOT NULL,
  `regatta_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `equipage`
--

INSERT INTO `equipage` (`equipage_id`, `participant_id`, `skipper_id`, `bateau_id`, `regatta_id`) VALUES
(1, 2, 1, 1, 3),
(2, 1, 1, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `jury`
--

CREATE TABLE `jury` (
  `jury_id` int(11) NOT NULL,
  `personne_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jury`
--

INSERT INTO `jury` (`jury_id`, `personne_id`) VALUES
(1, 4),
(2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `participant`
--

CREATE TABLE `participant` (
  `participant_id` int(11) NOT NULL,
  `personne_id` int(11) NOT NULL,
  `participant_FFV` tinyint(1) NOT NULL DEFAULT '0',
  `participant_dob` int(4) NOT NULL,
  `participant_licence` varchar(20) NOT NULL,
  `participant_licence_annee` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `participant`
--

INSERT INTO `participant` (`participant_id`, `personne_id`, `participant_FFV`, `participant_dob`, `participant_licence`, `participant_licence_annee`) VALUES
(1, 2, 1, 1985, 'FDD125HGF', 2016),
(2, 3, 1, 1978, 'FD5255GF', 2010);

-- --------------------------------------------------------

--
-- Table structure for table `participe`
--

CREATE TABLE `participe` (
  `resultat_id` int(11) NOT NULL,
  `regatte_id` int(11) NOT NULL,
  `skipper_id` int(11) NOT NULL,
  `resultat_temp_reel` time NOT NULL,
  `temp_copmpose` time NOT NULL,
  `resultat_position` int(2) NOT NULL,
  `code _id` int(11) NOT NULL,
  `jury_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `participe`
--

INSERT INTO `participe` (`resultat_id`, `regatte_id`, `skipper_id`, `resultat_temp_reel`, `temp_copmpose`, `resultat_position`, `code _id`, `jury_id`) VALUES
(1, 2, 1, '02:12:00', '02:11:00', 1, 3, 2),
(2, 2, 1, '03:00:00', '02:31:00', 2, 2, 1);

--
-- Triggers `participe`
--
DELIMITER $$
CREATE TRIGGER `verifier resultat position du skipper` BEFORE UPDATE ON `participe` FOR EACH ROW BEGIN
DECLARE totalSkipper INT;
SELECT COUNT(skipper_id)
INTO totalSkipper
FROM participe
WHERE regatte_id=NEW.regatte_id;
IF
NEW.resultat_position > totalSkipper
THEN
SIGNAL SQLSTATE '45002' SET MESSAGE_TEXT = "position du skipper est superieur au nombre total de participant",MYSQL_ERRNO ="45001";
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `personne`
--

CREATE TABLE `personne` (
  `personne_id` int(11) NOT NULL,
  `personne_prenom` varchar(255) NOT NULL,
  `personne_nom` varchar(255) NOT NULL,
  `personne_email` varchar(255) NOT NULL,
  `personne_mdp` varchar(255) NOT NULL,
  `personne_addresse1` varchar(255) NOT NULL,
  `personne_addresse2` varchar(255) NOT NULL,
  `personne_ville` varchar(255) NOT NULL,
  `personne_pays` varchar(50) NOT NULL,
  `personne_langue` varchar(50) NOT NULL,
  `personne_tel` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `personne`
--

INSERT INTO `personne` (`personne_id`, `personne_prenom`, `personne_nom`, `personne_email`, `personne_mdp`, `personne_addresse1`, `personne_addresse2`, `personne_ville`, `personne_pays`, `personne_langue`, `personne_tel`) VALUES
(1, 'Marcel ', 'Martin', 'marcel.martin@gmail.com', 'password', '1 square des ajoncs', '29400', 'Landivisiau', 'France', 'Français', '0298680996'),
(2, 'Pierre', 'Letroc', 'pierre.letroc@gmail.com', 'password', '2 square des ajoncs', '29400', 'Landivisiau', 'France', 'Français', '0298680997'),
(3, 'Roger', 'Le Jay', 'roger.lejay@gmail.com', 'password', '144 rue Robespiere', '29200', 'Brest', 'France', 'Français', '029840251233'),
(4, 'Marion', 'Cueff', 'm.cueff@gmail.com', 'password', '20 rue Salengro', '29200', 'Brest', 'France', 'Français', '0265564215');

-- --------------------------------------------------------

--
-- Table structure for table `personnel`
--

CREATE TABLE `personnel` (
  `personnel_id` int(11) NOT NULL,
  `personnel_nom` varchar(50) NOT NULL,
  `personne_id` int(11) NOT NULL,
  `privilege` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `proprietaire`
--

CREATE TABLE `proprietaire` (
  `proprietaire_id` int(11) NOT NULL,
  `personne_id` int(11) NOT NULL,
  `club_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `proprietaire`
--

INSERT INTO `proprietaire` (`proprietaire_id`, `personne_id`, `club_id`) VALUES
(1, 1, 1),
(2, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `regatta`
--

CREATE TABLE `regatta` (
  `regatta_id` int(11) NOT NULL,
  `regatta_nom` varchar(255) NOT NULL,
  `regatta_date` date NOT NULL,
  `regatta_distance` float NOT NULL,
  `challenge_id` int(11) NOT NULL,
  `commissaire_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `regatta`
--

INSERT INTO `regatta` (`regatta_id`, `regatta_nom`, `regatta_date`, `regatta_distance`, `challenge_id`, `commissaire_id`) VALUES
(1, 'autour de la baie de morlaix', '2016-12-11', 1300.2, 2, 1),
(2, 'le saut de bichon', '2016-12-11', 500.5, 2, 1),
(3, 'le test de ouf', '2017-11-15', 250.5, 1, 1);

--
-- Triggers `regatta`
--
DELIMITER $$
CREATE TRIGGER `date_regate comprise dans dates de challenge` BEFORE INSERT ON `regatta` FOR EACH ROW BEGIN
DECLARE challengeStart DATE;
DECLARE challengeEnd DATE;
SELECT challenge_date_debut, challenge_date_fin
INTO  challengeStart,challengeEnd
FROM challenge
WHERE challenge_id = NEW.challenge_id;
if NEW.regatta_date<challengeStart OR NEW.regatta_date>challengeEnd
THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT ="la date de la regate est en dehors des dates du challenge selectionné",MYSQL_ERRNO ="45000";
END IF;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `supression impossible si challenge  pas terminé` BEFORE DELETE ON `regatta` FOR EACH ROW BEGIN
DECLARE challengeEnd DATE;
SELECT  challenge_date_fin
INTO  challengeEnd
FROM challenge
WHERE challenge_id = OLD.challenge_id;
if
OLD.regatta_date<=challengeEnd 
THEN
SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT ="le challenge pour cette régate n'est pas terminé. Supression Impossible",MYSQL_ERRNO ="45001";
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `serie`
--

CREATE TABLE `serie` (
  `serie_id` int(11) NOT NULL,
  `serie_nom` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `serie`
--

INSERT INTO `serie` (`serie_id`, `serie_nom`) VALUES
(1, 'Habitables'),
(2, 'Quillards de sport');

-- --------------------------------------------------------

--
-- Table structure for table `skipper`
--

CREATE TABLE `skipper` (
  `skipper_id` int(11) NOT NULL,
  `participant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `skipper`
--

INSERT INTO `skipper` (`skipper_id`, `participant_id`) VALUES
(1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bateau`
--
ALTER TABLE `bateau`
  ADD PRIMARY KEY (`bateau_id`),
  ADD UNIQUE KEY `proprietaire_id` (`proprietaire_id`),
  ADD UNIQUE KEY `classe_id` (`classe_id`),
  ADD KEY `proprietaire_id_2` (`proprietaire_id`),
  ADD KEY `classe_id_2` (`classe_id`),
  ADD KEY `classe_id_3` (`classe_id`),
  ADD KEY `proprietaire_id_3` (`proprietaire_id`);

--
-- Indexes for table `challenge`
--
ALTER TABLE `challenge`
  ADD PRIMARY KEY (`challenge_id`);

--
-- Indexes for table `classe`
--
ALTER TABLE `classe`
  ADD PRIMARY KEY (`classe_id`),
  ADD KEY `serie_id` (`serie_id`);

--
-- Indexes for table `club`
--
ALTER TABLE `club`
  ADD PRIMARY KEY (`club_id`);

--
-- Indexes for table `code`
--
ALTER TABLE `code`
  ADD PRIMARY KEY (`code_id`);

--
-- Indexes for table `comite_regional`
--
ALTER TABLE `comite_regional`
  ADD PRIMARY KEY (`comitee_id`);

--
-- Indexes for table `commissaire`
--
ALTER TABLE `commissaire`
  ADD PRIMARY KEY (`commissaire_id`),
  ADD UNIQUE KEY `personne_id_2` (`personne_id`),
  ADD KEY `personne_id` (`personne_id`),
  ADD KEY `comitee_id` (`comitee_id`);

--
-- Indexes for table `equipage`
--
ALTER TABLE `equipage`
  ADD PRIMARY KEY (`equipage_id`),
  ADD KEY `participant_id` (`participant_id`),
  ADD KEY `skipper_id` (`skipper_id`),
  ADD KEY `bateau_id` (`bateau_id`),
  ADD KEY `regatta_id` (`regatta_id`);

--
-- Indexes for table `jury`
--
ALTER TABLE `jury`
  ADD PRIMARY KEY (`jury_id`),
  ADD KEY `personne_id` (`personne_id`);

--
-- Indexes for table `participant`
--
ALTER TABLE `participant`
  ADD PRIMARY KEY (`participant_id`),
  ADD KEY `personne_id` (`personne_id`);

--
-- Indexes for table `participe`
--
ALTER TABLE `participe`
  ADD PRIMARY KEY (`resultat_id`),
  ADD KEY `code _id` (`code _id`),
  ADD KEY `regatte_id` (`regatte_id`),
  ADD KEY `skipper_id` (`skipper_id`),
  ADD KEY `jury_id` (`jury_id`);

--
-- Indexes for table `personne`
--
ALTER TABLE `personne`
  ADD PRIMARY KEY (`personne_id`);

--
-- Indexes for table `personnel`
--
ALTER TABLE `personnel`
  ADD PRIMARY KEY (`personnel_id`),
  ADD KEY `personne_id` (`personne_id`);

--
-- Indexes for table `proprietaire`
--
ALTER TABLE `proprietaire`
  ADD PRIMARY KEY (`proprietaire_id`),
  ADD KEY `personne_id` (`personne_id`),
  ADD KEY `club_id` (`club_id`);

--
-- Indexes for table `regatta`
--
ALTER TABLE `regatta`
  ADD PRIMARY KEY (`regatta_id`),
  ADD KEY `challenge_id` (`challenge_id`),
  ADD KEY `commissaire_id` (`commissaire_id`);

--
-- Indexes for table `serie`
--
ALTER TABLE `serie`
  ADD PRIMARY KEY (`serie_id`);

--
-- Indexes for table `skipper`
--
ALTER TABLE `skipper`
  ADD PRIMARY KEY (`skipper_id`),
  ADD KEY `participant_id` (`participant_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bateau`
--
ALTER TABLE `bateau`
  MODIFY `bateau_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `challenge`
--
ALTER TABLE `challenge`
  MODIFY `challenge_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `classe`
--
ALTER TABLE `classe`
  MODIFY `classe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `club`
--
ALTER TABLE `club`
  MODIFY `club_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `code`
--
ALTER TABLE `code`
  MODIFY `code_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `comite_regional`
--
ALTER TABLE `comite_regional`
  MODIFY `comitee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `commissaire`
--
ALTER TABLE `commissaire`
  MODIFY `commissaire_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `equipage`
--
ALTER TABLE `equipage`
  MODIFY `equipage_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `jury`
--
ALTER TABLE `jury`
  MODIFY `jury_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `participant`
--
ALTER TABLE `participant`
  MODIFY `participant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `participe`
--
ALTER TABLE `participe`
  MODIFY `resultat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `personne`
--
ALTER TABLE `personne`
  MODIFY `personne_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `personnel`
--
ALTER TABLE `personnel`
  MODIFY `personnel_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `proprietaire`
--
ALTER TABLE `proprietaire`
  MODIFY `proprietaire_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `regatta`
--
ALTER TABLE `regatta`
  MODIFY `regatta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `serie`
--
ALTER TABLE `serie`
  MODIFY `serie_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `skipper`
--
ALTER TABLE `skipper`
  MODIFY `skipper_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `bateau`
--
ALTER TABLE `bateau`
  ADD CONSTRAINT `bateau_ibfk_1` FOREIGN KEY (`proprietaire_id`) REFERENCES `proprietaire` (`proprietaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `bateau_ibfk_2` FOREIGN KEY (`classe_id`) REFERENCES `classe` (`classe_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `classe`
--
ALTER TABLE `classe`
  ADD CONSTRAINT `classe_ibfk_1` FOREIGN KEY (`serie_id`) REFERENCES `serie` (`serie_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `commissaire`
--
ALTER TABLE `commissaire`
  ADD CONSTRAINT `commissaire_ibfk_2` FOREIGN KEY (`comitee_id`) REFERENCES `comite_regional` (`comitee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `commissaire_ibfk_3` FOREIGN KEY (`personne_id`) REFERENCES `personne` (`personne_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `equipage`
--
ALTER TABLE `equipage`
  ADD CONSTRAINT `equipage_ibfk_1` FOREIGN KEY (`participant_id`) REFERENCES `participant` (`participant_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `equipage_ibfk_2` FOREIGN KEY (`skipper_id`) REFERENCES `skipper` (`skipper_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `equipage_ibfk_3` FOREIGN KEY (`bateau_id`) REFERENCES `bateau` (`bateau_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `equipage_ibfk_4` FOREIGN KEY (`regatta_id`) REFERENCES `regatta` (`regatta_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `jury`
--
ALTER TABLE `jury`
  ADD CONSTRAINT `jury_ibfk_1` FOREIGN KEY (`personne_id`) REFERENCES `personne` (`personne_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `participant`
--
ALTER TABLE `participant`
  ADD CONSTRAINT `participant_ibfk_1` FOREIGN KEY (`personne_id`) REFERENCES `personne` (`personne_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `participe`
--
ALTER TABLE `participe`
  ADD CONSTRAINT `participe_ibfk_1` FOREIGN KEY (`regatte_id`) REFERENCES `regatta` (`regatta_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `participe_ibfk_2` FOREIGN KEY (`skipper_id`) REFERENCES `skipper` (`skipper_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `participe_ibfk_3` FOREIGN KEY (`code _id`) REFERENCES `code` (`code_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `participe_ibfk_4` FOREIGN KEY (`jury_id`) REFERENCES `jury` (`jury_id`);

--
-- Constraints for table `personnel`
--
ALTER TABLE `personnel`
  ADD CONSTRAINT `personnel_ibfk_1` FOREIGN KEY (`personne_id`) REFERENCES `personne` (`personne_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `proprietaire`
--
ALTER TABLE `proprietaire`
  ADD CONSTRAINT `proprietaire_ibfk_1` FOREIGN KEY (`personne_id`) REFERENCES `personne` (`personne_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `proprietaire_ibfk_2` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`);

--
-- Constraints for table `regatta`
--
ALTER TABLE `regatta`
  ADD CONSTRAINT `regatta_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenge` (`challenge_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `regatta_ibfk_2` FOREIGN KEY (`commissaire_id`) REFERENCES `commissaire` (`commissaire_id`);

--
-- Constraints for table `skipper`
--
ALTER TABLE `skipper`
  ADD CONSTRAINT `skipper_ibfk_2` FOREIGN KEY (`participant_id`) REFERENCES `participant` (`participant_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
