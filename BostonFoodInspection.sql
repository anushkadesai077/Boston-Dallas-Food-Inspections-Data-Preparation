/* BostonFoodInspection.SQL - Creates the BOSTON FOOD INSPECTION schema */ 
/* Group 12 - Boston Food Inspection Dimensional Model */
/* All Rights Reserved with Group 12. */

raiserror('BEGINNING BostonFoodInspection.SQL...',1,1) with nowait
GO

if exists (select * from sysdatabases where name='bostonfoodinspection')
begin
  raiserror('DROPPING EXISTING bostonfoodinspection DATABSE...',0,1)
  DROP database bostonfoodinspection
end
GO

CHECKPOINT
GO

raiserror('CREATING bostonfoodinspection SCHEMA...',0,1)
GO

CREATE DATABASE bostonfoodinspection
GO

USE bostonfoodinspection
GO

if db_name() <> 'bostonfoodinspection'
   raiserror('ERROR IN BostonFoodInspection.SQL, ''USE bostonfoodinspection'' FAILED!!  KILLING THE SPID NOW.',22,127) with log
GO

raiserror('STARTING TABLE CREATION...',0,1)
GO

CREATE TABLE [DIM_Inspection] (
	[inspection_id] int NOT NULL,
	[result] varchar(500) NOT NULL,
	[resultdttm] datetime NOT NULL,
	[comments] varchar(2000) NOT NULL,
	PRIMARY KEY ([inspection_id])
);

CREATE TABLE [DIM_License] (
	[licenseno] int NOT NULL,
	[licstatus] varchar(100) NOT NULL,
	[licensecat] varchar(100) NOT NULL,
	[descript] varchar(500) NOT NULL,
	[issdttm] datetime NOT NULL,
	[expdttm] datetime NOT NULL,
	PRIMARY KEY ([licenseno])
);

CREATE TABLE [DIM_Location] (
	[AddressID] int NOT NULL,
	[address] varchar(100) NOT NULL,
	[city] varchar(50) NOT NULL,
	[state] varchar(50) NOT NULL,
	[zip] char(10) NOT NULL,
	[location] varchar(100) NOT NULL,
	PRIMARY KEY ([AddressId])
);

CREATE TABLE [DIM_Restaurant] (
	[BusinessID] int NOT NULL,
	[property_id] int NOT NULL,
	[businessname] varchar(100) NOT NULL,
	[dbaname] varchar(100) NOT NULL,
	[dayphn] char(20) NOT NULL,
	[AddressID] int NOT NULL,
	[legalowner] varchar(200) NOT NULL,
	[namefirst] varchar(100) NOT NULL,
	[namelast] varchar(100) NOT NULL,
	[licenseno] int NOT NULL,
	PRIMARY KEY ([BusinessID])
);

CREATE TABLE [DIM_ViolationStatus] (
	[violstatus_id] int NOT NULL,
	[violstatus] varchar(500) NOT NULL,
	[statusdate] date NOT NULL,
	PRIMARY KEY ([violstatus_id])
);

CREATE TABLE [DIM_Violation] (
	[violation_id] int NOT NULL,
	[violation] varchar(200) NOT NULL,
	[viollevel] varchar(200) NOT NULL,
	[violdesc] varchar(1000) NOT NULL,
	[violdttm] datetime NOT NULL,
	[violstatus_id] int NOT NULL,
	PRIMARY KEY ([violation_id])
);

CREATE TABLE [Fact_InspectionLeadToViolation] (
	[BusinessID] int NOT NULL,
	[inspection_id] int NOT NULL,
	[violation_id] int NOT NULL,
	PRIMARY KEY ([BusinessID], [inspection_id], [violation_id])
);

CREATE TABLE [Fact_RestaurantInspection] (
	[BusinessID] int NOT NULL,
	[inspection_id] int NOT NULL,
	PRIMARY KEY ([BusinessID], [inspection_id])
);

raiserror('SCHEMA CREATION COMPLETED SUCCESSFULLY...',0,1)
GO