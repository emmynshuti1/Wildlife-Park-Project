CREATE TABLE IF NOT EXISTS WildlifeImport (
    AnimalID TEXT PRIMARY KEY,
    AnimalName TEXT NOT NULL,
    Gender TEXT NOT NULL,
    YearOfArrival INTEGER NOT NULL,
    SpeciesID TEXT,
    SpeciesType TEXT NOT NULL,
    SpeciesGroup TEXT NOT NULL,
    Lifestyle TEXT NOT NULL,
    ConservationStatus TEXT NOT NULL,
    DietID TEXT NOT NULL,
    DietType TEXT NOT NULL,
    NoOfFeedsPerDay INTEGER NOT NULL,
    KeeperID TEXT NOT NULL,
    KeeperName TEXT NOT NULL,
    KeeperDoB TEXT NOT NULL,
    KeeperRank TEXT NOT NULL,
    EnclosureID TEXT NOT NULL,
    EnclosureType TEXT NOT NULL,
    EnclosureLocation TEXT NOT NULL
);

-- ------------------------------------------------------------
-- TABLE 1 of 5: Keepers
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Keepers (
    KeeperID    TEXT NOT NULL,
    KeeperName  TEXT NOT NULL,
    DateOfBirth TEXT NOT NULL,
    Rank        TEXT NOT NULL,
    CONSTRAINT pk_Keepers PRIMARY KEY (KeeperID),
    CONSTRAINT chk_Rank CHECK (Rank IN ('Senior', 'Standard', 'Junior'))
);

-- ------------------------------------------------------------
-- TABLE 2 of 5: Species
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Species (
    SpeciesID          TEXT NOT NULL,
    SpeciesType        TEXT NOT NULL,
    SpeciesGroup       TEXT NOT NULL,
    Lifestyle          TEXT NOT NULL,
    ConservationStatus TEXT NOT NULL,
    CONSTRAINT pk_Species PRIMARY KEY (SpeciesID),
    CONSTRAINT chk_SpeciesGroup CHECK (
        SpeciesGroup IN ('Mammal', 'Reptile', 'Bird')
    ),
    CONSTRAINT chk_Lifestyle CHECK (
        Lifestyle IN ('Solitary', 'Herd', 'Troop', 'Pride', 'Group', 'Social')
    ),
    CONSTRAINT chk_ConservationStatus CHECK (
        ConservationStatus IN (
            'Least Concern',
            'Vulnerable',
            'Threatened',
            'Endangered',
            'Critically Endangered'
        )
    )
);

-- ------------------------------------------------------------
-- TABLE 3 of 5: Diet
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Diet (
    DietID      TEXT    NOT NULL,
    DietType    TEXT    NOT NULL,
    FeedsPerDay INTEGER NOT NULL,
    CONSTRAINT pk_Diet         PRIMARY KEY (DietID),
    CONSTRAINT chk_DietType    CHECK (DietType IN ('Omnivore', 'Herbivore', 'Carnivore')),
    CONSTRAINT chk_FeedsPerDay CHECK (FeedsPerDay BETWEEN 1 AND 6)
);

-- ------------------------------------------------------------
-- TABLE 4 of 5: Enclosures
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Enclosures (
    EnclosureID   TEXT NOT NULL,
    EnclosureType TEXT NOT NULL,
    Location      TEXT NOT NULL,
    CONSTRAINT pk_Enclosures      PRIMARY KEY (EnclosureID),
    CONSTRAINT chk_EnclosureType  CHECK (
        EnclosureType IN ('Moat', 'Glass', 'Fence', 'Walled', 'Pen')
    )
);

