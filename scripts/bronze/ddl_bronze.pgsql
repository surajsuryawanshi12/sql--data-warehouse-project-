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

    -- Your main logic
     TRUNCATE TABLE 
        bronze.crm_cust_info,
        bronze.crm_prd_info,
        bronze.crm_sales_details;

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
