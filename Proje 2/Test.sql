USE AdventureWorks2016;
GO

-- 1. Kaç satır veri olduğunu gör 
SELECT COUNT(*) FROM Sales.SalesOrderDetail;

-- 2. Tüm sipariş detaylarını siliyoruz!
DELETE FROM Sales.SalesOrderDetail;

-- 3. Tablo bomboş kalacak 
SELECT COUNT(*) FROM Sales.SalesOrderDetail;
GO


/*
RESTORE DATABASE AdventureWorks2016
FROM DISK = 'E:\SQL_Backups\AdventureWorks_Full.bak'
WITH NORECOVERY, REPLACE; -- NORECOVERY diyoruz çünkü arkasından log yükleyeceğiz
GO

RESTORE LOG AdventureWorks2016
FROM DISK = 'E:\SQL_Backups\AdventureWorks_Log.trn'
WITH RECOVERY; -- RECOVERY diyerek veritabanını tekrar kullanıma açıyoruz
GO


ALTER DATABASE AdventureWorks2016 SET MULTI_USER;
GO

USE AdventureWorks2016;
GO
-- Bakalım veriler geri gelmiş mi? 
SELECT COUNT(*) FROM Sales.SalesOrderDetail;
GO
*/