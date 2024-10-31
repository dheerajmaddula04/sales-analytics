USE gold_db
GO

CREATE OR ALTER PROC CreateSQLServerlessView_gold @ViewName NVARCHAR(100)
AS 
BEGIN

    DECLARE @statement NVARCHAR(MAX)  -- Change to NVARCHAR to match @ViewName type
    
    SET @statement = N'CREATE OR ALTER VIEW ' + QUOTENAME(@ViewName) + ' AS
        SELECT * 
        FROM
        OPENROWSET(
            BULK ''https://storageaccsalesanalytics.dfs.core.windows.net/gold/SalesLT/' + @ViewName + '/'' ,
            FORMAT = ''DELTA''
        ) AS [result]'
    
    EXEC sp_executesql @statement  -- Using sp_executesql instead of EXEC for NVARCHAR
    
END
GO
