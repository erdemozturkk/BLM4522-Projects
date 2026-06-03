CREATE DATABASE TestReplica;

USE TestReplica;
GO
CREATE TABLE DW_Musteri_Replica (
    SalesOrderID INT,
    ProductID INT,
    OrderQty SMALLINT,
    UnitPrice MONEY
);
GO