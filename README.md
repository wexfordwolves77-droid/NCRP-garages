SQL-

CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `owner` VARCHAR(50) NOT NULL,
  `plate` VARCHAR(20) NOT NULL,
  `vehicle` LONGTEXT NOT NULL,
  `stored` BOOLEAN DEFAULT true,
  PRIMARY KEY (`id`)
);
