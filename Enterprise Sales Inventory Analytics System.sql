CREATE DATABASE [Enterprise Sales Inventory Analytics System];
USE [Enterprise Sales Inventory Analytics System];
																												--
CREATE TABLE Customer(
CustomerId		  INT IDENTITY(1,1),
NAME			  VARCHAR(50) NOT NULL,
Phone			  NVARCHAR(13) UNIQUE NOT NULL,
DOB				  DATE,
Gender            CHAR(1) NOT NULL CHECK (Gender IN ('M' , 'F')),
CustomerType      VARCHAR(10) NOT NULL CHECK (CustomerType IN ('VIP', 'Regular', 'Wholesale')),
Address           VARCHAR(100),
City              NVARCHAR(50),
State			  NVARCHAR(50),
Pincode           VARCHAR(10),
CONSTRAINT PK_Customer_CustomerId PRIMARY KEY (CustomerId));


CREATE TABLE Department(
DepartmentId	  INT IDENTITY(1,1),
DepartmentName	  VARCHAR(20) UNIQUE NOT NULL CHECK (DepartmentName IN ('HR', 'Inventory', 'Sales', 'IT_Admin')),
CONSTRAINT PK_Department_DepartmentID PRIMARY KEY (DepartmentId));
-- HR Human resources: hiring, payroll, employee management
-- Inventory Warehouse management: stock, shipments, stock adjustments
--Sales Handles customer orders, leads, and revenue
--System management, software, admin tasks


CREATE TABLE Role(
RoleID				INT IDENTITY(1,1),
RoleName			VARCHAR(20) UNIQUE NOT NULL CHECK (RoleName IN ('Warehouse', 'Admin', 'Sales', 'Manager')),
CONSTRAINT PK_Role_RoleID PRIMARY KEY (RoleID));
--Sales	Takes orders, interacts with customers
--Warehouse	Manages inventory and shipments
--Admin	Administrative tasks, system settings
--Manager	Supervises a department or team, approves transactions


CREATE TABLE Employee(
EmployeeId		  INT IDENTITY(1,1),
EmployeeNAME	  VARCHAR(50) NOT NULL,
Phone			  NVARCHAR(13) UNIQUE NOT NULL,
DOB				  DATE,
Gender            CHAR(1) NOT NULL CHECK (Gender IN ('M' , 'F')),
Address           VARCHAR(100),
City              NVARCHAR(50),
State			  NVARCHAR(50),
Pincode           VARCHAR(10),
RoleId            INT,
DepartmentId      INT,
CONSTRAINT PK_Employee_CustomerId PRIMARY KEY (EmployeeId),
CONSTRAINT FK_Role_RoleId FOREIGN KEY (RoleId) REFERENCES Role(RoleID),
CONSTRAINT FK_Department_DepartmentId FOREIGN KEY (DepartmentId) REFERENCES Department(DepartmentId));

CREATE TABLE Supplier ( --Store supplier/vendor information
SupplierID			INT IDENTITY(1,1) ,
SupplierName		VARCHAR(100) NOT NULL,
ContactName			VARCHAR(50),
Phone				NVARCHAR(13),
Email				VARCHAR(50),
Address				VARCHAR(100),
City				NVARCHAR(50),
State				NVARCHAR(50),
Country				NVARCHAR(50),
CreatedDate			DATETIME DEFAULT GETDATE(),
CONSTRAINT PK_Supplier_SupplierID PRIMARY KEY (SupplierID));


CREATE TABLE Categories(
CategoryID		INT IDENTITY(1,1),
CategoryName	VARCHAR(50) UNIQUE NOT NULL,
Description		NVARCHAR(100),
CreatedDate		DATETIME DEFAULT GETDATE()
CONSTRAINT PK_Categories_CategoryID PRIMARY KEY (CategoryID));

CREATE TABLE SubCategories(
SubCategoryID		INT IDENTITY(1,1),
SubCategoryName		VARCHAR(50) NOT NULL,
CategoryID			INT NOT NULL,
Description			NVARCHAR(100),
CreatedDate			DATETIME DEFAULT GETDATE(),
CONSTRAINT PK_SubCategories_SubCategoryID PRIMARY KEY (SubCategoryID),
CONSTRAINT FK_Categories_CategoryID FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
CONSTRAINT UQ_SubCategories_SubCategoryName_CategoryID UNIQUE (SubCategoryName,CategoryID));

