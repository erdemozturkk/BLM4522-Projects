-- Staging tablosunu oluşturup AdventureWorks verileriyle dolduruyoruz
SELECT TOP 20 
    p.BusinessEntityID,
    p.FirstName + ' ' + p.LastName AS Ham_Isim,
    ea.EmailAddress AS Ham_Eposta,
    ph.PhoneNumber AS Ham_Telefon,
    CAST(p.ModifiedDate AS NVARCHAR(50)) AS Ham_Tarih -- Dönüşüm testi için metin yapıyoruz
INTO #Staging_MusteriData
FROM Person.Person p
LEFT JOIN Person.EmailAddress ea ON p.BusinessEntityID = ea.BusinessEntityID
LEFT JOIN Person.PersonPhone ph ON p.BusinessEntityID = ph.BusinessEntityID;

-- Araya dökümandaki "Hatalı ve Tutarsız" senaryoları simüle edecek 3 kirli kayıt ekliyoruz
INSERT INTO #Staging_MusteriData (BusinessEntityID, Ham_Isim, Ham_Eposta, Ham_Telefon, Ham_Tarih)
VALUES 
(99901, '   Meltem Yılmaz  ', 'MELTEM@YILMAZ.COM', '555-444-3322', '2026-06-02 14:22:00'), -- Gereksiz boşluklar ve büyük harf e-posta
(99902, 'Can Tekin', 'cantekin.gmail.com', '0 (532) 111 22 33', '02/06/2026'),           -- Geçersiz e-posta (@ yok) ve parantezli telefon
(99903, 'Hakan Kaya', NULL, '   ', '2026.06.02');                                       -- Eksik (NULL) e-posta ve boşluklu telefon
GO

-- Videoda Kirli Durumu Göster:
SELECT * FROM #Staging_MusteriData;
GO


