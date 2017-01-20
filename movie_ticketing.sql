-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2015 at 04:48 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db_final`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cancelBooking`(IN `booking_id1` INT(11))
begin
update bookings set cancel_date = curdate(), status = 2 where booking_id = booking_id1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cityList`()
begin
select distinct city from theatre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getTheatresByMovie`(IN `Movie` VARCHAR(255), IN `city` VARCHAR(255))
begin
select distinct name from theatre t join shows s
on t.id = s.theatre_id
and s.date >= curdate()
and s.availability>=1
join movie m on m.movie_id = s.movie_id
and m.title = Movie
and t.city = city;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertBookings`(IN `user_id` INT(11), IN `show_id` INT(11), IN `num_tickets` INT(11), OUT `booking_id` INT(11))
begin
insert into bookings (user_id, show_id, booking_date, cancel_date, status, num_tickets)
values (user_id, show_id, curdate(), null, 1, num_tickets);
set booking_id = last_insert_ID();
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `moviesByCity`(IN `city` VARCHAR(255))
begin
select distinct m.title from movie m join shows s on s.movie_id = m.movie_id join theatre t on t.id = s.theatre_id and t.city = city;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showsByTheatreAndMovie`(IN `theatre_name` VARCHAR(255), IN `movie` VARCHAR(255))
begin
select s.id, s.date,s.timing from shows s join theatre t on t.id = s.theatre_id
join movie m on m.movie_id = s.movie_id
and s.date >= curdate()
and s.availability>=1
and t.name = theatre_name
and m.title = movie;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Signup`(IN `first_name` VARCHAR(200), IN `last_name` VARCHAR(200), IN `email` VARCHAR(200), IN `password` VARCHAR(50), IN `addr_line1` VARCHAR(500), IN `addr_line2` VARCHAR(500), IN `city` VARCHAR(100), IN `state` VARCHAR(100), IN `zip` VARCHAR(10), IN `card_number` VARCHAR(16), IN `expiry_date` DATE, IN `cvv` VARCHAR(3), IN `name_on_card` VARCHAR(100))
BEGIN
declare user_id int(11);
select@user_id := max(id)  from user ; 
Insert into User  (id, first_name, last_name, email, password, addr_line1, addr_line2,city, state, zip, card_number, expiry_date, cvv, name_on_card) 
Values (@user_id+1, first_name, last_name, email, password, addr_line1, addr_line2, city, state, zip, card_number, expiry_date, cvv, name_on_card);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `userBookings`(IN `user_id` INT(11))
BEGIN
select b.booking_id, t.city, t.name, m.title, s.date, s.timing, b.num_tickets from bookings b 
join shows s on s.id = b.show_id 
join movie m on m.movie_id = s.movie_id 
join theatre t on t.id = s.theatre_id 
and s.date > curdate() 
and status = 1 and user_id = user_id order by b.booking_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validatelogin`(IN `email1` VARCHAR(200), IN `password1` VARCHAR(50), OUT `result` VARCHAR(100), OUT `status` INT(2) ZEROFILL, OUT `userId` INT(5) ZEROFILL)
begin
declare count int;
set count = loginvalidation(email1, password1);
SELECT count INTO status;
if count = 1 then
select concat(first_name,' ',last_name) INTO result from user where email = email1 and password = password1;
select id INTO userId from user where email = email1 and password = password1;
elseif count = 2 then
select 'id/password does not match' INTO result;
elseif count = 3 then
select 'user does not exist' INTO result;
end if;
end$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `loginvalidation`(email1 varchar(200), password1 varchar(50)) RETURNS int(11)
BEGIN
        IF exists (SELECT 1 = 1 FROM user WHERE user.email = email1 and user.password = password1) THEN
        BEGIN
        return 1;
        END;
        ELSEIF exists (select 1 = 1 from user where email = email1 and password<> password1) then
        begin
        return 2;
        end;
        else
        BEGIN
        return 3;
        END;
        end if;
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `actor`
--

