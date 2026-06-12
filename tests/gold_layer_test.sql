/*
===============================================================================
Test Script : Gold Layer Data Quality Checks
===============================================================================

Purpose:
    This script performs data quality validation checks on Gold layer
    dimension and fact views.

    The objective is to ensure that the Gold layer contains accurate,
    complete, consistent, and business-ready data before it is consumed
    by reporting, analytics, and downstream applications.

Quality Checks:
    - Null value validation
    - Duplicate record detection
    - Primary key uniqueness checks
    - Referential integrity validation
    - Data completeness verification
    - Business rule validation
    - Record count reconciliation between layers

Usage:
    - Execute after Gold layer views are created.
    - Review any returned records as potential data quality issues.
    - A successful test should return zero records for exception checks.

Target Objects:
    - gold.dim_customers
    - gold.dim_products
    - gold.fact_sales

===============================================================================
*/

--========================================================================================
-- test case: customer dimenion quality check 
--========================================================================================

select distinct 
ci.cst_gndr,

la.gen,
case when ci.cst_gndr != 'n/a' then ci.cst_gndr
   else coalesce(la.gen,'n/a')
end new_gen
from silver.crm_cust_info as ci 
left join silver.erp_cust_az12 as la on ci.cst_key = la.cid  
left join silver.erp_loc_a101 as ce on ce.cid = ci.cst_key
order by 1,2

--==============================================================================================================================
-- test case: fact_sales check quality 
-- =============================================================================================================================

-- foreign key integration (dimesion )
select * from gold.fact_sales as f 

left join gold.dim_customers as c
on c.customer_key = f.customer_key
left join gold.dim_products as p on 
p.product_key = f.product_key 
where p.product_key is null 