CREATE TABLE Products(
ProductId		INT IDENTITY (1,1),
ProductCode     VARCHAR(20) UNIQUE NOT NULL,        -- business code e.g., PRD001
Name			VARCHAR(50) NOT NULL,
Brand			VARCHAR(50),
Price			DECIMAL(8,2),
Description		NVARCHAR(100),
CategoryID		INT NOT NULL,
SubCategoryID	INT NOT NULL,
SupplierID		INT NOT NULL,
CONSTRAINT PK_Product_ProductId PRIMARY KEY (ProductId),
CONSTRAINT FK_Products_CategoryID FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
CONSTRAINT FK_SubCategories_SubCategoryID FOREIGN KEY (SubCategoryID) REFERENCES SubCategories(SubCategoryID),
CONSTRAINT FK_Supplier_SupplierID FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
CONSTRAINT UQ_Products_Name_CategoryID_SubCategoryID_SupplierID UNIQUE (Name, CategoryID, SubCategoryID, SupplierID));


CREATE TABLE Warehouses( --virtual storage locations.
WarehouseID			INT IDENTITY(1,1) ,
WarehouseCode		VARCHAR(10) UNIQUE NOT NULL, -- e.g., WH001
WarehouseName		VARCHAR(100) NOT NULL,
Address				VARCHAR(200),
City				NVARCHAR(50),
State				NVARCHAR(50),
Pincode				VARCHAR(10),
Phone				NVARCHAR(13),
CreatedDate     DATETIME DEFAULT GETDATE(),
CONSTRAINT PK_Warehouses_WarehouseID PRIMARY KEY (WarehouseID));

CREATE TABLE Inventory ( --CURRENT BALANCE
InventoryID     INT IDENTITY(1,1),
ProductID       INT NOT NULL,
WarehouseID     INT NOT NULL,
Quantity        INT NOT NULL CHECK (Quantity >= 0),
ReorderLevel    INT DEFAULT 10,
LastUpdated     DATETIME DEFAULT GETDATE(),
CONSTRAINT PK_Inventory_InventoryID PRIMARY KEY (InventoryID),
CONSTRAINT FK_Products_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductId),
CONSTRAINT FK_Products_WarehouseID FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID),
CONSTRAINT UQ_Inventory_ProductID_WarehouseID UNIQUE (ProductID, WarehouseID));

--How it works in reality:
--Supplier ships products → a shipment arrives at a warehouse.
--Warehouse stores products → they could be spread across multiple warehouses.
--Inventory must track:
--Which products are in which warehouse
--How many units are available
--Reorder levels, stock aging, etc.

CREATE TABLE PaymentMethod(
PaymentMethodID			INT IDENTITY(1,1),
PaymentMethodName		VARCHAR(40), -- e.g., Cash, Card, Online Payment, Bank Transections
Description				VARCHAR(30), -- e.g., Full amount Paid , off amount Paid, paid, not paid
CreatedDate				DATETIME DEFAULT GETDATE(),
CONSTRAINT PK_PaymentMethods_PaymentMethodID PRIMARY KEY (PaymentMethodID));

CREATE TABLE ShippingMethods (
ShippingMethodID		INT IDENTITY(1,1),
ShippingMethodName      VARCHAR(50) UNIQUE NOT NULL,  -- e.g., UPS, FedEx, DHL, LocalCourier
Description				NVARCHAR(100), --e.g., 
CreatedDate				DATETIME DEFAULT GETDATE(),
CONSTRAINT PK_ShippingMethods_ShippingMethodID PRIMARY KEY (ShippingMethodID)
);

CREATE TABLE Taxes (
TaxID             INT IDENTITY(1,1),
TaxCode			  VARCHAR(10), --e.g., 21A05234BK, 001AH98945
TaxName           VARCHAR(50) NOT NULL,         -- e.g., GST, VAT
TaxRate           DECIMAL(5,2) NOT NULL CHECK (TaxRate >= 0),  -- percentage
Description       VARCHAR(100),
CreatedDate       DATETIME DEFAULT GETDATE(),
CONSTRAINT PK_Taxes_TaxID PRIMARY KEY (TaxID),
CONSTRAINT UQ_Taxes_TaxCode_TaxName UNIQUE (TaxCode,TaxName)
);