-- ------------------------------------------------------------
-- TABLE 5 of 5: Animals
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Animals (
    AnimalID    TEXT    NOT NULL,
    AnimalName  TEXT    NOT NULL,
    Gender      TEXT    NOT NULL,
    YearArrived INTEGER NOT NULL,
    SpeciesID   TEXT    NOT NULL,
    DietID      TEXT    NOT NULL,
    KeeperID    TEXT    NOT NULL,
    EnclosureID TEXT    NOT NULL,
    CONSTRAINT pk_Animals   PRIMARY KEY (AnimalID),
    CONSTRAINT fk_Species   FOREIGN KEY (SpeciesID)
                            REFERENCES Species(SpeciesID),
    CONSTRAINT fk_Diet      FOREIGN KEY (DietID)
                            REFERENCES Diet(DietID),
    CONSTRAINT fk_Keeper    FOREIGN KEY (KeeperID)
                            REFERENCES Keepers(KeeperID),
    CONSTRAINT fk_Enclosure FOREIGN KEY (EnclosureID)
                            REFERENCES Enclosures(EnclosureID),
    CONSTRAINT chk_Gender   CHECK (Gender IN ('M', 'F')),
    CONSTRAINT chk_Year     CHECK (YearArrived >= 1900 AND YearArrived <= 2026)
);

-- ------------------------------------------------------------
-- INSERT: Keepers – 4 records 
-- ------------------------------------------------------------
INSERT OR IGNORE INTO Keepers (KeeperID, KeeperName, DateOfBirth, Rank) VALUES
    ('K1', 'Dave',   '18-06-64', 'Senior'),
    ('K2', 'Kayden', '21-01-85', 'Junior'),
    ('K3', 'Suki',   '08-09-98', 'Standard'),
    ('K4', 'Temi',   '16-04-00', 'Senior');

-- ------------------------------------------------------------
-- INSERT: Species – 17 unique species
-- ------------------------------------------------------------
INSERT OR IGNORE INTO Species (SpeciesID, SpeciesType, SpeciesGroup, Lifestyle, ConservationStatus) VALUES
    ('S3',  'Gorilla',        'Mammal',  'Troop',    'Threatened'),
    ('S4',  'Orang-utan',     'Mammal',  'Solitary', 'Critically Endangered'),
    ('S6',  'Rhinoceros',     'Mammal',  'Solitary', 'Critically Endangered'),
    ('S7',  'Crocodile',      'Reptile', 'Social',   'Vulnerable'),
    ('S8',  'Elephant',       'Mammal',  'Herd',     'Threatened'),
    ('S9',  'Armadillo',      'Mammal',  'Solitary', 'Endangered'),
    ('S10', 'Giant Tortoise', 'Reptile', 'Herd',     'Vulnerable'),
    ('S11', 'Lion',           'Mammal',  'Pride',    'Vulnerable'),
    ('S12', 'Raccoon',        'Mammal',  'Solitary', 'Least Concern'),
    ('S13', 'Leopard',        'Mammal',  'Solitary', 'Threatened'),
    ('S14', 'Chinchilla',     'Mammal',  'Solitary', 'Endangered'),
    ('S15', 'Tamarin',        'Mammal',  'Troop',    'Critically Endangered'),
    ('S16', 'Penguin',        'Bird',    'Group',    'Threatened'),
    ('S17', 'Sea Turtle',     'Reptile', 'Solitary', 'Endangered'),
    ('S18', 'Sloth',          'Mammal',  'Solitary', 'Endangered'),
    ('S19', 'Kakapo',         'Bird',    'Solitary', 'Endangered'),
    ('S20', 'Hippopotamus',   'Mammal',  'Herd',     'Vulnerable');

-- ------------------------------------------------------------
-- INSERT: Diet – 3 records 
-- ------------------------------------------------------------
INSERT OR IGNORE INTO Diet (DietID, DietType, FeedsPerDay) VALUES
    ('D1', 'Omnivore',  6),
    ('D2', 'Herbivore', 6),
    ('D3', 'Carnivore', 4);

-- ------------------------------------------------------------
-- INSERT: Enclosures – 5 records
-- ------------------------------------------------------------
INSERT OR IGNORE INTO Enclosures (EnclosureID, EnclosureType, Location) VALUES
    ('E1', 'Moat',   'North'),
    ('E2', 'Glass',  'North'),
    ('E3', 'Fence',  'South'),
    ('E4', 'Walled', 'South'),
    ('E5', 'Pen',    'South');

