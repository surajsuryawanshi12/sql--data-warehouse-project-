/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================

Script Purpose:
    This script creates views for the Gold layer in the data warehouse.

    The Gold layer represents the final business-ready dimension and fact
    tables (Star Schema) used for reporting, analytics, and dashboarding.

    Each view performs transformations and combines data from the Silver layer
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
    
--=====================================================================================
*/

--=====================================================================================
-- create dimension : gold.dim_customers 
--=====================================================================================
drop view if exists gold.dim_customers 
 
create or replace view gold.dim_customers as 
select 
row_number() over(order by cst_id ) as customer_key,

ci.cst_id as customer_id,
ci.cst_key customer_number ,
ci.cst_firstname as first_name ,
ci.cst_lastname as last_name,
ci.cst_marital_status as marital_status,
ce.contry as country ,
case when ci.cst_gndr != 'n/a' then ci.cst_gndr
   else coalesce(la.gen,'n/a')
end gender,
la.bdate as birth_date,
ci.cst_create_date as create_date 
from silver.crm_cust_info as ci 
left join silver.erp_cust_az12 as la on ci.cst_key = la.cid  
left join silver.erp_loc_a101 as ce on ce.cid = ci.cst_key


--=====================================================================================
-- create dimension : gold.dim_products 
--=====================================================================================
drop view if exists gold.dim_products 
  
create  or replace view gold.dim_products  as 
select
row_number() over (order by prd_start_dt, pn.prd_key ),
pn.prd_id as product_id,
pn.prd_key as product_key, 
prd_nm product_name,
pn.cat_id category_id,
pd.cat as product_category,
pd.subcat as sub_category,
pd.maintenance as maintenace,
pn.prd_cost product_cost,
pn.prd_line product_line,
pn.prd_start_dt product_start_date
from silver.crm_prd_info pn
left join silver.erp_px_cat_g1v2 as pd on pd.id = pn.cat_id 
where prd_end_dt is null -- filter out all historricla data 


--=====================================================================================
-- create dimension : gold.fact_sales
--=====================================================================================
drop view if exists gold.fact_sales 
create or replace view gold.fact_sales as 
select 
sd.sls_ord_num as order_number,
pr.product_key,
cu.customer_key,
sd.sls_order_dt as order_date,
sd.sls_ship_dt as ship_date,
sd.sls_due_dt as due_date,
sd.sls_sales as sales_amount,
sd.sls_quantity as quntity,
sd.sls_price as price
from silver.crm_sales_details as sd
left join gold.dim_products pr on sd.sls_prd_key = pr.product_key
left join gold.dim_customers as cu on sd.sls_cust_id = cu.customer_id   


