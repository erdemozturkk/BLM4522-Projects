BACKUP DATABASE AdventureWorks2016
TO DISK = 'E:\SQL_Backups\AdventureWorks_Full.bak'
WITH FORMAT, MEDIANAME = 'SQLServerBackups', NAME = 'Full Backup of AdventureWorks2016';
GO