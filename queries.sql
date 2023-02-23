/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016/01/01' and '2019/12/31';
SELECT name from animals WHERE neutered = TRUE and escape_attempts < 3;
SELECT date_of_birth from animals WHERE name = 'Agumon' OR name =  'Pikachu' ;
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = TRUE;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Setting the species column to unspecified */

-- start a transaction
BEGIN TRANSACTION;

-- Verify that change was made
SELECT * FROM animals;

-- Then roll back the change
ROLLBACK;

-- Verify that species columns went back to the state before transaction.
SELECT * FROM animals;

/* Adding animal species*/

-- Start transaction
BEGIN TRANSACTION;

-- Setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Setting the species column to pokemon for all animals that don't have species already set.
Update animals SET species = 'pokemon' WHERE species IS NULL;

--Commit the transaction.
COMMIT;

-- Verify that change was made and persists after commit.
SELECT * FROM animals;

/* Deleting all records*/

-- Start transaction
BEGIN TRANSACTION;

-- Deletre all records
DELETE FROM animals;

-- Then roll back the change
ROLLBACK;

-- Verify the result
SELECT * FROM animals;

/* Savepoint */

-- Start transaction
BEGIN TRANSACTION;

-- Delete animals born after 1 jan 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Making savepoint
SAVEPOINT s1;

-- updating the weight 
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to savepoint
ROLLBACK TO s1;

-- updating the weight 
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Commit changes
COMMIT

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth 
BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;
