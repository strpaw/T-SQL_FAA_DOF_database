/**
DDL - Data Definition Langues, creates tables
NOTE: It is not created in the most efficent way, its purpose rather is to show how to create
tables, foreign key references etc.
**/

-- Country, states 
CREATE TABLE tblCtryState (
	OASCode NCHAR(2) PRIMARY KEY,
	Name    NVARCHAR(75) NOT NULL
);

-- Obstruction verification status
CREATE TABLE tblVerifStat (
	VerifStatCode NCHAR(1) PRIMARY KEY,
	VerifStatDesc NVARCHAR(10) NOT NULL
);

-- Type of lighting
CREATE TABLE tblLighting (
	LightCode NCHAR(1) PRIMARY KEY,
	LightDesc NVARCHAR(40) NOT NULL
);

-- Type of marking
CREATE TABLE tblMarking (
	MarkCode NCHAR(1) PRIMARY KEY,
	MarkDesc NVARCHAR(40) NOT NULL
);


-- Vertical accuracy
CREATE TABLE tblVertAcc (
	VAccCode NCHAR(1) PRIMARY KEY,
	VAccTol  NVARCHAR(7) NOT NULL,
	VAccUOM  NVARCHAR(7) NOT NULL
);

-- Horizontal accuracy
CREATE TABLE tblHorAcc (
	HAccCode NCHAR(1) PRIMARY KEY,
	HAccTol FLOAT NOT NULL,
	HAccUOM NVARCHAR(7) NOT NULL
);

-- Obstruction data
CREATE TABLE tblObstruction (
	ID 			INT PRIMARY KEY IDENTITY(1,1),
	ObsNumber   NCHAR(11) NOT NULL,
	VerifStat   NCHAR(1) NOT NULL REFERENCES tblVerifStat,
	CtryStateId NCHAR(2) NOT NULL REFERENCES tblCtryState,
	CityName    NVARCHAR(20) NULL,
	LatDMS      NCHAR(12) NOT NULL,
	LonDMS      NCHAR(13) NOT NULL,
	ObsType     NVARCHAR(20) NOT NULL,
	AglHgt      INT NOT NULL,
	AmslHgt     INT NOT NULL,
	HAcc        NCHAR(1) NOT NULL REFERENCES tblHorAcc,
	VAcc        NCHAR(1) NOT NULL REFERENCES tblVertAcc,
	MarkType    NCHAR(1) NOT NULL REFERENCES tblMarking,
	LightType   NCHAR(1) NOT NULL REFERENCES tblLighting,
	LastUpdate  DATETIME NOT NULL DEFAULT GETDATE()        
);