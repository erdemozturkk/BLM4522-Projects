USE AdventureWorks2016;
GO

-- Maddelerdeki "Veri Yükleme" hedefi için temiz tablo oluşturma
CREATE TABLE DW_Musteri_Raporlama (
    MusteriID INT IDENTITY(1,1) PRIMARY KEY,
    KaynakBusinessEntityID INT,
    MusteriAdi NVARCHAR(150),
    Temiz_Eposta NVARCHAR(100),
    Standart_Telefon NVARCHAR(30),
    Gecerli_Tarih DATE -- Saat bilgisi atılmış temiz tarih formatı
);
GO