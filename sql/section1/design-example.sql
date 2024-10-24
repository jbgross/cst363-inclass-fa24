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
-- Table `student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `student` ;

CREATE TABLE IF NOT EXISTS `student` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `dob` DATE NOT NULL,
  `heightInInches` INT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `course` ;

CREATE TABLE IF NOT EXISTS `course` (
  `course_id` VARCHAR(8) NOT NULL,
  `title` VARCHAR(64) NOT NULL,
  `credits` INT NOT NULL,
  PRIMARY KEY (`course_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `section` ;

CREATE TABLE IF NOT EXISTS `section` (
  `course_id` VARCHAR(8) NOT NULL,
  `sec_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`course_id`, `sec_id`),
  CONSTRAINT `fk_section_course`
    FOREIGN KEY (`course_id`)
    REFERENCES `course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `takes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `takes` ;

CREATE TABLE IF NOT EXISTS `takes` (
  `student_ID` INT NOT NULL,
  `section_course_id` VARCHAR(8) NOT NULL,
  `section_sec_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`student_ID`, `section_course_id`, `section_sec_id`),
  INDEX `fk_student_has_section_section1_idx` (`section_course_id` ASC, `section_sec_id` ASC) VISIBLE,
  INDEX `fk_student_has_section_student1_idx` (`student_ID` ASC) VISIBLE,
  CONSTRAINT `fk_student_has_section_student1`
    FOREIGN KEY (`student_ID`)
    REFERENCES `student` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_has_section_section 1`
    FOREIGN KEY (`section_course_id` , `section_sec_id`)
    REFERENCES `section` (`course_id` , `sec_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
