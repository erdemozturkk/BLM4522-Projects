USE AdventureWorks2016;
GO

-- Replikasyon tetiğini tetiklemek için yeni bir sipariş detayı ekliyoruz
INSERT INTO Sales.SalesOrderDetail 
(
    SalesOrderID, 
    CarrierTrackingNumber, 
    OrderQty, 
    ProductID, 
    SpecialOfferID, 
    UnitPrice, 
    UnitPriceDiscount
)
VALUES 
(
    43659,         -- AdventureWorks'te mevcut olan geçerli bir SalesOrderID
    'TR-2026-06',   -- Kargo takip numarası
    2,             -- Sipariş adedi (OrderQty)
    771,           -- Mevcut bir ProductID
    1,             -- Özel teklif ID'si
    2034.99,       -- Birim fiyatı (UnitPrice)
    0.00           -- İndirim oranı
);
GO