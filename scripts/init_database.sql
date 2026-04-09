/*
=============================================================
Initialize Database and Schema (PostgreSQL)
=============================================================

Purpose:
    - Create a new database for the project
    - Create required schema for data warehouse

Note:
    - Run CREATE DATABASE separately (outside transaction)
*/

-- STEP 1: Create Database (Run this separately in PostgreSQL)
CREATE DATABASE datawarehouseanalytics;

-- ============================================
-- STEP 2: Connect to Database (psql only)
-- \c datawarehouseanalytics
-- ============================================

-- STEP 3: Create Schema
CREATE SCHEMA gold;
create schema silver;

