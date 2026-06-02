-- Temizleme, Dönüştürme ve Hedef Tabloya Yükleme İşlemi (Transform & Load)
INSERT INTO DW_Musteri_Raporlama (KaynakBusinessEntityID, MusteriAdi, Temiz_Eposta, Standart_Telefon, Gecerli_Tarih)
SELECT 
    BusinessEntityID AS KaynakBusinessEntityID,
    
    -- [VERİ TEMİZLEME]: İsimlerin başındaki ve sonundaki gereksiz boşlukları temizliyoruz
    TRIM(Ham_Isim) AS MusteriAdi,
    
    -- [VERİ DÖNÜŞTÜRME]: E-postaları standart küçük harfe çeviriyoruz
    LOWER(Ham_Eposta) AS Temiz_Eposta,
    
    -- [VERİ TEMİZLEME]: Telefondaki parantez, tire ve boşlukları temizleyerek sadece numerik yapıyoruz
    REPLACE(REPLACE(REPLACE(REPLACE(TRIM(Ham_Telefon), '(', ''), ')', ''), '-', ''), ' ', '') AS Standart_Telefon,
    
    -- [VERİ DÖNÜŞTÜRME]: Karışık gelen tüm tarih formatlarını tek bir deterministik DATE tipine indirgiyoruz
    CASE 
        WHEN Ham_Tarih LIKE '%/%' THEN CONVERT(DATE, Ham_Tarih, 103) -- DD/MM/YYYY formatı için
        WHEN Ham_Tarih LIKE '%.%' THEN CONVERT(DATE, Ham_Tarih, 102) -- YYYY.MM.DD formatı için
        ELSE CONVERT(DATE, Ham_Tarih, 120) -- Standart YYYY-MM-DD formatı için
    END AS Gecerli_Tarih
FROM #Staging_MusteriData
-- [VERİ KALİTESİ FİLTRESİ]: E-postası NULL olan veya geçerli e-posta formatına (@ ve nokta) uymayan kayıtları eliyoruz
WHERE Ham_Eposta IS NOT NULL AND Ham_Eposta LIKE '%@%.%';
GO