CREATE TABLE Currencies (
CurrencyID			INT IDENTITY(1,1),
CurrencyCode		CHAR(4) UNIQUE NOT NULL,      -- e.g., USD, INR, EUR
CurrencyName		VARCHAR(50) NOT NULL,        -- e.g., US Dollar
ExchangeRate		DECIMAL(10,4) NOT NULL DEFAULT 1.0000,  -- relative to base currency
Symbol				VARCHAR(5),                  -- e.g., $, ₹, €
CreatedDate			DATETIME DEFAULT GETDATE(),
CONSTRAINT PK_Currencies_CurrencyID PRIMARY KEY (CurrencyID)
);

CREATE TABLE Orders (
OrderId				INT IDENTITY(1,1),
CustomerId			INT,
EmployeeId			INT,
Total_Quantity		INT,
OrderDate			DATETIME DEFAULT GETDATE(),
CONSTRAINT PK_Orders_OrderId PRIMARY KEY (OrderId),
CONSTRAINT FK_Customer_CustomerId FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
CONSTRAINT FK_Employee_EmployeeId FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId),
CONSTRAINT UQ_Orders_CustomerId_EmployeeId UNIQUE (CustomerId, EmployeeId));

ALTER TABLE Orders
DROP CONSTRAINT UQ_Orders_CustomerId_EmployeeId;

EXEC sp_helpconstraint 'Orders';

CREATE TABLE Order_ItemProduts(
Order_ItemProdutsId			INT IDENTITY(1,1),
OrderId						INT,
ProductId					INT,
Quantity					TINYINT,
Order_ItemProduts			DATETIME DEFAULT GETDATE(),
CONSTRAINT PK_Order_ItemProduts_Order_ItemProdutsId PRIMARY KEY (Order_ItemProdutsId),
CONSTRAINT FK_Order_ItemProduts_OrderId FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
CONSTRAINT FK_Order_ItemProduts_ProductId FOREIGN KEY (ProductId) REFERENCES Products(ProductId),
CONSTRAINT UQ_Order_ItemProduts_OrderId_ProductId UNIQUE (OrderId, ProductId));

CREATE TABLE Payment(
PaymentId			INT IDENTITY(1,1),
OrderId				INT NOT NULL,
PaymentMethodID     INT NOT NULL,
AmountPaid          DECIMAL(12,2) NOT NULL CHECK (AmountPaid > 0),
CurrencyID          INT NOT NULL,
PaymentStatus       VARCHAR(20) NOT NULL 
                    CHECK (PaymentStatus IN ('Paid', 'Pending', 'Failed', 'Refunded')),
TransactionReference NVARCHAR(50),   -- Bank ref / UPI ID / Card txn ID
PaymentDate         DATETIME2 DEFAULT SYSDATETIME(),
Remarks             NVARCHAR(200),
CONSTRAINT PK_Payments_PaymentID PRIMARY KEY (PaymentID),
CONSTRAINT FK_Payments_OrderId FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
CONSTRAINT FK_Payments_PaymentMethodID FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethod(PaymentMethodID),
CONSTRAINT FK_Payments_CurrencyID FOREIGN KEY (CurrencyID) REFERENCES Currencies(CurrencyID));

CREATE TABLE Shipments(
ShipmentId			INT IDENTITY(1,1),
OrderId				INT NOT NULL,
ShippingMethodID	INT NOT NULL,
ShipmentDate		DATETIME2 DEFAULT SYSDATETIME(),
TrackingNumber		NVARCHAR(50),
ShipmentStatus		VARCHAR(20) CHECK (ShipmentStatus IN ('Pending','Shipped','Delivered','Cancelled')),
Remarks				NVARCHAR(200),
CONSTRAINT PK_Shipments_ShipmentID PRIMARY KEY (ShipmentID),
CONSTRAINT FK_Shipments_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
CONSTRAINT FK_Shipments_ShippingMethodID FOREIGN KEY (ShippingMethodID) REFERENCES ShippingMethods(ShippingMethodID));

CREATE TABLE InventoryTransactions (--HISTORY / MOVEMENT Stock IN / OUT
InventoryTransactionID INT IDENTITY(1,1),
ProductID              INT NOT NULL,
WarehouseID            INT NOT NULL,
TransactionType        VARCHAR(10) CHECK (TransactionType IN ('IN','OUT')),
Quantity               INT NOT NULL CHECK (Quantity > 0),
TransactionDate        DATETIME2 DEFAULT SYSDATETIME(),
ReferenceType          VARCHAR(30),  -- Order, Purchase, Return, Adjustment
ReferenceID            INT,
Remarks                NVARCHAR(200),
CONSTRAINT PK_InventoryTransactions PRIMARY KEY (InventoryTransactionID),
CONSTRAINT FK_IT_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
CONSTRAINT FK_IT_WarehouseID FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID));

