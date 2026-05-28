-- Bu script her çalıştığında benzersiz isimde bir Full Yedek üretir
DECLARE @DosyaAdi NVARCHAR(255);
DECLARE @Zaman NVARCHAR(50);

-- Anlık tarih ve saati alıyoruz (Format: YYYYMMDD_HHMMSS)
SELECT @Zaman = REPLACE(REPLACE(REPLACE(CONVERT(NVARCHAR, GETDATE(), 120), '-', ''), ' ', '_'), ':', '');

-- Yedekleme yolunu oluşturuyoruz
SET @DosyaAdi = 'E:\SQL_Backups\AdventureWorks_Auto_' + @Zaman + '.bak';

-- Yedekleme komutunu çalıştırıyoruz
BACKUP DATABASE AdventureWorks2016
TO DISK = @DosyaAdi
WITH FORMAT, NAME = 'Automated Full Backup';
GO