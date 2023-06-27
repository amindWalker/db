#!/bin/bash

psql -U freecodecamp -d periodic_table 1> stdout.txt 2> stderr.txt <<EOF
BEGIN;
SAVEPOINT unmodified_6262023_22_50;

-- Rename the weight column to atomic_mass
ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;

-- Rename the melting_point and boiling_point column to melting_point_celsius and boiling_point_celsius
ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;

SAVEPOINT renaming_tables_6262023_22_51;

-- Add the NOT NULL constraint to melting_point_celsius and boiling_point_celsius columns
ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;

-- Add the UNIQUE and NOT NULL constraints to the symbol and name columns in the elements table
ALTER TABLE elements ADD CONSTRAINT elements_symbol_unique UNIQUE (symbol);
ALTER TABLE elements ADD CONSTRAINT elements_name_unique UNIQUE (name);
ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
ALTER TABLE elements ALTER COLUMN name SET NOT NULL;

-- Set the atomic_number column from the properties table as a foreign key referencing the elements table
ALTER TABLE properties ADD CONSTRAINT properties_atomic_number_fk FOREIGN KEY (atomic_number) REFERENCES elements (atomic_number);

SAVEPOINT change_constraints_6262023_22_55;

-- Create the types table
CREATE TABLE types (type_id SERIAL PRIMARY KEY, type VARCHAR NOT NULL);

-- Populate the types table with distinct types from the properties table
INSERT INTO types (type) SELECT DISTINCT type FROM properties WHERE type IS NOT NULL;

-- Add the type_id foreign key column to the properties table and set the NOT NULL constraint
ALTER TABLE properties ADD COLUMN type_id INT NOT NULL DEFAULT 0;

-- Update the type_id column with the corresponding values from the types table
UPDATE properties SET type_id = types.type_id FROM types WHERE properties.type = types.type;

-- Confirm that all rows have non-null or 0 type_id values
UPDATE properties SET type_id = types.type_id FROM types WHERE properties.type = types.type AND properties.type_id IS NULL;

-- Add foreign key that references type_id
ALTER TABLE properties ADD CONSTRAINT properties_type_id_fk FOREIGN KEY (type_id) REFERENCES types (type_id);

SAVEPOINT link_type_id_6262023_22_57;

-- Capitalize the first letter of the symbol values in the elements table
UPDATE elements SET symbol = INITCAP(symbol);

-- Adjust the data type of the atomic_mass column to TEXT and remove trailing zeros with regular expression
ALTER TABLE properties ALTER COLUMN atomic_mass TYPE TEXT;
UPDATE properties SET atomic_mass = regexp_replace(atomic_mass, '(\.\d*?)0*$', '\1');

SAVEPOINT fix_type_and_column_6262023_22_58;

-- Add the element with atomic number 9 (Fluorine) to the elements table
INSERT INTO elements (atomic_number, name, symbol)
VALUES (9, 'Fluorine', 'F');

-- Add the corresponding properties for the element with atomic number 9
INSERT INTO properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id)
VALUES (9, 18.998, -220, -188.1, (SELECT type_id FROM types WHERE type = 'nonmetal'));

-- Add the element with atomic number 10 (Neon) to the elements table
INSERT INTO elements (atomic_number, name, symbol)
VALUES (10, 'Neon', 'Ne');

-- Add the corresponding properties for the element with atomic number 10
INSERT INTO properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id)
VALUES (10, 20.18, -248.6, -246.1, (SELECT type_id FROM types WHERE type = 'nonmetal'));

SAVEPOINT add_florine_and_neon_6262023_23_00;

-- Drop non existent atomic_number
DELETE FROM properties WHERE atomic_number = 1000;
DELETE FROM elements WHERE atomic_number = 1000;

-- Drop unnecessary column
ALTER TABLE properties DROP COLUMN type;

SAVEPOINT drop_incorrect_data_6272023_07_00;

COMMIT;
EOF