CREATE TABLE IF NOT EXISTS `actor` (
  `movie_id` int(11) NOT NULL,
  `actor` varchar(200) NOT NULL,
  PRIMARY KEY (`actor`,`movie_id`),
  UNIQUE KEY `movie_id_actor_index` (`movie_id`,`actor`),
  KEY `fk_movie1_id` (`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `actor`
--

INSERT INTO `actor` (`movie_id`, `actor`) VALUES
(1, 'Christoph Waltz'),
(1, 'Daniel Craig'),
(1, 'Léa Seydoux'),
(2, 'Bill Melendez'),
(2, 'Hadley Belle Miller'),
(2, 'Noah Schnapp'),
(3, 'Jennifer Lawrence'),
(3, 'Josh Hutcherson'),
(3, 'Liam Hemsworth'),
(4, 'Alan Alda'),
(4, 'Mark Rylance'),
(4, 'Tom Hanks'),
(5, 'Jessica Chastain'),
(5, 'Kristen Wiig'),
(5, 'Matt Damon');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE IF NOT EXISTS `bookings` (
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `show_id` int(11) NOT NULL,
  `booking_date` date NOT NULL,
  `cancel_date` date DEFAULT NULL,
  `status` int(11) NOT NULL,
  `num_tickets` int(11) NOT NULL,
  PRIMARY KEY (`booking_id`),
  UNIQUE KEY `booking_id_index` (`booking_id`),
  KEY `fk_show_id` (`show_id`),
  KEY `fk_user_id` (`user_id`),
  KEY `show_id_booking_index` (`show_id`),
  KEY `user_id_booking_index` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=34 ;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `show_id`, `booking_date`, `cancel_date`, `status`, `num_tickets`) VALUES
(1, 3, 1, '2015-11-15', '2015-12-09', 2, 3),
(2, 1, 10, '2015-11-15', '2015-12-09', 2, 5),
(3, 2, 2, '2015-11-16', '0000-00-00', 1, 3),
(4, 3, 1, '2015-11-14', '0000-00-00', 1, 4),
(5, 4, 9, '2015-11-25', '0000-00-00', 1, 5),
(6, 5, 5, '2015-11-17', '0000-00-00', 1, 3),
(7, 6, 1, '2015-11-16', '0000-00-00', 1, 8),
(8, 2, 25, '2015-11-23', '0000-00-00', 1, 2),
(9, 3, 15, '2015-11-20', '0000-00-00', 1, 3),
(10, 5, 18, '2015-11-25', '0000-00-00', 1, 5),
(11, 3, 22, '2015-11-30', '0000-00-00', 1, 2),
(12, 1, 2, '2015-12-08', '0000-00-00', 1, 3),
(13, 1, 3, '2015-12-08', '0000-00-00', 1, 6),
(16, 1, 7, '2015-12-08', '0000-00-00', 1, 2),
(17, 1, 8, '2015-12-08', '0000-00-00', 1, 5),
(18, 1, 7, '2015-12-08', '0000-00-00', 1, 3),
(19, 2, 4, '2015-12-08', '0000-00-00', 1, 4),
(20, 4, 4, '2015-12-08', '0000-00-00', 1, 4),
(22, 1, 8, '2015-12-08', '0000-00-00', 1, 7),
(23, 1, 7, '2015-12-08', '0000-00-00', 1, 1),
(24, 1, 12, '2015-12-08', '0000-00-00', 1, 1),
(25, 1, 3, '2015-12-08', '0000-00-00', 1, 1),
(26, 1, 18, '2015-12-09', '0000-00-00', 1, 2),
(27, 1, 1, '2015-12-09', '0000-00-00', 1, 1),
(28, 1, 11, '2015-12-09', '0000-00-00', 1, 2),
(29, 1, 1, '2015-12-09', '2015-12-10', 2, 1),
(30, 1, 23, '2015-12-09', '2015-12-09', 2, 9),
(31, 1, 13, '2015-12-09', '2015-12-09', 2, 10),
(32, 1, 4, '2015-12-10', '2015-12-10', 2, 3),
(33, 1, 14, '2015-12-10', '2015-12-10', 2, 5);

--
-- Triggers `bookings`
--
DROP TRIGGER IF EXISTS `ai_booktickets`;
DELIMITER //
CREATE TRIGGER `ai_booktickets` AFTER INSERT ON `bookings`
 FOR EACH ROW Begin
update shows
set availability = availability-new.num_tickets where id = new.show_id;
end
//
DELIMITER ;
DROP TRIGGER IF EXISTS `au_cancelBooking`;
DELIMITER //
CREATE TRIGGER `au_cancelBooking` AFTER UPDATE ON `bookings`
 FOR EACH ROW BEGIN
IF NEW.status <> OLD.status then
 
update shows
set availability = availability + new.num_tickets where id = new.show_id;
 
END if;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `director`
--

CREATE TABLE IF NOT EXISTS `director` (
  `movie_id` int(11) NOT NULL,
  `director` varchar(200) NOT NULL,
  PRIMARY KEY (`director`,`movie_id`),
  UNIQUE KEY `movie_id_director_index` (`movie_id`,`director`),
  KEY `fk_movie2_id` (`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `director`
--

INSERT INTO `director` (`movie_id`, `director`) VALUES
(1, 'Sam Mendes'),
(2, 'Bryan Schulz'),
(2, 'Charles M. Schulz'),
(2, 'Steve Martino'),
(3, 'Francis Lawrence'),
(4, 'Steven Spielberg'),
(5, 'Ridley Scott');

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE IF NOT EXISTS `genre` (
  `movie_id` int(11) NOT NULL,
  `genre` varchar(200) NOT NULL,
  PRIMARY KEY (`genre`,`movie_id`),
  UNIQUE KEY `movie_id_genre_index` (`movie_id`,`genre`),
  KEY `fk_movie3_id` (`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`movie_id`, `genre`) VALUES
(1, 'Action'),
(1, 'Adventure'),
(1, 'Thriller'),
(2, 'Adventure'),
(2, 'Animation'),
(2, 'Comedy'),
(3, 'Adventure'),
(3, 'Sci-Fi'),
(4, 'Biography'),
(4, 'Drama'),
(4, 'History'),
(5, 'Adventure'),
(5, 'Comedy'),
(5, 'Drama');

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE IF NOT EXISTS `movie` (
  `movie_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `synopsis` varchar(500) NOT NULL,
  `duration` varchar(50) NOT NULL,
  PRIMARY KEY (`movie_id`),
  UNIQUE KEY `movie_id_index` (`movie_id`),
  FULLTEXT KEY `movie_title_index` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`movie_id`, `title`, `synopsis`, `duration`) VALUES
(1, 'Spectre', 'A cryptic message from Bond''s past sends him on a trail to uncover a sinister organisation. While M battles political forces to keep the secret service alive, Bond peels back the layers of deceit to reveal the terrible truth behind Spectre1.', '148'),
(2, 'The Peanuts Movie', 'Snoopy embarks upon his greatest mission as he and his team take to the skies to pursue their arch-nemesis, while his best pal Charlie Brown begins his own epic quest back home.', '88'),
(3, 'The Hunger Games: Mockingjay - Part 2', 'As the war of Panem escalates to the destruction of other districts by the Capitol, Katniss Everdeen, the reluctant leader of the rebellion, must bring together an army against President Snow, while all she holds dear hangs in the balance.', '88'),
(4, 'Bridge of Spies', 'During the Cold War, an American lawyer is recruited to defend an arrested Soviet spy in court, and then help the CIA facilitate an exchange of the spy for the Soviet captured American U2 spy plane pilot, Francis Gary Powers.', '141'),
(5, 'The Martian', 'During a manned mission to Mars, Astronaut Mark Watney is presumed dead after a fierce storm and left behind by his crew. But Watney has survived and finds himself stranded and alone on the hostile planet. With only meager supplies, he must draw upon his ingenuity, wit and spirit to subsist and find a way to signal to Earth that he is alive.', '144');

-- --------------------------------------------------------

--
-- Table structure for table `shows`
--

CREATE TABLE IF NOT EXISTS `shows` (
  `ID` int(11) NOT NULL,
  `price` decimal(5,2) NOT NULL,
  `timing` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `availability` int(11) NOT NULL,
  `theatre_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `show_id_index` (`ID`),
  KEY `fk_movie_id` (`movie_id`),
  KEY `fk_theatre_id` (`theatre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shows`
--

INSERT INTO `shows` (`ID`, `price`, `timing`, `date`, `availability`, `theatre_id`, `movie_id`) VALUES
(1, '10.00', '12:30 PM', '2015-12-15', 252, 1, 1),
(2, '13.00', '5:45 PM', '2015-12-15', 242, 1, 2),
(3, '13.00', '9:00 PM', '2015-12-15', 233, 1, 1),
(4, '13.00', '12:00 PM', '2015-12-16', 242, 1, 3),
(5, '12.00', '5:00 PM', '2015-12-16', 250, 1, 1),
(6, '12.00', '9:00 PM', '2015-12-16', 250, 1, 1),
(7, '12.00', '12:30 PM', '2015-12-15', 194, 2, 3),
(8, '12.00', '4:30 PM', '2015-12-15', 188, 2, 3),
(9, '12.00', '8:30 PM', '2015-12-16', 193, 2, 3),
(10, '12.00', '12:30 PM', '2015-12-16', 205, 2, 3),
(11, '12.00', '4:30 PM', '2015-12-16', 198, 2, 3),
(12, '12.00', '8:30 PM', '2015-12-15', 199, 2, 3),
(13, '12.00', '12:00 PM', '2015-12-15', 250, 3, 5),
(14, '12.00', '4:00 PM', '2015-12-15', 250, 3, 5),
(15, '12.00', '7:00 PM', '2015-12-15', 250, 3, 4),
(16, '12.00', '11:00 PM', '2015-12-15', 250, 3, 4),
(17, '12.00', '4:00 PM', '2015-12-16', 250, 3, 4),
(18, '12.00', '9:00 PM', '2015-12-16', 248, 3, 4),
(19, '15.00', '5:30 PM', '2015-12-15', 200, 4, 3),
(20, '15.00', '9:00 PM', '2015-12-15', 200, 4, 3),
(21, '15.00', '5:30 PM', '2015-12-16', 200, 4, 3),
(22, '15.00', '9:00 PM', '2015-12-16', 200, 4, 3),
(23, '13.00', '6:00 PM', '2015-12-15', 200, 5, 1),
(24, '13.00', '10:00 PM', '2015-12-15', 200, 5, 1),
(25, '13.00', '01:00 PM', '2015-12-15', 200, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `theatre`
--

CREATE TABLE IF NOT EXISTS `theatre` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `theatre_id_index` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `theatre`
--

INSERT INTO `theatre` (`ID`, `name`, `city`) VALUES
(1, 'AMC Northlake 15', 'Charlotte'),
(2, 'Regal Cinemas Crossroad', 'Raleigh'),
(3, 'Carmike 7', 'Rock Hill'),
(4, 'Sedgefield Crossing''s Cinema', 'Greensboro'),
(5, 'Palace Pointe', 'Roxboro'),
(6, 'Cinepolis', 'Charlotte');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL,
  `first_name` varchar(200) NOT NULL,
  `last_name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(50) NOT NULL,
  `addr_line1` varchar(500) NOT NULL,
  `addr_line2` varchar(500) DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `zip` varchar(10) NOT NULL,
  `card_number` varchar(16) NOT NULL,
  `expiry_date` date NOT NULL,
  `cvv` varchar(3) NOT NULL,
  `name_on_card` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `user_id_index` (`id`),
  KEY `last_name_index` (`last_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `addr_line1`, `addr_line2`, `city`, `state`, `zip`, `card_number`, `expiry_date`, `cvv`, `name_on_card`) VALUES
(1, 'Boyu', 'Fan', 'boyu@mail.com', 'password123', '17815halton park dr.', 'Apt.3B', 'Charlotte', 'North Carolina', '28262', '3542678584265321', '2017-09-01', '897', 'Boyufan'),
(2, 'Sandeep', 'Nalla', 'sandeep@mail.com', 'password123', '9523 University Terrace Dr', 'Apt B', 'Charlotte', 'North Carolina', '28262', '7854544872265888', '2016-09-23', '851', 'Sandeep'),
(3, 'Gregory', 'Wilson', 'greg@mail.com', 'password123', '061 E Main St', 'Apt 1', 'Roxboro', 'North Carolina', '32321', '1234567890191837', '2016-01-03', '830', NULL),
(4, 'Alex', 'Sun', 'alex@mail.com', 'password123', '512 Tartan Circle', 'Apt.24', 'Raleigh', 'North Carolina', '27606', '6574868614361892', '2015-12-15', '744', 'Alex X. Sun'),
(5, 'Lisa', 'Chase', 'chase@mail.com', 'password123', '43 Ridge Rd', NULL, 'Rockhill', 'North Carolina', '28905', '8372783867674167', '2019-06-30', '189', NULL),
(6, 'James', 'Lee', 'lee@mail.com', 'password123', '103 River Rd', NULL, 'Greensboro', 'North Carolina', '34602', '6657273910384712', '2016-02-27', '367', NULL),
(7, 'Himaja', 'Reddy', 'hredasddy@mail.com', '1223434', 'A123123B', 'Z234324A', 'clt', 'nc', '28262', 'hreddy', '2020-02-10', '123', '123123423453'),
(8, 'sdffsd', 'sadas', 'sdas@sdfs', '', '', '', '', '', '', '', '0000-00-00', '', ''),
(9, 'aedad', 'adasd', 'sdasd', 'sadasd', 'ewrqweqw', '', 'erer', '4rewf', '34234', 'ewfasfsdf', '0000-00-00', '343', '334234234'),
(10, 'swds', 'sadsa', 'sdasd@sdf.com', 'sadasd', 'asdasd', '', 'sadsa', 'sdsa', 'asd34', '', '0000-00-00', '233', 'sxxX');

-- --------------------------------------------------------

--
-- Stand-in structure for view `userbooking`
--
CREATE TABLE IF NOT EXISTS `userbooking` (
`name` varchar(255)
,`title` varchar(200)
,`date` date
,`timing` varchar(20)
,`id` int(11)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `usernamepassword`
--
CREATE TABLE IF NOT EXISTS `usernamepassword` (
`email` varchar(200)
,`password` varchar(50)
);
-- --------------------------------------------------------

--
-- Structure for view `userbooking`
--
DROP TABLE IF EXISTS `userbooking`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `userbooking` AS select `t`.`name` AS `name`,`m`.`title` AS `title`,`s`.`date` AS `date`,`s`.`timing` AS `timing`,`u`.`id` AS `id` from ((((`theatre` `t` join `shows` `s` on((`s`.`theatre_id` = `t`.`ID`))) join `movie` `m` on((`m`.`movie_id` = `s`.`movie_id`))) join `bookings` `b` on((`b`.`show_id` = `s`.`ID`))) join `user` `u` on((`u`.`id` = `b`.`user_id`)));

-- --------------------------------------------------------

--
-- Structure for view `usernamepassword`
--
DROP TABLE IF EXISTS `usernamepassword`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `usernamepassword` AS select `movie_ticketing`.`user`.`email` AS `email`,`movie_ticketing`.`user`.`password` AS `password` from `movie_ticketing`.`user`;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `actor`
--
ALTER TABLE `actor`
  ADD CONSTRAINT `fk_movie1_id` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`movie_id`);

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `fk_show_id` FOREIGN KEY (`show_id`) REFERENCES `shows` (`ID`),
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `director`
--
ALTER TABLE `director`
  ADD CONSTRAINT `fk_movie2_id` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`movie_id`);

--
-- Constraints for table `genre`
--
ALTER TABLE `genre`
  ADD CONSTRAINT `fk_movie3_id` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`movie_id`);

--
-- Constraints for table `shows`
--
ALTER TABLE `shows`
  ADD CONSTRAINT `fk_movie_id` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`movie_id`),
  ADD CONSTRAINT `fk_theatre_id` FOREIGN KEY (`theatre_id`) REFERENCES `theatre` (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
