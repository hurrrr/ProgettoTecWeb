-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Creato il: Nov 29, 2017 alle 18:20
-- Versione del server: 5.7.20-0ubuntu0.17.10.1
-- Versione PHP: 7.1.8-1ubuntu1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `biglietteria`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `biglietti`
--

CREATE OR REPLACE TABLE `biglietti` (
  `id` int(11) NOT NULL,
  `utente_id` int(11) NOT NULL DEFAULT '0',
  `spettacolo_id` int(11) NOT NULL DEFAULT '0',
  `codice` char(13) NOT NULL,
  `utilizzato` enum('si','no') NOT NULL DEFAULT 'no'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `biglietti`
--

INSERT INTO `biglietti` (`id`, `utente_id`, `spettacolo_id`, `codice`, `utilizzato`) VALUES
(1, 1, 1, '5a13607c335ff', 'no'),
(2, 4, 1, '5a1360bd111a7', 'no'),
(3, 1, 1, '5a16e1bb22cf7', 'no'),
(4, 1, 1, '5a1c23169e7b7', 'no'),
(5, 1, 4, '5a1d9c7e5e7a1', 'no'),
(6, 17, 1, '5a1d9db8850aa', 'no'),
(7, 17, 2, '5a1d9dbbe6217', 'no'),
(8, 17, 1, '5a1d9dbe9aff6', 'no'),
(9, 17, 8, '5a1d9dddb07d6', 'no'),
(10, 18, 10, '5a1d9f114f191', 'no'),
(11, 18, 10, '5a1d9f13b1caa', 'no'),
(12, 18, 10, '5a1d9f1629ecd', 'no'),
(13, 18, 5, '5a1d9f2a14ab1', 'no'),
(14, 24, 11, '5a1da2c942af5', 'no'),
(15, 24, 11, '5a1da2cbe4b0e', 'no'),
(16, 24, 9, '5a1da2d77ac6f', 'no'),
(17, 25, 8, '5a1da30035be5', 'no'),
(18, 25, 4, '5a1da3140f52b', 'no'),
(24, 1, 10, '5a1ee7709035f', 'no'),
(26, 1, 10, '5a1ee775af20b', 'no'),
(27, 1, 10, '5a1ee797cde53', 'no'),
(28, 1, 10, '5a1ee79e8b64c', 'no'),
(30, 1, 10, '5a1ee7fba35cc', 'no'),
(31, 1, 10, '5a1ee8e74a229', 'no'),
(32, 1, 10, '5a1eebffbf2e0', 'no');

--
-- Trigger `biglietti`
--
DELIMITER $$
CREATE TRIGGER `decrementa_posti` AFTER INSERT ON `biglietti` FOR EACH ROW UPDATE spettacoli
	SET spettacoli.posti_disponibili = spettacoli.posti_disponibili-1
	WHERE spettacoli.id = NEW.spettacolo_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `incrementa_posti` AFTER DELETE ON `biglietti` FOR EACH ROW UPDATE spettacoli
	SET spettacoli.posti_disponibili = spettacoli.posti_disponibili+1
    WHERE spettacoli.id = OLD.spettacolo_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `categorie`
--

CREATE TABLE `categorie` (
  `id` int(11) NOT NULL,
  `nome` char(50) NOT NULL DEFAULT '0',
  `descrizione` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `categorie`
--

INSERT INTO `categorie` (`id`, `nome`, `descrizione`) VALUES
(1, 'Cinema', 'Proiezioni cinematografiche'),
(2, 'Teatro', 'Spettacoli teatrali'),
(3, 'Sport', 'Eventi sportivi'),
(4, 'Musica', 'Concerti ed eventi musicali'),
(5, 'Musei', 'Esposizioni di quadri e arte'),
(6, 'Fiere', 'Fiere in centri fiere');

-- --------------------------------------------------------

--
-- Struttura della tabella `eventi`
--

CREATE TABLE `eventi` (
  `id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `nome` char(50) NOT NULL DEFAULT '0',
  `descrizione` longtext,
  `durata` time DEFAULT '00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `eventi`
--

INSERT INTO `eventi` (`id`, `categoria_id`, `nome`, `descrizione`, `durata`) VALUES
(1, 1, 'Jurassic World 2', 'Secondo spin-off della leggendaria serie \"Jurassic Park\"', '02:17:00'),
(3, 6, 'Fiera del mobile', 'Fiera con esposizione e presentazione di prodotti creati artigianalmente dai migliori professionisti della regione.', '00:00:00'),
(4, 6, 'Fiera della caccia e della pesca', 'Salone delle attivitÃ  faunistiche, venatorie e della pesca.', '00:00:00'),
(5, 3, 'Partita Juventus-Milan', 'Partita di champions League Juventus vs Milan.', '01:30:00'),
(6, 5, 'Esposizione di Van Gogh', 'Esposizione di quadri del celebre pittore impressionista Van Gogh', '00:00:00'),
(7, 2, 'Aida', 'Aida Ã¨ una principessa etiope, catturata e fatta schiava dagli Egiziani. Ama, ricambiata, RadamÃ©s, un comandante dell\'esercito, che Ã¨ a sua volta amato, ma invano, dalla figlia del faraone, la principessa  Amneris. L\'opera tratta della loro drammatica storia.', '03:20:00'),
(8, 4, 'Concerto Madonna', 'Concerto musica della famosa cantante pop Madonna.', '03:15:00'),
(9, 1, 'Iron man 3', 'Terzo film della saga di Iron Man prodotta dalla Marvel. Questa volta Tony Stark si scontrerÃ  con le sue stesse armature.', '01:55:00'),
(11, 4, 'Gigi d\'Alessio tour', 'Tuor con varie tappe italiane di Gigi d\'Alessio che presenterÃ  il suo nuovo disco.', '03:00:00'),
(12, 2, 'La BohÃ¨me', 'Interpretazione della celebre opera di Puccini.', '15:30:00'),
(13, 3, 'Federer vs. Nadal', 'Match di Tennis tra lo svizzero Roger Federer e lo spagnolo Nadal.', '03:00:00'),
(14, 1, 'Star Wars: Gli Ultimi Jedi', 'L\'attesissimo ottavo capitolo della celeberrima saga di fantascienza.', '02:30:00'),
(15, 1, 'Justice League', 'Film che narra le gesta del gruppo di supereroi creati dalla DC Comics.', '02:04:00'),
(16, 6, 'Fiera dell\'automobile d\'epoca', 'Fiera con numerose auto d\'epoca che ogni anno raduno appassionati da tutto il nord Italia.', '00:00:00');

-- --------------------------------------------------------

--
-- Struttura della tabella `luoghi`
--

CREATE TABLE `luoghi` (
  `id` int(11) NOT NULL,
  `nome` char(50) NOT NULL,
  `indirizzo` longtext,
  `telefono` char(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `luoghi`
--

INSERT INTO `luoghi` (`id`, `nome`, `indirizzo`, `telefono`) VALUES
(1, 'The Space Cinema', 'Via Breda, 11, 35010 Limena PD', '892 111'),
(2, 'Arena di Verona', 'Piazza BrÃ , 1, 37121 Verona (VR)', '045 800 5151'),
(3, 'Juventus Stadium', 'Corso Gaetano Scirea, 50, Torino (TO)', '899 999 897'),
(5, 'Centro fiere Vicenza', 'Via Oreficeria, 16, 36100 Vicenza VI', '0444 969111'),
(6, 'Multisala MPX', 'Via Antonio Francesco Bonporti, 22, 35141 Padova PD', '049 877 4325'),
(7, 'Musei civici agli Eremitani', 'Piazza Eremitani, 8, 35121 Padova PD', '049 820 4551'),
(8, 'Prato della Valle', 'Piazza Prato della Valle, 35121 Padova PD', '049 201 0080'),
(9, 'Porto Astra', 'Via Santa Maria Assunta, 20, 35125 Padova PD', '199 318 009'),
(10, 'Teatro Verdi', 'Via Livello, 32, 35139 Padova PD', '049 877 7011'),
(11, 'Fiera di Padova', 'Via NiccolÃ² Tommaseo, 59, 35131 Padova PD', '049 840111'),
(12, 'Centro Tennis Padova', 'Via Libia, 40, 35141 Padova PD', '049 880 5494');

-- --------------------------------------------------------

--
-- Struttura della tabella `spettacoli`
--

CREATE TABLE `spettacoli` (
  `id` int(11) NOT NULL,
  `evento_id` int(11) NOT NULL DEFAULT '0',
  `luogo_id` int(11) NOT NULL DEFAULT '0',
  `data_ora` datetime NOT NULL,
  `posti_disponibili` bigint(20) NOT NULL DEFAULT '0',
  `prezzo` decimal(7,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `spettacoli`
--

INSERT INTO `spettacoli` (`id`, `evento_id`, `luogo_id`, `data_ora`, `posti_disponibili`, `prezzo`) VALUES
(1, 1, 6, '2018-12-03 17:30:00', 98, '5.50'),
(2, 1, 9, '2018-12-03 19:30:00', 49, '5.50'),
(3, 15, 9, '2018-12-03 19:30:00', 45, '5.00'),
(4, 15, 6, '2018-03-15 22:30:00', 78, '7.50'),
(5, 7, 10, '2018-03-17 21:00:00', 219, '12.00'),
(6, 7, 10, '2018-03-19 21:00:00', 0, '12.00'),
(7, 16, 11, '2018-10-03 08:00:00', 800, '5.00'),
(8, 8, 3, '2018-03-08 21:30:00', 12, '60.00'),
(9, 16, 5, '2018-03-10 08:00:00', 999, '7.00'),
(10, 13, 12, '2018-03-20 20:00:00', 184, '25.00'),
(11, 5, 3, '2018-04-02 20:45:00', 34998, '48.00');

-- --------------------------------------------------------

--
-- Struttura della tabella `utenti`
--

CREATE TABLE `utenti` (
  `id` int(11) NOT NULL,
  `username` char(50) NOT NULL,
  `luogo_id` int(11) DEFAULT NULL,
  `pass` char(50) NOT NULL,
  `nome` char(50) NOT NULL,
  `cognome` char(50) NOT NULL,
  `email` char(50) NOT NULL,
  `tipo` enum('U','O','A','L') NOT NULL DEFAULT 'U'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `utenti`
--

INSERT INTO `utenti` (`id`, `username`, `luogo_id`, `pass`, `nome`, `cognome`, `email`, `tipo`) VALUES
(1, 'admin', NULL, '*4ACFE3202A5FF5CF467898FC58AAB1D615029441', 'Amministratore', 'Utente1', 'admin@admin.it', 'A'),
(3, 'operatore', NULL, '*8EAB1F519FB24E2D4E796F2E6A9E0DB306701778', 'Francesco', 'Parolini', 'freppo96@gmail.com', 'O'),
(4, 'user', NULL, '*D5D9F81F5542DE067FFF5FF7A4CA4BDD322C578F', 'ciao', 'Gualtieri', 'gualtio@endri.it', 'U'),
(5, 'freppo', NULL, '*7E983E1D5E5BFD4849CEE53BE2861447A06A74C1', 'Francesco', 'Parolini', 'freppo96@gmail.com', 'U'),
(6, 'freppo1', NULL, '*E6CC90B878B948C35E92B003C792C46C58C4AF40', '1', '1', '1@1', 'U'),
(7, 'freppo2', NULL, '*12033B78389744F3F39AC4CE4CCFCAD6960D8EA0', '2', '2', 'freppo@2', 'U'),
(9, 'multisalaking', 1, '*0117407580D33D1A7DF1B4859EE7B1BF7AF14690', 'multi', 'sala', 'king@king.it', 'L'),
(10, 'piazzaloggia', 8, '*42D4CBCB1ADBE3325BEDAAF8140FB2CC4C16905D', 'piazza', 'loggia', 'piazza@loggia.it', 'L'),
(11, 'user2', NULL, '*12A20BE57AF67CBF230D55FD33FBAF5230CFDBC4', 'Andrea', 'Gualtieri', 'andri@gualty.it', 'U'),
(12, 'mamma', NULL, '*33852BD37ED6B7EC4A767CF4ED9CB64F00989F75', 'Cristina', 'Maraviglia', 'wewewew@wewewee.it', 'U'),
(13, 'pippo', NULL, '*0F6188E353012D1D828CFA87047085E28AF17DD1', 'Pippo', 'Pluto', 'pippo@pluto.it', 'U'),
(14, 'ugo', NULL, '*A444649B9F4387691F2CC67135BFC05CA573CEE2', 'Ugo', 'Ughi', 'ugp@ugo.it', 'U'),
(15, 'gigi', NULL, '*431AB8EB0EEA6C3A23BD019F42485CBD770FE273', 'Gigi', 'de Gigi', 'gigi@gigi.it', 'U'),
(16, 'ALBA', NULL, '*5311C1D6F8C13C5E9A3638290B85DA95D94EEE8C', 'ALBA', 'ANSELMI', 'MAMMA@DIFREPPO.IT', 'O'),
(17, 'utente1', NULL, '*E4250EDE8B6AF2F03E8C30CEADE2832045359B2F', 'Utente', '1', 'utente1@esempio.it', 'U'),
(18, 'utente2', NULL, '*35549FA632A1453EC2B3900A97D6B0F5D08B6FA3', 'utente', '2', 'utente2@esempio.it', 'U'),
(19, 'TeatroVerdi', NULL, '*290B5F7001D96F72348F05F99052B7C6CCE5F770', 'Teatro', 'Verdi', 'TeatroVerdi@esempio.it', 'U'),
(20, 'CentroTennisPadova', NULL, '*125A2C0503298F7046E90113489F90F299B951F0', 'CentroTennis', 'Padova', 'CentroTennisPadova@esempio.it', 'U'),
(21, 'TheSpace', NULL, '*2EAE7754B7524C618FD0F13B6307BE0038364A74', 'The', 'Space', 'TheSpace@esempio.it', 'U'),
(22, 'CentroFiereVicenza', 5, '*B14AD1539D6F551D8DA197FD784A0CED18FE7C44', 'CentroFiere', 'Vicenza', 'centrofierevicenza@esempio.it', 'L'),
(23, 'TeatroVerdi1', 10, '*CEC0EFE8384B1065846C1145B273012EC0E5601C', 'TeatroVerdi', '1', 'TeatroVerdi1@esempio.it', 'L'),
(24, 'utente3', NULL, '*825FF6FC832043A82A0B42A5DD43C2892402ECA0', 'utente', '3', 'utente3@esempio.it', 'U'),
(25, 'utente4', NULL, '*188FCFC9A83C0BFB9617708FF295896A0031E95A', 'utente', '4', 'utente4@esempio.it', 'U');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `biglietti`
--
ALTER TABLE `biglietti`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codice` (`codice`),
  ADD KEY `spettacolo_id_fk` (`spettacolo_id`),
  ADD KEY `utente_id_fk` (`utente_id`);

--
-- Indici per le tabelle `categorie`
--
ALTER TABLE `categorie`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indici per le tabelle `eventi`
--
ALTER TABLE `eventi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria_id_fk` (`categoria_id`);

--
-- Indici per le tabelle `luoghi`
--
ALTER TABLE `luoghi`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `spettacoli`
--
ALTER TABLE `spettacoli`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evento_id_fk` (`evento_id`),
  ADD KEY `luogo_id_fk` (`luogo_id`);

--
-- Indici per le tabelle `utenti`
--
ALTER TABLE `utenti`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `fk_id_luogo` (`luogo_id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `biglietti`
--
ALTER TABLE `biglietti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT per la tabella `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT per la tabella `eventi`
--
ALTER TABLE `eventi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT per la tabella `luoghi`
--
ALTER TABLE `luoghi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT per la tabella `spettacoli`
--
ALTER TABLE `spettacoli`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT per la tabella `utenti`
--
ALTER TABLE `utenti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `biglietti`
--
ALTER TABLE `biglietti`
  ADD CONSTRAINT `spettacolo_id_fk` FOREIGN KEY (`spettacolo_id`) REFERENCES `spettacoli` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `utente_id_fk` FOREIGN KEY (`utente_id`) REFERENCES `utenti` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `eventi`
--
ALTER TABLE `eventi`
  ADD CONSTRAINT `categoria_id_fk` FOREIGN KEY (`categoria_id`) REFERENCES `categorie` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `spettacoli`
--
ALTER TABLE `spettacoli`
  ADD CONSTRAINT `evento_id_fk` FOREIGN KEY (`evento_id`) REFERENCES `eventi` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `luogo_id_fk` FOREIGN KEY (`luogo_id`) REFERENCES `luoghi` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `utenti`
--
ALTER TABLE `utenti`
  ADD CONSTRAINT `fk_id_luogo` FOREIGN KEY (`luogo_id`) REFERENCES `luoghi` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