-- ------------------------------------------------------------
-- INSERT: Animals – all 46 records 
-- ------------------------------------------------------------
INSERT OR IGNORE INTO Animals(AnimalID, AnimalName, Gender, YearArrived, SpeciesID, DietID, KeeperID, EnclosureID) VALUES
    ('A3',  'Geoffrey', 'M', 2018, 'S3',  'D1', 'K1', 'E2'),
    ('A4',  'Oliver',   'M', 2011, 'S4',  'D1', 'K1', 'E1'),
    ('A6',  'Roger',    'M', 2000, 'S6',  'D2', 'K2', 'E3'),
    ('A7',  'Clive',    'M', 2013, 'S7',  'D3', 'K2', 'E3'),
    ('A8',  'Eddie',    'M', 2016, 'S8',  'D2', 'K2', 'E4'),
    ('A9',  'Arnie',    'M', 2012, 'S9',  'D1', 'K2', 'E5'),
    ('A10', 'Gavin',    'M', 2015, 'S10', 'D2', 'K2', 'E5'),
    ('A11', 'Lucy',     'F', 2011, 'S11', 'D3', 'K3', 'E4'),
    ('A12', 'Robbie',   'M', 2017, 'S12', 'D1', 'K3', 'E5'),
    ('A13', 'Laura',    'F', 2018, 'S13', 'D3', 'K3', 'E3'),
    ('A14', 'Casey',    'F', 2013, 'S14', 'D2', 'K3', 'E5'),
    ('A15', 'Trevor',   'M', 2000, 'S15', 'D1', 'K3', 'E3'),
    ('A16', 'Polly',    'F', 2017, 'S16', 'D1', 'K4', 'E2'),
    ('A17', 'Sarah',    'F', 2015, 'S17', 'D1', 'K4', 'E2'),
    ('A18', 'Stan',     'M', 2018, 'S18', 'D1', 'K4', 'E3'),
    ('A19', 'Kara',     'F', 2001, 'S19', 'D2', 'K4', 'E4'),
    ('A20', 'Henry',    'M', 2003, 'S20', 'D2', 'K4', 'E3'),
    ('A22', 'Eliza',    'F', 2003, 'S8',  'D2', 'K2', 'E4'),
    ('A23', 'George',   'M', 2000, 'S3',  'D1', 'K1', 'E2'),
    ('A24', 'Carlos',   'M', 2017, 'S7',  'D3', 'K2', 'E3'),
    ('A25', 'Lenie',    'F', 2015, 'S11', 'D3', 'K3', 'E4'),
    ('A26', 'Roberta',  'F', 2018, 'S12', 'D1', 'K3', 'E5'),
    ('A27', 'Peter',    'M', 2001, 'S16', 'D1', 'K4', 'E2'),
    ('A28', 'Percy',    'M', 2003, 'S16', 'D1', 'K4', 'E2'),
    ('A29', 'Petal',    'F', 2003, 'S16', 'D1', 'K4', 'E2'),
    ('A30', 'Sammie',   'F', 2013, 'S18', 'D1', 'K4', 'E3'),
    ('A31', 'Lionel',   'M', 2016, 'S11', 'D3', 'K3', 'E4'),
    ('A32', 'Gertrude', 'F', 2012, 'S3',  'D1', 'K1', 'E2'),
    ('A33', 'Olive',    'F', 2015, 'S4',  'D1', 'K1', 'E1'),
    ('A34', 'Ossie',    'M', 2011, 'S4',  'D1', 'K1', 'E1'),
    ('A35', 'Lena',     'F', 2017, 'S13', 'D3', 'K3', 'E3'),
    ('A36', 'Rommy',    'F', 2018, 'S6',  'D2', 'K2', 'E3'),
    ('A37', 'Tulisa',   'F', 2013, 'S15', 'D1', 'K3', 'E3'),
    ('A38', 'Chrissie', 'F', 2000, 'S7',  'D3', 'K2', 'E3'),
    ('A39', 'Elsie',    'F', 2017, 'S8',  'D2', 'K2', 'E4'),
    ('A40', 'Colin',    'M', 2015, 'S7',  'D3', 'K2', 'E3'),
    ('A41', 'Hattie',   'F', 2018, 'S20', 'D2', 'K4', 'E3'),
    ('A42', 'Robbie',   'M', 2017, 'S6',  'D2', 'K2', 'E3'),
    ('A43', 'Luna',     'F', 2018, 'S11', 'D3', 'K3', 'E4'),
    ('A44', 'Rebbi',    'M', 2013, 'S12', 'D1', 'K3', 'E5'),
    ('A45', 'Penni',    'F', 2000, 'S16', 'D1', 'K4', 'E2'),
    ('A46', 'Emmie',    'F', 2000, 'S8',  'D2', 'K2', 'E4'),
    ('A47', 'Lope',     'M', 2017, 'S13', 'D3', 'K3', 'E3'),
    ('A48', 'Cressida', 'F', 2015, 'S14', 'D2', 'K3', 'E5'),
    ('A49', 'Tommy',    'M', 2018, 'S15', 'D1', 'K3', 'E3'),
    ('A50', 'Gareth',   'M', 2017, 'S3',  'D1', 'K1', 'E2');

