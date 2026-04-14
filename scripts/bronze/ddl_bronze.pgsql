/*
=============================================================
Load Data into Bronze Layer (PostgreSQL)
=============================================================

Method Used:
    pgAdmin Import/Export Tool (GUI-based)

Steps:
    1. Right-click table
    2. Select Import/Export Data
    3. Choose CSV file
    4. Settings:
        - Format: CSV
        - Header: TRUE
        - Encoding: UTF-8
        - Delimiter: ,

Note:
    COPY works only if PostgreSQL server has file access.
*/
/*
raise notice '============================================================='
 raise notice 'Create Bronze Layer Tables (PostgreSQL)'
raise notice '============================================================='
*/

-- Create Schema
CREATE SCHEMA IF NOT EXISTS bronze;

raise notice '========================='
raise notice 'CRM TABLES';
raise notice' ========================='

CREATE TABLE IF NOT EXISTS bronze.crm_cust_info (
    cst_id INTEGER,
    cst_key INTEGER,
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_marital_status VARCHAR(50),
    cst_gndr VARCHAR(10),
    cst_create_date DATE
);

CREATE TABLE IF NOT EXISTS bronze.crm_prd_info (
    prd_id INTEGER,
    prd_key INTEGER,
    prd_name VARCHAR(100),
    prd_cost INTEGER,
    prd_line VARCHAR(50),
    prd_start_date DATE
);

CREATE TABLE IF NOT EXISTS bronze.crm_sales_details (
    order_number VARCHAR(50),
    product_key INTEGER,
    customer_key INTEGER,
    order_date DATE,
    shipping_date DATE,
    due_date DATE,
    sales_amount INTEGER,
    quantity INTEGER,
    price INTEGER
);
raise notice '========================='
raise notice 'ERP TABLES';
raise notice' ========================='

CREATE TABLE IF NOT EXISTS bronze.erp_cust_az12 (
    cid INTEGER,
    bdate DATE,
    gen VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS bronze.erp_loc_a101 (
    cid INTEGER,
    cntry VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS bronze.erp_px_cat_g1v2 (
    id INTEGER,
    cat VARCHAR(50),
    subcat VARCHAR(50),
    maintenance VARCHAR(50)
);
