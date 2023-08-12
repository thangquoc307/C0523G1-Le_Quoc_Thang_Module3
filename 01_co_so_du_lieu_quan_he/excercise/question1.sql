CREATE DATABASE `lesson_1`;
USE `lesson_1`;
CREATE TABLE `Student`(
	id int primary key auto_increment,
    `name` varchar(200)
);
CREATE TABLE `Teacher`(
	id int primary key auto_increment,
    `name` varchar(200),
    age int,
    country varchar(200)
);

INSERT INTO `Student`(`name`)
values ("Thắng 1"),("Thắng 2"),("Thắng 3");
