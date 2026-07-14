-- Create Database
CREATE DATABASE OlympicsDB;
GO

USE OlympicsDB;
GO

-- Create athlete_events table
CREATE TABLE athlete_events
(
    ID INT,
    Name VARCHAR(255),
    Sex CHAR(1),
    Age INT NULL,
    Height INT NULL,
    Weight INT NULL,
    Team VARCHAR(100),
    NOC VARCHAR(3),
    Games VARCHAR(20),
    Year INT,
    Season VARCHAR(10),
    City VARCHAR(100),
    Sport VARCHAR(100),
    Event VARCHAR(255),
    Medal VARCHAR(20) NULL
);

-- Create noc_regions table
CREATE TABLE noc_regions
(
    NOC VARCHAR(3),
    Region VARCHAR(100),
    Notes VARCHAR(100)
);