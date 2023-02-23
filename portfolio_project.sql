-- kill other connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'average_joes' AND pid <> pg_backend_pid();
-- (re)create the database
DROP DATABASE IF EXISTS average_joes;
CREATE DATABASE average_joes;
-- connect via psql
\c average_joes

-- database configuration
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;

---
--- START FRESH
---

DROP TABLE IF EXISTS 
    gym_locations, amenities, membership_levels, gym_members, gym_trainers, access_logs CASCADE;

---
--- CREATE tables
---

-- Create table for gym members
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    join_date DATE NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20)
);

-- Create table for gym locations
CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(10) NOT NULL
);

-- Create table for membership levels
CREATE TABLE membership_levels (
    level_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    tier VARCHAR(50),
    description TEXT,
    access_all_locations BOOLEAN NOT NULL
);

-- Create table for membership
CREATE TABLE membership (
    membership_id INT PRIMARY KEY,
    member_id INT NOT NULL,
    level_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    location_id INT NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (level_id) REFERENCES membership_levels(level_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Create table for classes
CREATE TABLE classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    instructor_id INT NOT NULL,
    location_id INT NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES trainers(trainer_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Create table for personal trainers
CREATE TABLE trainers (
    trainer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialty VARCHAR(50)
);

-- Create table for equipment
CREATE TABLE equipment (
    equipment_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(50),
    purchase_date DATE,
    location_id INT NOT NULL,
    is_working BOOLEAN,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Create table for amenities
CREATE TABLE amenities (
    amenity_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(50),
    location_id INT NOT NULL,
    level_id INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id),
    FOREIGN KEY (level_id) REFERENCES membership_levels(level_id)
);

-- Create table for amenity access logs
CREATE TABLE amenity_access_logs (
    log_id INT PRIMARY KEY,
    membership_id INT NOT NULL,
    amenity_id INT NOT NULL,
    access_time TIMESTAMP NOT NULL,
    FOREIGN KEY (membership_id) REFERENCES membership(membership_id),
    FOREIGN KEY (amenity_id) REFERENCES amenities(amenity_id)
);