USE AdventureWorks2016;
GO

CREATE OR ALTER TRIGGER TR_GercekDagitik_Replikasyon
ON Sales.SalesOrderDetail
AFTER INSERT -- Yeni sipariş eklendiğinde tetiklenir
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO [ERDEM\MSSQLSERVER01].TestReplica.dbo.DW_Musteri_Replica 
    (SalesOrderID, ProductID, OrderQty, UnitPrice)
    SELECT SalesOrderID, ProductID, OrderQty, UnitPrice
    FROM inserted; -- O an eklenen yeni verileri tutan SQL hafızası
    
    PRINT 'AĞ TABANLI REPLİKASYON BAŞARILI: Veri anlık olarak paralel Instance''a aktarıldı.';
END;
GO