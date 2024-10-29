-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `department` ;

CREATE TABLE IF NOT EXISTS `department` (
  `dept_name` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`dept_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `student` ;

CREATE TABLE IF NOT EXISTS `student` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `dob` DATE NULL,
  `dept_name` VARCHAR(32) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_student_department1_idx` (`dept_name` ASC) VISIBLE,
  CONSTRAINT `fk_student_department1`
    FOREIGN KEY (`dept_name`)
    REFERENCES `department` (`dept_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `section` ;

CREATE TABLE IF NOT EXISTS `section` (
  `course_id` VARCHAR(16) NOT NULL,
  `title` VARCHAR(64) NOT NULL,
  `credits` INT NULL,
  PRIMARY KEY (`course_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `student_has_section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `student_has_section` ;

CREATE TABLE IF NOT EXISTS `student_has_section` (
  `ID` INT NOT NULL,
  `course_id` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`ID`, `course_id`),
  INDEX `fk_student_has_section_section1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_student_has_section_student_idx` (`ID` ASC) VISIBLE,
  CONSTRAINT `fk_student_has_section_student`
    FOREIGN KEY (`ID`)
    REFERENCES `student` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_has_section_section1`
    FOREIGN KEY (`course_id`)
    REFERENCES `section` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
