CREATE DATABASE FailSafeIT_Inlamning;
GO

USE FailSafeIT_Inlamning;
GO

DROP TABLE IF EXISTS Uppdrag;
DROP TABLE IF EXISTS Konsulter;
DROP TABLE IF EXISTS Kunder;
GO

CREATE TABLE Kunder ( 
    Organisationsnummer NVARCHAR(50) PRIMARY KEY, 
    Foretagsnamn NVARCHAR(150) NOT NULL, 
    Epost NVARCHAR(150), 
    Telefonnummer NVARCHAR(50)
); 
GO 

CREATE TABLE Konsulter ( 
    Personnummer NVARCHAR(50) PRIMARY KEY, 
    Namn NVARCHAR(50) NOT NULL,
    Timpris DECIMAL(10, 2) NOT NULL,
    Specialist NVARCHAR(100)
); 
GO 

CREATE TABLE Uppdrag (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Startdatum DATE NOT NULL, 
    Slutdatum DATE, 
    Rollbeskrivning NVARCHAR(MAX),
    Organisationsnummer NVARCHAR(50), 
    Personnummer NVARCHAR(50), 
    CONSTRAINT FK_Uppdrag_Kunder FOREIGN KEY (Organisationsnummer) REFERENCES Kunder(Organisationsnummer), 
    CONSTRAINT FK_Uppdrag_Konsulter FOREIGN KEY (Personnummer) REFERENCES Konsulter(Personnummer) 
); 
GO 

INSERT INTO Kunder (Organisationsnummer, Foretagsnamn, Epost, Telefonnummer) VALUES
('556677-8899', 'TechSolutions AB', 'kontakt@techsolutions.se', '08-123 45 67'),
('552233-4455', 'Nordic Data AB', 'info@nordicdata.se', '031-987 65 43'),
('559988-7766', 'SecureCloud Sweden', 'support@securecloud.se', '070-112 23 34');
GO

INSERT INTO Konsulter (Personnummer, Namn, Timpris, Specialist) VALUES
('850101-1234', 'Anna Lindström', 1250.00, 'Cybersecurity'),
('900512-5678', 'Johan Berg', 1100.00, 'DevOps'),
('781224-9012', 'Maria Ek', 1400.00, 'Cloud Architecture');
GO

INSERT INTO Uppdrag (Startdatum, Slutdatum, Rollbeskrivning, Organisationsnummer, Personnummer) VALUES
('2026-03-01', '2026-06-30', 'Säkerhetsgranskning av molntjänst', '556677-8899', '850101-1234'),
('2026-03-15', NULL, 'Implementering av CI/CD-pipeline', '552233-4455', '900512-5678'),
('2026-04-01', '2026-05-15', 'Arkitekturgenomgång för databas', '559988-7766', '781224-9012'),
('2026-05-01', NULL, 'Penetrationstestning', '556677-8899', '850101-1234'),
('2026-06-01', '2026-08-31', 'Migration till molnet', '552233-4455', '781224-9012');
GO

-- ==========================================================================================================
-- SQL-Frågorna
-- ==========================================================================================================

-- Svar på fråga A nedan:
SELECT *  
FROM Konsulter 
WHERE Timpris > 1200 
ORDER BY Timpris DESC; 
GO 

-- Svar på fråga B nedan:
SELECT 
    U.Id AS UppdragsID, 
    K.Foretagsnamn, 
    Ko.Namn AS Konsultnamn, 
    U.Startdatum, 
    U.Slutdatum, 
    U.Rollbeskrivning
FROM Uppdrag U 
    JOIN Kunder K ON U.Organisationsnummer = K.Organisationsnummer 
    JOIN Konsulter Ko ON U.Personnummer = Ko.Personnummer; 
GO 

-- Svar på fråga C nedan:
SELECT 
    K.Foretagsnamn,    
    COUNT(U.Id) AS AntalUppdrag 
FROM Kunder K 
    LEFT JOIN Uppdrag U ON K.Organisationsnummer = U.Organisationsnummer  
GROUP BY K.Foretagsnamn; 
GO

-- Svar på fråga D nedan:
UPDATE Konsulter 
SET Timpris = 1350.00 
WHERE Personnummer = '900512-5678';
GO

-- Svar på fråga E nedan:
DELETE FROM Kunder
WHERE Organisationsnummer = '559988-7766' 
    AND Organisationsnummer NOT IN (SELECT Organisationsnummer FROM Uppdrag);
GO