SELECT 'Keepers'    AS TableName, COUNT(*) AS RecordCount FROM Keepers
UNION ALL
SELECT 'Species',    COUNT(*) FROM Species
UNION ALL
SELECT 'Diet',       COUNT(*) FROM Diet
UNION ALL
SELECT 'Enclosures', COUNT(*) FROM Enclosures
UNION ALL
SELECT 'Animals',    COUNT(*) FROM Animals;

-- Step 1a: Unique Keepers from WildlifeImport table
INSERT OR IGNORE INTO Keepers (KeeperID, KeeperName, DateOfBirth, Rank)
SELECT DISTINCT
    'Keeper ID',
    'Keeper name',
    'Keeper DoB',
    'Keeper rank'
FROM WildlifeImport
WHERE 'Keeper ID' IS NOT NULL;

-- Step 1b: Unique Species from WildlifeImport table
INSERT OR IGNORE INTO Species
    (SpeciesID, SpeciesType, SpeciesGroup, Lifestyle, ConservationStatus)
SELECT DISTINCT
    'Species ID',
    'Species type',
    'Species group',
    'Lifestyle',
    'Conservation Status'
FROM WildlifeImport
WHERE 'Species ID' IS NOT NULL;

-- Step 1c: Unique Diet records from WildlifeImport table
INSERT OR IGNORE INTO Diet (DietID, DietType, FeedsPerDay)
SELECT DISTINCT
    'Diet ID',
    'Diet type',
    'No of feeds per day'
FROM WildlifeImport
WHERE 'Diet ID' IS NOT NULL;

-- Step 1d: Unique Enclosures from WildlifeImport table
INSERT OR IGNORE INTO Enclosures (EnclosureID, EnclosureType, Location)
SELECT DISTINCT
    'Enclosure ID',
    'Enclosure type',
    'Enclosure location'
FROM WildlifeImport
WHERE 'Enclosure ID' IS NOT NULL;

-- Confirmation of import record counts
SELECT 'Keepers'    AS TableName, COUNT(*) AS RecordCount FROM Keepers
UNION ALL
SELECT 'Species',    COUNT(*) FROM Species
UNION ALL
SELECT 'Diet',       COUNT(*) FROM Diet
UNION ALL
SELECT 'Enclosures', COUNT(*) FROM Enclosures
UNION ALL
SELECT 'Animals',    COUNT(*) FROM Animals;

SELECT
    'Animal ID',
    'Animal Name',
    'Gender',
    'Year Arrived',
    'SpeciesID',
    'DietID',
    'KeeperID',
    'EnclosureID'
