use AdventureWorks2016;
-- Test amaçlı araya küçük bir veri değişikliği koyalım ki fark oluşsun
UPDATE Person.Person SET MiddleName = 'F' WHERE BusinessEntityID = 1;

-- Fark yedeğini alıyoruz
BACKUP DATABASE AdventureWorks2016
TO DISK = 'E:\SQL_Backups\AdventureWorks_Diff.bak'
WITH DIFFERENTIAL, NAME = 'Diff Backup of AdventureWorks2016';
GO


