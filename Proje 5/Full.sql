USE AdventureWorks2016;
GO

-- 1. ADIM: Kalıntıları tamamen temizliyoruz 
IF OBJECT_ID('tempdb..#Staging_MusteriData') IS NOT NULL
    DROP TABLE #Staging_MusteriData;
GO

IF OBJECT_ID('DW_Musteri_Raporlama') IS NOT NULL
    DROP TABLE DW_Musteri_Raporlama;
GO

-- 2. ADIM: Hedef Tabloyu Oluşturma
CREATE TABLE DW_Musteri_Raporlama (
    MusteriID INT IDENTITY(1,1) PRIMARY KEY,
    KaynakBusinessEntityID INT,
    MusteriAdi NVARCHAR(150),
    Temiz_Eposta NVARCHAR(100),
    Standart_Telefon NVARCHAR(30),
    Gecerli_Tarih DATE
);
GO

-- 3. ADIM: Staging Katmanını Oluşturma 
SELECT TOP 20 
    p.BusinessEntityID,
    p.FirstName + ' ' + p.LastName AS Ham_Isim,
    ea.EmailAddress AS Ham_Eposta,
    ph.PhoneNumber AS Ham_Telefon,
    CAST(p.ModifiedDate AS NVARCHAR(50)) AS Ham_Tarih
INTO #Staging_MusteriData -- Yukarıda DROP ettiğimiz için artık burası güvenli!
FROM Person.Person p
LEFT JOIN Person.EmailAddress ea ON p.BusinessEntityID = ea.BusinessEntityID
LEFT JOIN Person.PersonPhone ph ON p.BusinessEntityID = ph.BusinessEntityID;

-- 4. ADIM: Kirli Veri Enjeksiyonu
INSERT INTO #Staging_MusteriData (BusinessEntityID, Ham_Isim, Ham_Eposta, Ham_Telefon, Ham_Tarih)
VALUES 
(99901, '   Meltem Yılmaz  ', 'MELTEM@YILMAZ.COM', '555-444-3322', '2026-06-02 14:22:00'),
(99902, 'Can Tekin', 'cantekin.gmail.com', '0 (532) 111 22 33', '02/06/2026'),
(99903, 'Hakan Kaya', NULL, '   ', '2026.06.02');
GO

-- 5. ADIM: Transform & Load
INSERT INTO DW_Musteri_Raporlama (KaynakBusinessEntityID, MusteriAdi, Temiz_Eposta, Standart_Telefon, Gecerli_Tarih)
SELECT 
    BusinessEntityID AS KaynakBusinessEntityID,
    TRIM(Ham_Isim) AS MusteriAdi,
    LOWER(Ham_Eposta) AS Temiz_Eposta,
    REPLACE(REPLACE(REPLACE(REPLACE(TRIM(Ham_Telefon), '(', ''), ')', ''), '-', ''), ' ', '') AS Standart_Telefon,
    CASE 
        WHEN Ham_Tarih LIKE '%/%' THEN CONVERT(DATE, Ham_Tarih, 103)
        WHEN Ham_Tarih LIKE '%.%' THEN CONVERT(DATE, Ham_Tarih, 102)
        ELSE CONVERT(DATE, Ham_Tarih, 120)
    END AS Gecerli_Tarih
FROM #Staging_MusteriData
WHERE Ham_Eposta IS NOT NULL AND Ham_Eposta LIKE '%@%.%';
GO

-- 6. ADIM: Veri Kalitesi Raporu
SELECT 
    (SELECT COUNT(*) FROM #Staging_MusteriData) AS [Toplam Gelen Ham Kayıt],
    (SELECT COUNT(*) FROM DW_Musteri_Raporlama) AS [Başarıyla Temizlenen ve Yüklenen Kayıt],
    ((SELECT COUNT(*) FROM #Staging_MusteriData) - (SELECT COUNT(*) FROM DW_Musteri_Raporlama)) 
    AS [Kalite Kuralına Takılan (Elenen) Hatalı Kayıt Sayısı],
    CASE 
        WHEN EXISTS (SELECT 1 FROM DW_Musteri_Raporlama WHERE Temiz_Eposta NOT LIKE '%@%.%') 
        THEN 'BAŞARISIZ: Sızan Hatalı Veri Var!'
        ELSE 'BAŞARILI: Veri Dağılımı Tamamen Standart'
    END AS [ETL Kalite Durumu];
GO