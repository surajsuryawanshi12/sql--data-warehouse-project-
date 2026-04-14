/*
=============================================================
Procedure: bronze.load_bronze
=============================================================
Purpose:
    - Reset (truncate) all Bronze layer tables
    - Track execution start and end time
    - Log total execution duration
    - Handle errors gracefully

Usage:
    CALL bronze.load_bronze();

Notes:
    - Data import is handled manually via pgAdmin
    - This procedure prepares tables for fresh data load
*/

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
BEGIN

    -- Start time
    start_time := NOW();
    RAISE NOTICE 'Process started at: %', start_time;
 
    -- Truncate Bronze tables
    TRUNCATE TABLE 
        bronze.crm_cust_info,
        bronze.crm_prd_info,
        bronze.crm_sales_details;

    RAISE NOTICE 'Tables truncated successfully';

    -- End time
    end_time := NOW();
    RAISE NOTICE 'Process ended at: %', end_time;

    -- Duration
    RAISE NOTICE 'Total time: %', end_time - start_time;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error: %', SQLERRM;
END;
$$;