FROM     WildlifeImport sc
JOIN     Species      ON 'Species type'     = Species.SpeciesType
JOIN     Diet         ON 'Diet ID'          = Diet.DietID
JOIN     Keepers      ON 'Keeper ID'        = Keepers.KeeperID
JOIN     Enclosures   ON 'Enclosure ID'     = Enclosures.EnclosureID;

-- Full join verification – Animals with all related details
SELECT
    a.AnimalID,
    a.AnimalName,
    a.Gender,
    a.YearArrived,
    s.SpeciesType,
    s.ConservationStatus,
    d.DietType,
    d.FeedsPerDay,
    k.KeeperName,
    k.Rank,
    e.EnclosureType,
    e.Location
FROM     Animals    a
JOIN     Species    s  ON a.SpeciesID   = s.SpeciesID
JOIN     Diet       d  ON a.DietID      = d.DietID
JOIN     Keepers    k  ON a.KeeperID    = k.KeeperID
JOIN     Enclosures e  ON a.EnclosureID = e.EnclosureID
ORDER BY a.AnimalID;


SELECT
    KeeperID,
    KeeperName,
    Rank
FROM   Keepers
ORDER BY KeeperName ASC;

SELECT
    e.EnclosureType,
    COUNT(a.AnimalID) AS AnimalCount
FROM     Animals    a
JOIN     Enclosures e  ON a.EnclosureID = e.EnclosureID
GROUP BY e.EnclosureType
ORDER BY AnimalCount DESC;

SELECT
    KeeperName,
    DateOfBirth
FROM   Keepers
WHERE  Rank = :keeper_rank;

SELECT
    KeeperName,
    DateOfBirth
FROM   Keepers
WHERE  Rank = 'Senior';

SELECT
    KeeperName,
    DateOfBirth
FROM   Keepers
WHERE  Rank = 'Junior';

SELECT
    KeeperName,
    DateOfBirth
FROM   Keepers
WHERE  Rank = 'Standard';

SELECT
    s.SpeciesType,
    COUNT(a.AnimalID) AS AnimalCount
FROM     Animals a
JOIN     Species s  ON a.SpeciesID = s.SpeciesID
JOIN     Diet    d  ON a.DietID    = d.DietID
WHERE    d.FeedsPerDay > 3
GROUP BY s.SpeciesType
ORDER BY AnimalCount DESC;

SELECT
    a.AnimalID,
    a.YearArrived,
    a.SpeciesID,
    a.KeeperID
FROM     Animals a
JOIN     Diet    d  ON a.DietID    = d.DietID
JOIN     Species s  ON a.SpeciesID = s.SpeciesID
WHERE    d.DietType           = 'Omnivore'
  AND    s.ConservationStatus = 'Critically Endangered';

CREATE TRIGGER IF NOT EXISTS trg_ValidateArrivalYear
BEFORE INSERT ON Animals
WHEN NEW.YearArrived > CAST(strftime('%Y', 'now') AS INTEGER)
BEGIN
  SELECT RAISE(ABORT, 'Error: YearArrived cannot be in future.');
END;

-- TESTING the trigger – this INSERT must be REJECTED
INSERT INTO Animals
    (AnimalID, AnimalName, Gender, YearArrived, SpeciesID, DietID, KeeperID, EnclosureID)
VALUES
    ('A99', 'TestAnimal', 'M', 2099, 'S3', 'D1', 'K1', 'E1');

-- Confirm the trigger did not insert the row:
SELECT * FROM Animals WHERE AnimalID = 'A99';

CREATE VIEW IF NOT EXISTS vw_KeeperWorkload AS
SELECT
    k.KeeperID,
    k.KeeperName,
    k.Rank,
    COUNT(a.AnimalID) AS AnimalsAssigned
FROM     Keepers k
LEFT JOIN Animals a  ON k.KeeperID = a.KeeperID
GROUP BY k.KeeperID, k.KeeperName, k.Rank
ORDER BY AnimalsAssigned DESC;

