SELECT 
    (SELECT COUNT(*) FROM #Staging_MusteriData) AS [Toplam Gelen Ham Kayıt],
    (SELECT COUNT(*) FROM DW_Musteri_Raporlama) AS [Başarıyla Temizlenen ve Yüklenen Kayıt],
    ((SELECT COUNT(*) FROM #Staging_MusteriData) - (SELECT COUNT(*) FROM DW_Musteri_Raporlama)) AS [Kalite Kuralına Takılan (Elenen) Hatalı Kayıt Sayısı],
    CASE 
        WHEN EXISTS (SELECT 1 FROM DW_Musteri_Raporlama WHERE Temiz_Eposta NOT LIKE '%@%.%') THEN 'BAŞARISIZ: Sızan Hatalı Veri Var!'
        ELSE 'BAŞARILI: Veri Dağılımı Tamamen Standart'
    END AS [ETL Kalite Durumu];
GO