CREATE TABLE PurchaseOrders (
PurchaseOrderID   INT IDENTITY(1,1),
SupplierID        INT NOT NULL,
OrderDate         DATETIME2 DEFAULT SYSDATETIME(),
ExpectedDate      DATE,
OrderStatus       VARCHAR(20) CHECK (OrderStatus IN ('Pending','Received','Cancelled')),
TotalAmount       DECIMAL(12,2),
Remarks           NVARCHAR(200),
CONSTRAINT PK_PurchaseOrders PRIMARY KEY (PurchaseOrderID),
CONSTRAINT FK_PurchaseOrders_SupplierID FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID));

CREATE TABLE PurchaseOrderItems (
PurchaseOrderItemID INT IDENTITY(1,1),
PurchaseOrderID     INT NOT NULL,
ProductID           INT NOT NULL,
Quantity            INT NOT NULL CHECK (Quantity > 0),
UnitPrice           DECIMAL(10,2) NOT NULL,
CONSTRAINT PK_PurchaseOrderItems PRIMARY KEY (PurchaseOrderItemID),
CONSTRAINT FK_POI_PurchaseOrderID FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrders(PurchaseOrderID),
CONSTRAINT FK_POI_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
CONSTRAINT UQ_POI UNIQUE (PurchaseOrderID, ProductID));

CREATE TABLE Returns ( --Customer returns
ReturnID        INT IDENTITY(1,1),
OrderID         INT NOT NULL,
ReturnDate      DATETIME2 DEFAULT SYSDATETIME(),
ReturnStatus    VARCHAR(20) CHECK (ReturnStatus IN ('Requested','Approved','Rejected','Completed')),
Remarks         NVARCHAR(200),
CONSTRAINT PK_Returns PRIMARY KEY (ReturnID),
CONSTRAINT FK_Returns_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID));

CREATE TABLE ReturnItems (--Items in returns
ReturnItemID   INT IDENTITY(1,1),
ReturnID       INT NOT NULL,
ProductID      INT NOT NULL,
Quantity       INT NOT NULL CHECK (Quantity > 0),
Reason         NVARCHAR(100),
CONSTRAINT PK_ReturnItems PRIMARY KEY (ReturnItemID),
CONSTRAINT FK_ReturnItems_ReturnID FOREIGN KEY (ReturnID) REFERENCES Returns(ReturnID),
CONSTRAINT FK_ReturnItems_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
CONSTRAINT UQ_ReturnItems UNIQUE (ReturnID, ProductID));
    
CREATE TABLE StockAdjustments (
StockAdjustmentID INT IDENTITY(1,1),
ProductID         INT NOT NULL,
WarehouseID       INT NOT NULL,
AdjustmentType    VARCHAR(10) CHECK (AdjustmentType IN ('IN','OUT')),
Quantity          INT NOT NULL CHECK (Quantity > 0),
AdjustmentDate    DATETIME2 DEFAULT SYSDATETIME(),
Reason            NVARCHAR(100),
CONSTRAINT PK_StockAdjustments PRIMARY KEY (StockAdjustmentID),
CONSTRAINT FK_SA_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
CONSTRAINT FK_SA_WarehouseID FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID));

CREATE TABLE OrderAudit (
OrderAuditID     INT IDENTITY(1,1),
OrderID          INT NOT NULL,
ChangedByEmpID   INT,
ChangeType       VARCHAR(30),   -- StatusChange, QuantityChange, Cancelled
OldValue         NVARCHAR(200),
NewValue         NVARCHAR(200),
ChangeDate       DATETIME2 DEFAULT SYSDATETIME(),
Remarks          NVARCHAR(200),
CONSTRAINT PK_OrderAudit PRIMARY KEY (OrderAuditID),
CONSTRAINT FK_OrderAudit_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
CONSTRAINT FK_OrderAudit_EmpID FOREIGN KEY (ChangedByEmpID) REFERENCES Employee(EmployeeID));