-- Querying the view 
SELECT * FROM vw_KeeperWorkload;

-- Part A: Full animal details grouped by keeper name
SELECT
    k.KeeperName,
    a.AnimalID,
    a.AnimalName,
    a.Gender,
    a.YearArrived,
    s.SpeciesType,
    e.EnclosureType
FROM     Animals    a
JOIN     Keepers    k  ON a.KeeperID    = k.KeeperID
JOIN     Species    s  ON a.SpeciesID   = s.SpeciesID
JOIN     Enclosures e  ON a.EnclosureID = e.EnclosureID
WHERE    k.KeeperName IN ('Dave', 'Temi')
ORDER BY k.KeeperName, a.AnimalName;

-- Part B: Number of animals per keeper
SELECT
    k.KeeperName,
    COUNT(a.AnimalID) AS AnimalCount
FROM     Animals a
JOIN     Keepers k  ON a.KeeperID = k.KeeperID
WHERE    k.KeeperName IN ('Dave', 'Temi')
GROUP BY k.KeeperName;

-- Part C: Overall total for both keepers combined
SELECT
    COUNT(a.AnimalID) AS TotalAnimals
FROM     Animals a
JOIN     Keepers k  ON a.KeeperID = k.KeeperID
WHERE    k.KeeperName IN ('Dave', 'Temi');

INSERT INTO Animals
    (AnimalID, AnimalName, Gender, YearArrived, SpeciesID, DietID, KeeperID, EnclosureID)
VALUES
    ('T03', 'TestFuture', 'M', 2019, 'S3', 'D1', 'K1', 'E1');

INSERT INTO Animals
    (AnimalID, AnimalName, Gender, YearArrived, SpeciesID, DietID, KeeperID, EnclosureID)
VALUES
    ('T04', 'TestOld', 'M', 1900, 'S3', 'D1', 'K1', 'E1');

SELECT * FROM Animals WHERE AnimalID = 'T04';

DELETE FROM Animals WHERE AnimalID = 'T04';

INSERT INTO Animals
    (AnimalID, AnimalName, Gender, YearArrived, SpeciesID, DietID, KeeperID, EnclosureID)
VALUES
    ('T05', 'TestCurrent', 'M', 2026, 'S3', 'D1', 'K1', 'E1');

SELECT * FROM Animals WHERE AnimalID = 'T05';

-- Clean up test record
DELETE FROM Animals WHERE AnimalID = 'T05';

INSERT INTO Diet (DietID, DietType, FeedsPerDay)
VALUES ('T11', 'Herbivore', 2);

INSERT INTO Diet (DietID, DietType, FeedsPerDay)
VALUES ('T12', 'Herbivore', 1);

SELECT * FROM Diet WHERE DietID = 'T12';

DELETE FROM Diet WHERE DietID = 'T12';

INSERT INTO Animals
    (AnimalID, AnimalName, Gender, YearArrived, SpeciesID, DietID, KeeperID, EnclosureID)
VALUES
    ('T14', 'TriggerTest', 'F', 2005, 'S3', 'D1', 'K1', 'E1');

-- Step 1 – WITHOUT foreign key enforcement (shows the problem)
PRAGMA foreign_keys = OFF;

DELETE FROM Keepers WHERE KeeperID = 'K1';

SELECT * FROM keepers;
-- Restore deleted keeper so the DB is consistent
INSERT INTO Keepers VALUES ('K1', 'Dave', '18-06-64', 'Senior');

SELECT * FROM keepers;

PRAGMA foreign_keys = OFF;

PRAGMA foreign_keys = OFF;

INSERT INTO Animals
    (AnimalID, AnimalName, Gender, YearArrived, SpeciesID, DietID, KeeperID, EnclosureID)
VALUES
    ('T16', 'InvalidKeeper', 'M', 2020, 'S3', 'D1', 'K99', 'E1');