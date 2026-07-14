-- ============================================
-- Olympics SQL Project
-- Import_Data.sql
-- ============================================

USE OlympicsDB;

-- Import athlete_events.csv

BULK INSERT athlete_events
FROM 'C:\SQLData\athlete_events.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);


-- Import noc_regions.csv

BULK INSERT noc_regions
FROM 'C:\SQLData\noc_regions.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