CREATE TABLE InventoryAudit ( --Tracks inventory quantity changes
InventoryAuditID INT IDENTITY(1,1),
ProductID        INT NOT NULL,
WarehouseID      INT NOT NULL,
OldQuantity      INT NOT NULL,
NewQuantity      INT NOT NULL,
ChangedByEmpID   INT,
ChangeDate       DATETIME2 DEFAULT SYSDATETIME(),
Remarks          NVARCHAR(200),
CONSTRAINT PK_InventoryAudit PRIMARY KEY (InventoryAuditID),
CONSTRAINT FK_InventoryAudit_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
CONSTRAINT FK_InventoryAudit_WarehouseID FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID),
CONSTRAINT FK_InventoryAudit_ChangedByEmpID FOREIGN KEY (ChangedByEmpID) REFERENCES Employee(EmployeeID));

CREATE TABLE SalesTargets (
SalesTargetID    INT IDENTITY(1,1),
EmployeeID       INT,
DepartmentID     INT,
TargetPeriod     VARCHAR(10) CHECK (TargetPeriod IN ('Monthly','Quarterly')),
TargetMonth      TINYINT CHECK (TargetMonth BETWEEN 1 AND 12),
TargetYear       SMALLINT,
TargetAmount     DECIMAL(12,2),
TargetQuantity   INT,
CONSTRAINT PK_SalesTargets PRIMARY KEY (SalesTargetID),
CONSTRAINT FK_SalesTargets_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
CONSTRAINT FK_SalesTargets_DepartmentID FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID));

CREATE TABLE CustomerFeedback (
FeedbackID     INT IDENTITY(1,1),
CustomerID     INT NOT NULL,
OrderID        INT,
Rating         TINYINT CHECK (Rating BETWEEN 1 AND 5),
Comments       NVARCHAR(300),
FeedbackDate   DATETIME2 DEFAULT SYSDATETIME(),
CONSTRAINT PK_CustomerFeedback PRIMARY KEY (FeedbackID),
CONSTRAINT FK_CustomerFeedback_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT FK_CustomerFeedback_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID));

CREATE TABLE EmployeePerformance (
PerformanceID   INT IDENTITY(1,1),
EmployeeID      INT NOT NULL,
KPIName         VARCHAR(50),     -- SalesAmount, OrdersHandled, Accuracy 
KPIValue        DECIMAL(12,2),
PeriodStart     DATE,
PeriodEnd       DATE,
RecordedDate    DATETIME2 DEFAULT SYSDATETIME(),
CONSTRAINT PK_EmployeePerformance PRIMARY KEY (PerformanceID),
CONSTRAINT FK_EmployeePerformance_EmpID FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID));

CREATE TABLE ErrorLog (
ErrorLogID     INT IDENTITY(1,1),
ErrorMessage   NVARCHAR(400),
ErrorSource    VARCHAR(100),     -- Module / API / Procedure
ErrorSeverity  VARCHAR(20),      -- Info, Warning, Critical
StackTrace     NVARCHAR(MAX),
OccurredOn     DATETIME2 DEFAULT SYSDATETIME(),
UserID         INT NULL);

CREATE TABLE Promotions (
PromotionID     INT IDENTITY(1,1),
PromotionName   NVARCHAR(100),
DiscountType    VARCHAR(20) CHECK (DiscountType IN ('Flat','Percentage')),
DiscountValue   DECIMAL(8,2),
StartDate       DATE,
EndDate         DATE,
IsActive        BIT DEFAULT 1,
CONSTRAINT PK_Promotions_PromotionID PRIMARY KEY (PromotionID));

CREATE TABLE Campaigns (
CampaignID      INT IDENTITY(1,1),
CampaignName    NVARCHAR(100),
CampaignType    VARCHAR(30),    -- Email, SMS, Social
StartDate       DATE,
EndDate         DATE,
Budget          DECIMAL(12,2),
CreatedDate     DATETIME2 DEFAULT SYSDATETIME(),
CONSTRAINT PK_Campaigns PRIMARY KEY (CampaignID));

CREATE TABLE CampaignResponses (
ResponseID     INT IDENTITY(1,1),
CampaignID     INT NOT NULL,
CustomerID     INT NOT NULL,
ResponseType   VARCHAR(20) CHECK (ResponseType IN ('Viewed','Clicked','Purchased','Ignored')),
ResponseDate   DATETIME2 DEFAULT SYSDATETIME(),
CONSTRAINT PK_CampaignResponses PRIMARY KEY (ResponseID),
CONSTRAINT FK_CampaignResponses_CampaignID FOREIGN KEY (CampaignID) REFERENCES Campaigns(CampaignID),
CONSTRAINT FK_CampaignResponses_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID));

