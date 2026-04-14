/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/



CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN


    DECLARE @start_time DATETIME, @end_time DATETIME;
    DECLARE @total_start_time DATETIME, @total_end_time DATETIME;


    BEGIN TRY
    SET @total_start_time = GETDATE();

        PRINT '===============================';
        PRINT 'Loading data into bronze layer';
        PRINT '===============================';


        PRINT '-------------------------------';
        PRINT 'Loading CRM tables';
        PRINT '-------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info; -- Clear existing data from the table

        PRINT '>> Inserting data into table: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM '/var/data/DWH_project/Data_sources/source_crm/cust_info.csv'
        WITH (
            FIRSTROW = 2, -- Skip the header row, data starts from the second row
            FIELDTERMINATOR = ',',-- Specify the field delimiter (comma in this case)
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Time taken to load data into bronze.crm_cust_info: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '--------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info; -- Clear existing data from the table

        PRINT '>> Inserting data into table: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM '/var/data/DWH_project/Data_sources/source_crm/prd_info.csv'
        WITH (
            FIRSTROW = 2, -- Skip the header row, data starts from the second row
            FIELDTERMINATOR = ',',-- Specify the field delimiter (comma in this case)
            TABLOCK
        ); SET @end_time = GETDATE();
        PRINT '>> Time taken to load data into bronze.crm_prd_info: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '--------------------------------';       


        SET @start_time = GETDATE();
        PRINT '>> Truncating table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details; -- Clear existing data from the table

        PRINT '>> Inserting data into table: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM '/var/data/DWH_project/Data_sources/source_crm/sales_details.csv'
        WITH (
            FIRSTROW = 2, -- Skip the header row, data starts from the second row
            FIELDTERMINATOR = ',',-- Specify the field delimiter (comma in this case)
            TABLOCK
        ); SET @end_time = GETDATE();
        PRINT '>> Time taken to load data into bronze.crm_sales_details: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '--------------------------------';
        


        PRINT '-------------------------------';
        PRINT 'Loading ERP tables';
        PRINT '-------------------------------';



        SET @start_time = GETDATE();
        PRINT '>> Truncating table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12; -- Clear existing data from the table

        PRINT '>> Inserting data into table: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM '/var/data/DWH_project/Data_sources/source_erp/cust_az12.csv'
        WITH (
            FIRSTROW = 2, -- Skip the header row, data starts from the second row
            FIELDTERMINATOR = ',',-- Specify the field delimiter (comma in this case)
            TABLOCK
        ); SET @end_time = GETDATE();
        PRINT '>> Time taken to load data into bronze.erp_cust_az12: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '--------------------------------';



        SET @start_time = GETDATE();
        PRINT '>> Truncating table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101; -- Clear existing data from the table

        PRINT '>> Inserting data into table: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM '/var/data/DWH_project/Data_sources/source_erp/loc_a101.csv'
        WITH (
            FIRSTROW = 2, -- Skip the header row, data starts from the second row
            FIELDTERMINATOR = ',',-- Specify the field delimiter (comma in this case)
            TABLOCK
        ); SET @end_time = GETDATE();
        PRINT '>> Time taken to load data into bronze.erp_loc_a101: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '--------------------------------';   

    
        SET @start_time = GETDATE();
        PRINT '>> Truncating table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2; -- Clear existing data from the table

        PRINT '>> Inserting data into table: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM '/var/data/DWH_project/Data_sources/source_erp/px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2, -- Skip the header row, data starts from the second row
            FIELDTERMINATOR = ',',-- Specify the field delimiter (comma in this case)
            TABLOCK
        ); SET @end_time = GETDATE();
        PRINT '>> Time taken to load data into bronze.erp_px_cat_g1v2: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '--------------------------------';   


    SET @total_end_time = GETDATE();
    END TRY

    BEGIN CATCH
        PRINT 'Error occurred while loading data into bronze layer: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
    END CATCH
    
   
    
    PRINT '--------------------------------';
    PRINT 'Total time taken to load data into bronze layer: ' + CAST(DATEDIFF(SECOND, @total_start_time, @total_end_time) AS NVARCHAR(10)) + ' seconds';
    PRINT '--------------------------------';

END
