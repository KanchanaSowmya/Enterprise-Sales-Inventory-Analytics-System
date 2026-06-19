CREATE PROCEDURE usp_Customer_Add
(
@Name VARCHAR(50),
@Phone NVARCHAR(13),
@DOB DATE,
@Gender CHAR(1),
@CustomerType VARCHAR(10),
@Address VARCHAR(100),
@City NVARCHAR(50),
@State NVARCHAR(50),
@Pincode VARCHAR(10)
)
AS
BEGIN
INSERT INTO Customer
(
Name, Phone, DOB, Gender,
CustomerType, Address,
City, State, Pincode
)
VALUES
(
@Name, @Phone, @DOB, @Gender,
@CustomerType, @Address,
@City, @State, @Pincode
);
END;
GO

CREATE PROCEDURE usp_Customer_Get
(
@CustomerId INT = NULL
)
AS
BEGIN
IF @CustomerId IS NULL
SELECT * FROM Customer;
ELSE
SELECT * FROM Customer
WHERE CustomerId = @CustomerId;
END;
GO

CREATE PROCEDURE usp_Customer_Update
(
@CustomerId INT,
@Name VARCHAR(50),
@Phone NVARCHAR(13),
@DOB DATE,
@Gender CHAR(1),
@CustomerType VARCHAR(10),
@Address VARCHAR(100),
@City NVARCHAR(50),
@State NVARCHAR(50),
@Pincode VARCHAR(10)
)
AS
BEGIN
UPDATE Customer
SET
Name = @Name,
Phone = @Phone,
DOB = @DOB,
Gender = @Gender,
CustomerType = @CustomerType,
Address = @Address,
City = @City,
State = @State,
Pincode = @Pincode
WHERE CustomerId = @CustomerId;
END;
GO

CREATE PROCEDURE usp_Customer_Delete
(
@CustomerId INT
)
AS
BEGIN
DELETE FROM Customer
WHERE CustomerId = @CustomerId;
END;
GO


-- =============================================
-- Department : Add
-- =============================================
CREATE PROCEDURE usp_Department_Add
(
@DepartmentName VARCHAR(20)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Department (DepartmentName)
VALUES (@DepartmentName);

END;
GO

-- =============================================
-- Department : Get
-- =============================================
CREATE PROCEDURE usp_Department_Get
(
@DepartmentId INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @DepartmentId IS NULL
    SELECT *
    FROM Department;
ELSE
    SELECT *
    FROM Department
    WHERE DepartmentId = @DepartmentId;


END;
GO

-- =============================================
-- Department : Update
-- =============================================
CREATE PROCEDURE usp_Department_Update
(
@DepartmentId INT,
@DepartmentName VARCHAR(20)
)
AS
BEGIN
SET NOCOUNT ON;

UPDATE Department
SET DepartmentName = @DepartmentName
WHERE DepartmentId = @DepartmentId;


END;
GO

-- =============================================
-- Department : Delete
-- =============================================
CREATE PROCEDURE usp_Department_Delete
(
@DepartmentId INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Department
WHERE DepartmentId = @DepartmentId;


END;
GO


-- =============================================
-- Role : Add
-- =============================================
CREATE PROCEDURE usp_Role_Add
(
@RoleName VARCHAR(20)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Role (RoleName)
VALUES (@RoleName);

END;
GO

-- =============================================
-- Role : Get
-- =============================================
CREATE PROCEDURE usp_Role_Get
(
@RoleID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @RoleID IS NULL
    SELECT *
    FROM Role;
ELSE
    SELECT *
    FROM Role
    WHERE RoleID = @RoleID;


END;
GO

-- =============================================
-- Role : Update
-- =============================================
CREATE PROCEDURE usp_Role_Update
(
@RoleID INT,
@RoleName VARCHAR(20)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Role
SET RoleName = @RoleName
WHERE RoleID = @RoleID;

END;
GO

-- =============================================
-- Role : Delete
-- =============================================
CREATE PROCEDURE usp_Role_Delete
(
@RoleID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Role
WHERE RoleID = @RoleID;


END;
GO
-- =============================================
-- Employee : Add
-- =============================================
CREATE PROCEDURE usp_Employee_Add
(
@EmployeeNAME VARCHAR(50),
@Phone NVARCHAR(13),
@DOB DATE,
@Gender CHAR(1),
@Address VARCHAR(100),
@City NVARCHAR(50),
@State NVARCHAR(50),
@Pincode VARCHAR(10),
@RoleId INT,
@DepartmentId INT
)
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO Employee
(
    EmployeeNAME,
    Phone,
    DOB,
    Gender,
    Address,
    City,
    State,
    Pincode,
    RoleId,
    DepartmentId
)
VALUES
(
    @EmployeeNAME,
    @Phone,
    @DOB,
    @Gender,
    @Address,
    @City,
    @State,
    @Pincode,
    @RoleId,
    @DepartmentId
);


END;
GO

-- =============================================
-- Employee : Get
-- =============================================
CREATE PROCEDURE usp_Employee_Get
(
@EmployeeId INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @EmployeeId IS NULL
BEGIN
    SELECT
        E.EmployeeId,
        E.EmployeeNAME,
        E.Phone,
        E.DOB,
        E.Gender,
        E.Address,
        E.City,
        E.State,
        E.Pincode,
        R.RoleName,
        D.DepartmentName
    FROM Employee E
    INNER JOIN Role R
        ON E.RoleId = R.RoleID
    INNER JOIN Department D
        ON E.DepartmentId = D.DepartmentId;
END
ELSE
BEGIN
    SELECT
        E.EmployeeId,
        E.EmployeeNAME,
        E.Phone,
        E.DOB,
        E.Gender,
        E.Address,
        E.City,
        E.State,
        E.Pincode,
        R.RoleName,
        D.DepartmentName
    FROM Employee E
    INNER JOIN Role R
        ON E.RoleId = R.RoleID
    INNER JOIN Department D
        ON E.DepartmentId = D.DepartmentId
    WHERE E.EmployeeId = @EmployeeId;
END

END;
GO

-- =============================================
-- Employee : Update
-- =============================================
CREATE PROCEDURE usp_Employee_Update
(
@EmployeeId INT,
@EmployeeNAME VARCHAR(50),
@Phone NVARCHAR(13),
@DOB DATE,
@Gender CHAR(1),
@Address VARCHAR(100),
@City NVARCHAR(50),
@State NVARCHAR(50),
@Pincode VARCHAR(10),
@RoleId INT,
@DepartmentId INT
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Employee
SET
    EmployeeNAME = @EmployeeNAME,
    Phone = @Phone,
    DOB = @DOB,
    Gender = @Gender,
    Address = @Address,
    City = @City,
    State = @State,
    Pincode = @Pincode,
    RoleId = @RoleId,
    DepartmentId = @DepartmentId
WHERE EmployeeId = @EmployeeId;


END;
GO

-- =============================================
-- Employee : Delete
-- =============================================
CREATE PROCEDURE usp_Employee_Delete
(
@EmployeeId INT
)
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM Employee
WHERE EmployeeId = @EmployeeId;


END;
GO

-- =============================================
-- Supplier : Add
-- =============================================
CREATE PROCEDURE usp_Supplier_Add
(
@SupplierName VARCHAR(100),
@ContactName VARCHAR(50),
@Phone NVARCHAR(13),
@Email VARCHAR(50),
@Address VARCHAR(100),
@City NVARCHAR(50),
@State NVARCHAR(50),
@Country NVARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO Supplier
(
    SupplierName,
    ContactName,
    Phone,
    Email,
    Address,
    City,
    State,
    Country
)
VALUES
(
    @SupplierName,
    @ContactName,
    @Phone,
    @Email,
    @Address,
    @City,
    @State,
    @Country
);


END;
GO

-- =============================================
-- Supplier : Get
-- =============================================
CREATE PROCEDURE usp_Supplier_Get
(
@SupplierID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @SupplierID IS NULL
    SELECT *
    FROM Supplier
    ORDER BY SupplierID;
ELSE
    SELECT *
    FROM Supplier
    WHERE SupplierID = @SupplierID;


END;
GO

-- =============================================
-- Supplier : Update
-- =============================================
CREATE PROCEDURE usp_Supplier_Update
(
@SupplierID INT,
@SupplierName VARCHAR(100),
@ContactName VARCHAR(50),
@Phone NVARCHAR(13),
@Email VARCHAR(50),
@Address VARCHAR(100),
@City NVARCHAR(50),
@State NVARCHAR(50),
@Country NVARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Supplier
SET
    SupplierName = @SupplierName,
    ContactName = @ContactName,
    Phone = @Phone,
    Email = @Email,
    Address = @Address,
    City = @City,
    State = @State,
    Country = @Country
WHERE SupplierID = @SupplierID;

END;
GO

-- =============================================
-- Supplier : Delete
-- =============================================
CREATE PROCEDURE usp_Supplier_Delete
(
@SupplierID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Supplier
WHERE SupplierID = @SupplierID;


END;
GO

-- =============================================
-- Categories : Add
-- =============================================
CREATE PROCEDURE usp_Categories_Add
(
@CategoryName VARCHAR(50),
@Description NVARCHAR(100)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Categories
(
    CategoryName,
    Description
)
VALUES
(
    @CategoryName,
    @Description
);


END;
GO

-- =============================================
-- Categories : Get
-- =============================================
CREATE PROCEDURE usp_Categories_Get
(
@CategoryID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @CategoryID IS NULL
    SELECT *
    FROM Categories
    ORDER BY CategoryID;
ELSE
    SELECT *
    FROM Categories
    WHERE CategoryID = @CategoryID;


END;
GO

-- =============================================
-- Categories : Update
-- =============================================
CREATE PROCEDURE usp_Categories_Update
(
@CategoryID INT,
@CategoryName VARCHAR(50),
@Description NVARCHAR(100)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Categories
SET
    CategoryName = @CategoryName,
    Description = @Description
WHERE CategoryID = @CategoryID;


END;
GO

-- =============================================
-- Categories : Delete
-- =============================================
CREATE PROCEDURE usp_Categories_Delete
(
@CategoryID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Categories
WHERE CategoryID = @CategoryID;


END;
GO

-- =============================================
-- SubCategories : Add
-- =============================================
CREATE PROCEDURE usp_SubCategories_Add
(
@SubCategoryName VARCHAR(50),
@CategoryID INT,
@Description NVARCHAR(100)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO SubCategories
(
    SubCategoryName,
    CategoryID,
    Description
)
VALUES
(
    @SubCategoryName,
    @CategoryID,
    @Description
);


END;
GO

-- =============================================
-- SubCategories : Get
-- =============================================
CREATE PROCEDURE usp_SubCategories_Get
(
@SubCategoryID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @SubCategoryID IS NULL
BEGIN
    SELECT
        SC.SubCategoryID,
        SC.SubCategoryName,
        C.CategoryID,
        C.CategoryName,
        SC.Description,
        SC.CreatedDate
    FROM SubCategories SC
    INNER JOIN Categories C
        ON SC.CategoryID = C.CategoryID
    ORDER BY SC.SubCategoryID;
END
ELSE
BEGIN
    SELECT
        SC.SubCategoryID,
        SC.SubCategoryName,
        C.CategoryID,
        C.CategoryName,
        SC.Description,
        SC.CreatedDate
    FROM SubCategories SC
    INNER JOIN Categories C
        ON SC.CategoryID = C.CategoryID
    WHERE SC.SubCategoryID = @SubCategoryID;
END


END;
GO

-- =============================================
-- SubCategories : Update
-- =============================================
CREATE PROCEDURE usp_SubCategories_Update
(
@SubCategoryID INT,
@SubCategoryName VARCHAR(50),
@CategoryID INT,
@Description NVARCHAR(100)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE SubCategories
SET
    SubCategoryName = @SubCategoryName,
    CategoryID = @CategoryID,
    Description = @Description
WHERE SubCategoryID = @SubCategoryID;

END;
GO

-- =============================================
-- SubCategories : Delete
-- =============================================
CREATE PROCEDURE usp_SubCategories_Delete
(
@SubCategoryID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM SubCategories
WHERE SubCategoryID = @SubCategoryID;


END;
GO

-- =============================================
-- Products : Add
-- =============================================
CREATE PROCEDURE usp_Products_Add
(
@ProductCode VARCHAR(20),
@Name VARCHAR(50),
@Brand VARCHAR(50),
@Price DECIMAL(8,2),
@Description NVARCHAR(100),
@CategoryID INT,
@SubCategoryID INT,
@SupplierID INT
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Products
(
    ProductCode,
    Name,
    Brand,
    Price,
    Description,
    CategoryID,
    SubCategoryID,
    SupplierID
)
VALUES
(
    @ProductCode,
    @Name,
    @Brand,
    @Price,
    @Description,
    @CategoryID,
    @SubCategoryID,
    @SupplierID
);


END;
GO

-- =============================================
-- Products : Get
-- =============================================
CREATE PROCEDURE usp_Products_Get
(
@ProductID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @ProductID IS NULL
BEGIN
    SELECT
        P.ProductID,
        P.ProductCode,
        P.Name,
        P.Brand,
        P.Price,
        P.Description,
        C.CategoryName,
        SC.SubCategoryName,
        S.SupplierName
    FROM Products P
    INNER JOIN Categories C
        ON P.CategoryID = C.CategoryID
    INNER JOIN SubCategories SC
        ON P.SubCategoryID = SC.SubCategoryID
    INNER JOIN Supplier S
        ON P.SupplierID = S.SupplierID
    ORDER BY P.ProductID;
END
ELSE
BEGIN
    SELECT
        P.ProductID,
        P.ProductCode,
        P.Name,
        P.Brand,
        P.Price,
        P.Description,
        C.CategoryName,
        SC.SubCategoryName,
        S.SupplierName
    FROM Products P
    INNER JOIN Categories C
        ON P.CategoryID = C.CategoryID
    INNER JOIN SubCategories SC
        ON P.SubCategoryID = SC.SubCategoryID
    INNER JOIN Supplier S
        ON P.SupplierID = S.SupplierID
    WHERE P.ProductID = @ProductID;
END

END;
GO

-- =============================================
-- Products : Update
-- =============================================
CREATE PROCEDURE usp_Products_Update
(
@ProductID INT,
@ProductCode VARCHAR(20),
@Name VARCHAR(50),
@Brand VARCHAR(50),
@Price DECIMAL(8,2),
@Description NVARCHAR(100),
@CategoryID INT,
@SubCategoryID INT,
@SupplierID INT
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Products
SET
    ProductCode = @ProductCode,
    Name = @Name,
    Brand = @Brand,
    Price = @Price,
    Description = @Description,
    CategoryID = @CategoryID,
    SubCategoryID = @SubCategoryID,
    SupplierID = @SupplierID
WHERE ProductID = @ProductID;


END;
GO

-- =============================================
-- Products : Delete
-- =============================================
CREATE PROCEDURE usp_Products_Delete
(
@ProductID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Products
WHERE ProductID = @ProductID;


END;
GO

-- =============================================
-- Warehouses : Add
-- =============================================
CREATE PROCEDURE usp_Warehouses_Add
(
@WarehouseCode VARCHAR(10),
@WarehouseName VARCHAR(100),
@Address VARCHAR(200),
@City NVARCHAR(50),
@State NVARCHAR(50),
@Pincode VARCHAR(10),
@Phone NVARCHAR(13)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Warehouses
(
    WarehouseCode,
    WarehouseName,
    Address,
    City,
    State,
    Pincode,
    Phone
)
VALUES
(
    @WarehouseCode,
    @WarehouseName,
    @Address,
    @City,
    @State,
    @Pincode,
    @Phone
);


END;
GO

-- =============================================
-- Warehouses : Get
-- =============================================
CREATE PROCEDURE usp_Warehouses_Get
(
@WarehouseID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @WarehouseID IS NULL
    SELECT *
    FROM Warehouses
    ORDER BY WarehouseID;
ELSE
    SELECT *
    FROM Warehouses
    WHERE WarehouseID = @WarehouseID;


END;
GO

-- =============================================
-- Warehouses : Update
-- =============================================
CREATE PROCEDURE usp_Warehouses_Update
(
@WarehouseID INT,
@WarehouseCode VARCHAR(10),
@WarehouseName VARCHAR(100),
@Address VARCHAR(200),
@City NVARCHAR(50),
@State NVARCHAR(50),
@Pincode VARCHAR(10),
@Phone NVARCHAR(13)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Warehouses
SET
    WarehouseCode = @WarehouseCode,
    WarehouseName = @WarehouseName,
    Address = @Address,
    City = @City,
    State = @State,
    Pincode = @Pincode,
    Phone = @Phone
WHERE WarehouseID = @WarehouseID;


END;
GO

-- =============================================
-- Warehouses : Delete
-- =============================================
CREATE PROCEDURE usp_Warehouses_Delete
(
@WarehouseID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Warehouses
WHERE WarehouseID = @WarehouseID;


END;
GO

-- =============================================
-- Inventory : Add
-- =============================================
CREATE PROCEDURE usp_Inventory_Add
(
@ProductID INT,
@WarehouseID INT,
@Quantity INT,
@ReorderLevel INT = 10
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Inventory
(
    ProductID,
    WarehouseID,
    Quantity,
    ReorderLevel
)
VALUES
(
    @ProductID,
    @WarehouseID,
    @Quantity,
    @ReorderLevel
);


END;
GO

-- =============================================
-- Inventory : Get
-- =============================================
CREATE PROCEDURE usp_Inventory_Get
(
@InventoryID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @InventoryID IS NULL
BEGIN
    SELECT
        I.InventoryID,
        P.ProductCode,
        P.Name AS ProductName,
        W.WarehouseCode,
        W.WarehouseName,
        I.Quantity,
        I.ReorderLevel,
        I.LastUpdated
    FROM Inventory I
    INNER JOIN Products P
        ON I.ProductID = P.ProductID
    INNER JOIN Warehouses W
        ON I.WarehouseID = W.WarehouseID
    ORDER BY I.InventoryID;
END
ELSE
BEGIN
    SELECT
        I.InventoryID,
        P.ProductCode,
        P.Name AS ProductName,
        W.WarehouseCode,
        W.WarehouseName,
        I.Quantity,
        I.ReorderLevel,
        I.LastUpdated
    FROM Inventory I
    INNER JOIN Products P
        ON I.ProductID = P.ProductID
    INNER JOIN Warehouses W
        ON I.WarehouseID = W.WarehouseID
    WHERE I.InventoryID = @InventoryID;
END


END;
GO

-- =============================================
-- Inventory : Update
-- =============================================
CREATE PROCEDURE usp_Inventory_Update
(
@InventoryID INT,
@ProductID INT,
@WarehouseID INT,
@Quantity INT,
@ReorderLevel INT
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Inventory
SET
    ProductID = @ProductID,
    WarehouseID = @WarehouseID,
    Quantity = @Quantity,
    ReorderLevel = @ReorderLevel,
    LastUpdated = GETDATE()
WHERE InventoryID = @InventoryID;


END;
GO

-- =============================================
-- Inventory : Delete
-- =============================================
CREATE PROCEDURE usp_Inventory_Delete
(
@InventoryID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Inventory
WHERE InventoryID = @InventoryID;


END;
GO

-- =============================================
-- PaymentMethod : Add
-- =============================================
CREATE PROCEDURE usp_PaymentMethod_Add
(
@PaymentMethodName VARCHAR(40),
@Description VARCHAR(30)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO PaymentMethod
(
    PaymentMethodName,
    Description
)
VALUES
(
    @PaymentMethodName,
    @Description
);


END;
GO

-- =============================================
-- PaymentMethod : Get
-- =============================================
CREATE PROCEDURE usp_PaymentMethod_Get
(
@PaymentMethodID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @PaymentMethodID IS NULL
    SELECT *
    FROM PaymentMethod
    ORDER BY PaymentMethodID;
ELSE
    SELECT *
    FROM PaymentMethod
    WHERE PaymentMethodID = @PaymentMethodID;


END;
GO

-- =============================================
-- PaymentMethod : Update
-- =============================================
CREATE PROCEDURE usp_PaymentMethod_Update
(
@PaymentMethodID INT,
@PaymentMethodName VARCHAR(40),
@Description VARCHAR(30)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE PaymentMethod
SET
    PaymentMethodName = @PaymentMethodName,
    Description = @Description
WHERE PaymentMethodID = @PaymentMethodID;


END;
GO

-- =============================================
-- PaymentMethod : Delete
-- =============================================
CREATE PROCEDURE usp_PaymentMethod_Delete
(
@PaymentMethodID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM PaymentMethod
WHERE PaymentMethodID = @PaymentMethodID;


END;
GO


-- =============================================
-- ShippingMethods : Add
-- =============================================
CREATE PROCEDURE usp_ShippingMethods_Add
(
@ShippingMethodName VARCHAR(50),
@Description NVARCHAR(100)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO ShippingMethods
(
    ShippingMethodName,
    Description
)
VALUES
(
    @ShippingMethodName,
    @Description
);


END;
GO

-- =============================================
-- ShippingMethods : Get
-- =============================================
CREATE PROCEDURE usp_ShippingMethods_Get
(
@ShippingMethodID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @ShippingMethodID IS NULL
    SELECT *
    FROM ShippingMethods
    ORDER BY ShippingMethodID;
ELSE
    SELECT *
    FROM ShippingMethods
    WHERE ShippingMethodID = @ShippingMethodID;


END;
GO

-- =============================================
-- ShippingMethods : Update
-- =============================================
CREATE PROCEDURE usp_ShippingMethods_Update
(
@ShippingMethodID INT,
@ShippingMethodName VARCHAR(50),
@Description NVARCHAR(100)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE ShippingMethods
SET
    ShippingMethodName = @ShippingMethodName,
    Description = @Description
WHERE ShippingMethodID = @ShippingMethodID;


END;
GO

-- =============================================
-- ShippingMethods : Delete
-- =============================================
CREATE PROCEDURE usp_ShippingMethods_Delete
(
@ShippingMethodID INT
)
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM ShippingMethods
WHERE ShippingMethodID = @ShippingMethodID;


END;
GO

-- =============================================
-- Taxes : Add
-- =============================================
CREATE PROCEDURE usp_Taxes_Add
(
@TaxCode VARCHAR(10),
@TaxName VARCHAR(50),
@TaxRate DECIMAL(6,3),
@Description VARCHAR(100)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Taxes
(
    TaxCode,
    TaxName,
    TaxRate,
    Description
)
VALUES
(
    @TaxCode,
    @TaxName,
    @TaxRate,
    @Description
);


END;
GO

-- =============================================
-- Taxes : Get
-- =============================================
CREATE PROCEDURE usp_Taxes_Get
(
@TaxID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @TaxID IS NULL
    SELECT *
    FROM Taxes
    ORDER BY TaxID;
ELSE
    SELECT *
    FROM Taxes
    WHERE TaxID = @TaxID;


END;
GO

-- =============================================
-- Taxes : Update
-- =============================================
CREATE PROCEDURE usp_Taxes_Update
(
@TaxID INT,
@TaxCode VARCHAR(10),
@TaxName VARCHAR(50),
@TaxRate DECIMAL(6,3),
@Description VARCHAR(100)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Taxes
SET
    TaxCode = @TaxCode,
    TaxName = @TaxName,
    TaxRate = @TaxRate,
    Description = @Description
WHERE TaxID = @TaxID;


END;
GO

-- =============================================
-- Taxes : Delete
-- =============================================
CREATE PROCEDURE usp_Taxes_Delete
(
@TaxID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Taxes
WHERE TaxID = @TaxID;


END;
GO

-- =============================================
-- Currencies : Add
-- =============================================
CREATE PROCEDURE usp_Currencies_Add
(
@CurrencyCode CHAR(3),
@CurrencyName VARCHAR(50),
@ExchangeRate DECIMAL(10,4),
@Symbol VARCHAR(5)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Currencies
(
    CurrencyCode,
    CurrencyName,
    ExchangeRate,
    Symbol
)
VALUES
(
    @CurrencyCode,
    @CurrencyName,
    @ExchangeRate,
    @Symbol
);


END;
GO

-- =============================================
-- Currencies : Get
-- =============================================
CREATE PROCEDURE usp_Currencies_Get
(
@CurrencyID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @CurrencyID IS NULL
    SELECT *
    FROM Currencies
    ORDER BY CurrencyID;
ELSE
    SELECT *
    FROM Currencies
    WHERE CurrencyID = @CurrencyID;


END;
GO

-- =============================================
-- Currencies : Update
-- =============================================
CREATE PROCEDURE usp_Currencies_Update
(
@CurrencyID INT,
@CurrencyCode CHAR(3),
@CurrencyName VARCHAR(50),
@ExchangeRate DECIMAL(10,4),
@Symbol VARCHAR(5)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Currencies
SET
    CurrencyCode = @CurrencyCode,
    CurrencyName = @CurrencyName,
    ExchangeRate = @ExchangeRate,
    Symbol = @Symbol
WHERE CurrencyID = @CurrencyID;


END;
GO

-- =============================================
-- Currencies : Delete
-- =============================================
CREATE PROCEDURE usp_Currencies_Delete
(
@CurrencyID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Currencies
WHERE CurrencyID = @CurrencyID;


END;
GO

-- =============================================
-- Orders : Add
-- =============================================
CREATE PROCEDURE usp_Orders_Add
(
@CustomerId INT,
@EmployeeId INT,
@Total_Quantity INT
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Orders
(
    CustomerId,
    EmployeeId,
    Total_Quantity,
    OrderDate
)
VALUES
(
    @CustomerId,
    @EmployeeId,
    @Total_Quantity,
    GETDATE()
);

END;
GO

-- =============================================
-- Orders : Get
-- =============================================
CREATE PROCEDURE usp_Orders_Get
(
@OrderId INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;

IF @OrderId IS NULL
BEGIN
    SELECT
        O.OrderId,
        C.CustomerId,
        C.NAME AS CustomerName,
        E.EmployeeId,
        E.EmployeeName,
        O.Total_Quantity,
        O.OrderDate
    FROM Orders O
    INNER JOIN Customer C
        ON O.CustomerId = C.CustomerId
    INNER JOIN Employee E
        ON O.EmployeeId = E.EmployeeId
    ORDER BY O.OrderId;
END
ELSE
BEGIN
    SELECT
        O.OrderId,
        C.CustomerId,
        C.NAME AS CustomerName,
        E.EmployeeId,
        E.EmployeeName,
        O.Total_Quantity,
        O.OrderDate
    FROM Orders O
    INNER JOIN Customer C
        ON O.CustomerId = C.CustomerId
    INNER JOIN Employee E
        ON O.EmployeeId = E.EmployeeId
    WHERE O.OrderId = @OrderId;
END


END;
GO

-- =============================================
-- Orders : Update
-- =============================================
CREATE PROCEDURE usp_Orders_Update
(
@OrderId INT,
@CustomerId INT,
@EmployeeId INT,
@Total_Quantity INT
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Orders
SET
    CustomerId = @CustomerId,
    EmployeeId = @EmployeeId,
    Total_Quantity = @Total_Quantity
WHERE OrderId = @OrderId;


END;
GO

-- =============================================
-- Orders : Delete
-- =============================================
CREATE PROCEDURE usp_Orders_Delete
(
@OrderId INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Orders
WHERE OrderId = @OrderId;


END;
GO

-- =============================================
-- Order_ItemProducts : Add
-- =============================================
CREATE PROCEDURE usp_Order_ItemProducts_Add
(
@OrderId INT,
@ProductId INT,
@Quantity TINYINT
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Order_ItemProduts
(
    OrderId,
    ProductId,
    Quantity,
    Order_ItemProduts
)
VALUES
(
    @OrderId,
    @ProductId,
    @Quantity,
    GETDATE()
);


END;
GO

-- =============================================
-- Order_ItemProducts : Get
-- =============================================
CREATE PROCEDURE usp_Order_ItemProducts_Get
(
@Order_ItemProdutsId INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @Order_ItemProdutsId IS NULL
BEGIN
    SELECT
        OIP.Order_ItemProdutsId,
        O.OrderId,
        P.ProductId,
        P.ProductCode,
        P.Name AS ProductName,
        OIP.Quantity,
        OIP.Order_ItemProduts AS CreatedDate
    FROM Order_ItemProduts OIP
    INNER JOIN Orders O
        ON OIP.OrderId = O.OrderId
    INNER JOIN Products P
        ON OIP.ProductId = P.ProductId
    ORDER BY OIP.Order_ItemProdutsId;
END
ELSE
BEGIN
    SELECT
        OIP.Order_ItemProdutsId,
        O.OrderId,
        P.ProductId,
        P.ProductCode,
        P.Name AS ProductName,
        OIP.Quantity,
        OIP.Order_ItemProduts AS CreatedDate
    FROM Order_ItemProduts OIP
    INNER JOIN Orders O
        ON OIP.OrderId = O.OrderId
    INNER JOIN Products P
        ON OIP.ProductId = P.ProductId
    WHERE OIP.Order_ItemProdutsId = @Order_ItemProdutsId;
END


END;
GO

-- =============================================
-- Order_ItemProducts : Update
-- =============================================
CREATE PROCEDURE usp_Order_ItemProducts_Update
(
@Order_ItemProdutsId INT,
@OrderId INT,
@ProductId INT,
@Quantity TINYINT
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Order_ItemProduts
SET
    OrderId = @OrderId,
    ProductId = @ProductId,
    Quantity = @Quantity
WHERE Order_ItemProdutsId = @Order_ItemProdutsId;


END;
GO

-- =============================================
-- Order_ItemProducts : Delete
-- =============================================
CREATE PROCEDURE usp_Order_ItemProducts_Delete
(
@Order_ItemProdutsId INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Order_ItemProduts
WHERE Order_ItemProdutsId = @Order_ItemProdutsId;


END;
GO

-- =============================================
-- Payment : Add
-- =============================================
CREATE PROCEDURE usp_Payment_Add
(
@OrderId INT,
@PaymentMethodID INT,
@AmountPaid DECIMAL(12,2),
@CurrencyID INT,
@PaymentStatus VARCHAR(20),
@TransactionReference NVARCHAR(50),
@Remarks NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Payment
(
    OrderId,
    PaymentMethodID,
    AmountPaid,
    CurrencyID,
    PaymentStatus,
    TransactionReference,
    PaymentDate,
    Remarks
)
VALUES
(
    @OrderId,
    @PaymentMethodID,
    @AmountPaid,
    @CurrencyID,
    @PaymentStatus,
    @TransactionReference,
    SYSDATETIME(),
    @Remarks
);


END;
GO

-- =============================================
-- Payment : Get
-- =============================================
CREATE PROCEDURE usp_Payment_Get
(
@PaymentId INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @PaymentId IS NULL
BEGIN
    SELECT
        P.PaymentId,
        O.OrderId,
        PM.PaymentMethodName,
        C.CurrencyCode,
        P.AmountPaid,
        P.PaymentStatus,
        P.TransactionReference,
        P.PaymentDate,
        P.Remarks
    FROM Payment P
    INNER JOIN Orders O
        ON P.OrderId = O.OrderId
    INNER JOIN PaymentMethod PM
        ON P.PaymentMethodID = PM.PaymentMethodID
    INNER JOIN Currencies C
        ON P.CurrencyID = C.CurrencyID
    ORDER BY P.PaymentId;
END
ELSE
BEGIN
    SELECT
        P.PaymentId,
        O.OrderId,
        PM.PaymentMethodName,
        C.CurrencyCode,
        P.AmountPaid,
        P.PaymentStatus,
        P.TransactionReference,
        P.PaymentDate,
        P.Remarks
    FROM Payment P
    INNER JOIN Orders O
        ON P.OrderId = O.OrderId
    INNER JOIN PaymentMethod PM
        ON P.PaymentMethodID = PM.PaymentMethodID
    INNER JOIN Currencies C
        ON P.CurrencyID = C.CurrencyID
    WHERE P.PaymentId = @PaymentId;
END


END;
GO

-- =============================================
-- Payment : Update
-- =============================================
CREATE PROCEDURE usp_Payment_Update
(
@PaymentId INT,
@OrderId INT,
@PaymentMethodID INT,
@AmountPaid DECIMAL(12,2),
@CurrencyID INT,
@PaymentStatus VARCHAR(20),
@TransactionReference NVARCHAR(50),
@Remarks NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Payment
SET
    OrderId = @OrderId,
    PaymentMethodID = @PaymentMethodID,
    AmountPaid = @AmountPaid,
    CurrencyID = @CurrencyID,
    PaymentStatus = @PaymentStatus,
    TransactionReference = @TransactionReference,
    Remarks = @Remarks
WHERE PaymentId = @PaymentId;


END;
GO

-- =============================================
-- Payment : Delete
-- =============================================
CREATE PROCEDURE usp_Payment_Delete
(
@PaymentId INT
)
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM Payment
WHERE PaymentId = @PaymentId;

END;
GO

-- =============================================
-- Shipments : Add
-- =============================================
CREATE PROCEDURE usp_Shipments_Add
(
@OrderId INT,
@ShippingMethodID INT,
@TrackingNumber NVARCHAR(50),
@ShipmentStatus VARCHAR(20),
@Remarks NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Shipments
(
    OrderId,
    ShippingMethodID,
    ShipmentDate,
    TrackingNumber,
    ShipmentStatus,
    Remarks
)
VALUES
(
    @OrderId,
    @ShippingMethodID,
    SYSDATETIME(),
    @TrackingNumber,
    @ShipmentStatus,
    @Remarks
);


END;
GO

-- =============================================
-- Shipments : Get
-- =============================================
CREATE PROCEDURE usp_Shipments_Get
(
@ShipmentId INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @ShipmentId IS NULL
BEGIN
    SELECT
        S.ShipmentId,
        O.OrderId,
        SM.ShippingMethodName,
        S.TrackingNumber,
        S.ShipmentStatus,
        S.ShipmentDate,
        S.Remarks
    FROM Shipments S
    INNER JOIN Orders O
        ON S.OrderId = O.OrderId
    INNER JOIN ShippingMethods SM
        ON S.ShippingMethodID = SM.ShippingMethodID
    ORDER BY S.ShipmentId;
END
ELSE
BEGIN
    SELECT
        S.ShipmentId,
        O.OrderId,
        SM.ShippingMethodName,
        S.TrackingNumber,
        S.ShipmentStatus,
        S.ShipmentDate,
        S.Remarks
    FROM Shipments S
    INNER JOIN Orders O
        ON S.OrderId = O.OrderId
    INNER JOIN ShippingMethods SM
        ON S.ShippingMethodID = SM.ShippingMethodID
    WHERE S.ShipmentId = @ShipmentId;
END


END;
GO

-- =============================================
-- Shipments : Update
-- =============================================
CREATE PROCEDURE usp_Shipments_Update
(
@ShipmentId INT,
@OrderId INT,
@ShippingMethodID INT,
@TrackingNumber NVARCHAR(50),
@ShipmentStatus VARCHAR(20),
@Remarks NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Shipments
SET
    OrderId = @OrderId,
    ShippingMethodID = @ShippingMethodID,
    TrackingNumber = @TrackingNumber,
    ShipmentStatus = @ShipmentStatus,
    Remarks = @Remarks
WHERE ShipmentId = @ShipmentId;


END;
GO

-- =============================================
-- Shipments : Delete
-- =============================================
CREATE PROCEDURE usp_Shipments_Delete
(
@ShipmentId INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Shipments
WHERE ShipmentId = @ShipmentId;


END;

-- =============================================
-- InventoryTransactions : Add
-- =============================================

CREATE PROCEDURE usp_InventoryTransactions_Add
(
@ProductID INT,
@WarehouseID INT,
@TransactionType VARCHAR(10),
@Quantity INT,
@ReferenceType VARCHAR(30),
@ReferenceID INT,
@Remarks NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO InventoryTransactions
(
    ProductID,
    WarehouseID,
    TransactionType,
    Quantity,
    ReferenceType,
    ReferenceID,
    Remarks,
    TransactionDate
)
VALUES
(
    @ProductID,
    @WarehouseID,
    @TransactionType,
    @Quantity,
    @ReferenceType,
    @ReferenceID,
    @Remarks,
    SYSDATETIME()
);


END;
GO

-- =============================================
-- InventoryTransactions : Get
-- =============================================
CREATE PROCEDURE usp_InventoryTransactions_Get
(
@InventoryTransactionID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @InventoryTransactionID IS NULL
BEGIN
    SELECT
        IT.InventoryTransactionID,
        P.ProductCode,
        P.Name AS ProductName,
        W.WarehouseCode,
        IT.TransactionType,
        IT.Quantity,
        IT.ReferenceType,
        IT.ReferenceID,
        IT.TransactionDate,
        IT.Remarks
    FROM InventoryTransactions IT
    INNER JOIN Products P
        ON IT.ProductID = P.ProductID
    INNER JOIN Warehouses W
        ON IT.WarehouseID = W.WarehouseID
    ORDER BY IT.InventoryTransactionID;
END
ELSE
BEGIN
    SELECT
        IT.InventoryTransactionID,
        P.ProductCode,
        P.Name AS ProductName,
        W.WarehouseCode,
        IT.TransactionType,
        IT.Quantity,
        IT.ReferenceType,
        IT.ReferenceID,
        IT.TransactionDate,
        IT.Remarks
    FROM InventoryTransactions IT
    INNER JOIN Products P
        ON IT.ProductID = P.ProductID
    INNER JOIN Warehouses W
        ON IT.WarehouseID = W.WarehouseID
    WHERE IT.InventoryTransactionID = @InventoryTransactionID;
END


END;
GO

-- =============================================
-- InventoryTransactions : Update
-- =============================================
CREATE PROCEDURE usp_InventoryTransactions_Update
(
@InventoryTransactionID INT,
@ProductID INT,
@WarehouseID INT,
@TransactionType VARCHAR(10),
@Quantity INT,
@ReferenceType VARCHAR(30),
@ReferenceID INT,
@Remarks NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE InventoryTransactions
SET
    ProductID = @ProductID,
    WarehouseID = @WarehouseID,
    TransactionType = @TransactionType,
    Quantity = @Quantity,
    ReferenceType = @ReferenceType,
    ReferenceID = @ReferenceID,
    Remarks = @Remarks
WHERE InventoryTransactionID = @InventoryTransactionID;


END;
GO

-- =============================================
-- InventoryTransactions : Delete
-- =============================================
CREATE PROCEDURE usp_InventoryTransactions_Delete
(
@InventoryTransactionID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM InventoryTransactions
WHERE InventoryTransactionID = @InventoryTransactionID;


END;
GO

GO


-- =============================================
-- PurchaseOrders : Add
-- =============================================
CREATE PROCEDURE usp_PurchaseOrders_Add
(
@SupplierID INT,
@ExpectedDate DATE,
@OrderStatus VARCHAR(20),
@TotalAmount DECIMAL(12,2),
@Remarks NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO PurchaseOrders
(
    SupplierID,
    OrderDate,
    ExpectedDate,
    OrderStatus,
    TotalAmount,
    Remarks
)
VALUES
(
    @SupplierID,
    SYSDATETIME(),
    @ExpectedDate,
    @OrderStatus,
    @TotalAmount,
    @Remarks
);


END;
GO

-- =============================================
-- PurchaseOrders : Get
-- =============================================
CREATE PROCEDURE usp_PurchaseOrders_Get
(
@PurchaseOrderID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @PurchaseOrderID IS NULL
BEGIN
    SELECT
        PO.PurchaseOrderID,
        S.SupplierName,
        PO.OrderDate,
        PO.ExpectedDate,
        PO.OrderStatus,
        PO.TotalAmount,
        PO.Remarks
    FROM PurchaseOrders PO
    INNER JOIN Supplier S
        ON PO.SupplierID = S.SupplierID
    ORDER BY PO.PurchaseOrderID;
END
ELSE
BEGIN
    SELECT
        PO.PurchaseOrderID,
        S.SupplierName,
        PO.OrderDate,
        PO.ExpectedDate,
        PO.OrderStatus,
        PO.TotalAmount,
        PO.Remarks
    FROM PurchaseOrders PO
    INNER JOIN Supplier S
        ON PO.SupplierID = S.SupplierID
    WHERE PO.PurchaseOrderID = @PurchaseOrderID;
END

END;
GO

-- =============================================
-- PurchaseOrders : Update
-- =============================================
CREATE PROCEDURE usp_PurchaseOrders_Update
(
@PurchaseOrderID INT,
@SupplierID INT,
@ExpectedDate DATE,
@OrderStatus VARCHAR(20),
@TotalAmount DECIMAL(12,2),
@Remarks NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE PurchaseOrders
SET
    SupplierID = @SupplierID,
    ExpectedDate = @ExpectedDate,
    OrderStatus = @OrderStatus,
    TotalAmount = @TotalAmount,
    Remarks = @Remarks
WHERE PurchaseOrderID = @PurchaseOrderID;


END;
GO

-- =============================================
-- PurchaseOrders : Delete
-- =============================================
CREATE PROCEDURE usp_PurchaseOrders_Delete
(
@PurchaseOrderID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM PurchaseOrders
WHERE PurchaseOrderID = @PurchaseOrderID;


END;

GO


-- =============================================
-- PurchaseOrderItems : Add
-- =============================================
CREATE PROCEDURE usp_PurchaseOrderItems_Add
(
@PurchaseOrderID INT,
@ProductID INT,
@Quantity INT,
@UnitPrice DECIMAL(10,2)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO PurchaseOrderItems
(
    PurchaseOrderID,
    ProductID,
    Quantity,
    UnitPrice
)
VALUES
(
    @PurchaseOrderID,
    @ProductID,
    @Quantity,
    @UnitPrice
);


END;
GO

-- =============================================
-- PurchaseOrderItems : Get
-- =============================================
CREATE PROCEDURE usp_PurchaseOrderItems_Get
(
@PurchaseOrderItemID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @PurchaseOrderItemID IS NULL
BEGIN
    SELECT
        POI.PurchaseOrderItemID,
        PO.PurchaseOrderID,
        P.ProductCode,
        P.Name AS ProductName,
        POI.Quantity,
        POI.UnitPrice,
        (POI.Quantity * POI.UnitPrice) AS TotalPrice
    FROM PurchaseOrderItems POI
    INNER JOIN PurchaseOrders PO
        ON POI.PurchaseOrderID = PO.PurchaseOrderID
    INNER JOIN Products P
        ON POI.ProductID = P.ProductID
    ORDER BY POI.PurchaseOrderItemID;
END
ELSE
BEGIN
    SELECT
        POI.PurchaseOrderItemID,
        PO.PurchaseOrderID,
        P.ProductCode,
        P.Name AS ProductName,
        POI.Quantity,
        POI.UnitPrice,
        (POI.Quantity * POI.UnitPrice) AS TotalPrice
    FROM PurchaseOrderItems POI
    INNER JOIN PurchaseOrders PO
        ON POI.PurchaseOrderID = PO.PurchaseOrderID
    INNER JOIN Products P
        ON POI.ProductID = P.ProductID
    WHERE POI.PurchaseOrderItemID = @PurchaseOrderItemID;
END


END;
GO

-- =============================================
-- PurchaseOrderItems : Update
-- =============================================
CREATE PROCEDURE usp_PurchaseOrderItems_Update
(
@PurchaseOrderItemID INT,
@PurchaseOrderID INT,
@ProductID INT,
@Quantity INT,
@UnitPrice DECIMAL(10,2)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE PurchaseOrderItems
SET
    PurchaseOrderID = @PurchaseOrderID,
    ProductID = @ProductID,
    Quantity = @Quantity,
    UnitPrice = @UnitPrice
WHERE PurchaseOrderItemID = @PurchaseOrderItemID;


END;
GO

-- =============================================
-- PurchaseOrderItems : Delete
-- =============================================
CREATE PROCEDURE usp_PurchaseOrderItems_Delete
(
@PurchaseOrderItemID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM PurchaseOrderItems
WHERE PurchaseOrderItemID = @PurchaseOrderItemID;


END;
GO

-- =============================================
-- Returns : Add
-- =============================================
CREATE PROCEDURE usp_Returns_Add
(
@OrderID INT,
@ReturnStatus VARCHAR(20),
@Remarks NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Returns
(
    OrderID,
    ReturnDate,
    ReturnStatus,
    Remarks
)
VALUES
(
    @OrderID,
    SYSDATETIME(),
    @ReturnStatus,
    @Remarks
);


END;
GO

-- =============================================
-- Returns : Get
-- =============================================
CREATE PROCEDURE usp_Returns_Get
(
@ReturnID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @ReturnID IS NULL
BEGIN
    SELECT
        R.ReturnID,
        O.OrderId,
        R.ReturnDate,
        R.ReturnStatus,
        R.Remarks
    FROM Returns R
    INNER JOIN Orders O
        ON R.OrderID = O.OrderId
    ORDER BY R.ReturnID;
END
ELSE
BEGIN
    SELECT
        R.ReturnID,
        O.OrderId,
        R.ReturnDate,
        R.ReturnStatus,
        R.Remarks
    FROM Returns R
    INNER JOIN Orders O
        ON R.OrderID = O.OrderId
    WHERE R.ReturnID = @ReturnID;
END


END;
GO

-- =============================================
-- Returns : Update
-- =============================================
CREATE PROCEDURE usp_Returns_Update
(
@ReturnID INT,
@OrderID INT,
@ReturnStatus VARCHAR(20),
@Remarks NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Returns
SET
    OrderID = @OrderID,
    ReturnStatus = @ReturnStatus,
    Remarks = @Remarks
WHERE ReturnID = @ReturnID;


END;
GO

-- =============================================
-- Returns : Delete
-- =============================================
CREATE PROCEDURE usp_Returns_Delete
(
@ReturnID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Returns
WHERE ReturnID = @ReturnID;


END;
GO

-- =============================================
-- ReturnItems : Add
-- =============================================
CREATE PROCEDURE usp_ReturnItems_Add
(
@ReturnID INT,
@ProductID INT,
@Quantity INT,
@Reason NVARCHAR(100)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO ReturnItems
(
    ReturnID,
    ProductID,
    Quantity,
    Reason
)
VALUES
(
    @ReturnID,
    @ProductID,
    @Quantity,
    @Reason
);


END;
GO

-- =============================================
-- ReturnItems : Get
-- =============================================
CREATE PROCEDURE usp_ReturnItems_Get
(
@ReturnItemID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @ReturnItemID IS NULL
BEGIN
    SELECT
        RI.ReturnItemID,
        R.ReturnID,
        P.ProductCode,
        P.Name AS ProductName,
        RI.Quantity,
        RI.Reason
    FROM ReturnItems RI
    INNER JOIN Returns R
        ON RI.ReturnID = R.ReturnID
    INNER JOIN Products P
        ON RI.ProductID = P.ProductID
    ORDER BY RI.ReturnItemID;
END
ELSE
BEGIN
    SELECT
        RI.ReturnItemID,
        R.ReturnID,
        P.ProductCode,
        P.Name AS ProductName,
        RI.Quantity,
        RI.Reason
    FROM ReturnItems RI
    INNER JOIN Returns R
        ON RI.ReturnID = R.ReturnID
    INNER JOIN Products P
        ON RI.ProductID = P.ProductID
    WHERE RI.ReturnItemID = @ReturnItemID;
END


END;
GO

-- =============================================
-- ReturnItems : Update
-- =============================================
CREATE PROCEDURE usp_ReturnItems_Update
(
@ReturnItemID INT,
@ReturnID INT,
@ProductID INT,
@Quantity INT,
@Reason NVARCHAR(100)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE ReturnItems
SET
    ReturnID = @ReturnID,
    ProductID = @ProductID,
    Quantity = @Quantity,
    Reason = @Reason
WHERE ReturnItemID = @ReturnItemID;


END;
GO

-- =============================================
-- ReturnItems : Delete
-- =============================================
CREATE PROCEDURE usp_ReturnItems_Delete
(
@ReturnItemID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM ReturnItems
WHERE ReturnItemID = @ReturnItemID;


END;
GO

-- =============================================
-- StockAdjustments : Add
-- =============================================
CREATE PROCEDURE usp_StockAdjustments_Add
(
@ProductID INT,
@WarehouseID INT,
@AdjustmentType VARCHAR(10),
@Quantity INT,
@Reason NVARCHAR(100)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO StockAdjustments
(
    ProductID,
    WarehouseID,
    AdjustmentType,
    Quantity,
    AdjustmentDate,
    Reason
)
VALUES
(
    @ProductID,
    @WarehouseID,
    @AdjustmentType,
    @Quantity,
    SYSDATETIME(),
    @Reason
);


END;
GO

-- =============================================
-- StockAdjustments : Get
-- =============================================
CREATE PROCEDURE usp_StockAdjustments_Get
(
@StockAdjustmentID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;

IF @StockAdjustmentID IS NULL
BEGIN
    SELECT
        SA.StockAdjustmentID,
        P.ProductCode,
        P.Name AS ProductName,
        W.WarehouseCode,
        SA.AdjustmentType,
        SA.Quantity,
        SA.AdjustmentDate,
        SA.Reason
    FROM StockAdjustments SA
    INNER JOIN Products P
        ON SA.ProductID = P.ProductID
    INNER JOIN Warehouses W
        ON SA.WarehouseID = W.WarehouseID
    ORDER BY SA.StockAdjustmentID;
END
ELSE
BEGIN
    SELECT
        SA.StockAdjustmentID,
        P.ProductCode,
        P.Name AS ProductName,
        W.WarehouseCode,
        SA.AdjustmentType,
        SA.Quantity,
        SA.AdjustmentDate,
        SA.Reason
    FROM StockAdjustments SA
    INNER JOIN Products P
        ON SA.ProductID = P.ProductID
    INNER JOIN Warehouses W
        ON SA.WarehouseID = W.WarehouseID
    WHERE SA.StockAdjustmentID = @StockAdjustmentID;
END


END;
GO

-- =============================================
-- StockAdjustments : Update
-- =============================================
CREATE PROCEDURE usp_StockAdjustments_Update
(
@StockAdjustmentID INT,
@ProductID INT,
@WarehouseID INT,
@AdjustmentType VARCHAR(10),
@Quantity INT,
@Reason NVARCHAR(100)
)
AS
BEGIN
SET NOCOUNT ON;

UPDATE StockAdjustments
SET
    ProductID = @ProductID,
    WarehouseID = @WarehouseID,
    AdjustmentType = @AdjustmentType,
    Quantity = @Quantity,
    Reason = @Reason
WHERE StockAdjustmentID = @StockAdjustmentID;


END;
GO

-- =============================================
-- StockAdjustments : Delete
-- =============================================
CREATE PROCEDURE usp_StockAdjustments_Delete
(
@StockAdjustmentID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM StockAdjustments
WHERE StockAdjustmentID = @StockAdjustmentID;

END;
GO

-- =============================================
-- OrderAudit : Add
-- =============================================
CREATE PROCEDURE usp_OrderAudit_Add
(
@OrderID INT,
@ChangedByEmpID INT,
@ChangeType VARCHAR(30),
@OldValue NVARCHAR(200),
@NewValue NVARCHAR(200),
@Remarks NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO OrderAudit
(
    OrderID,
    ChangedByEmpID,
    ChangeType,
    OldValue,
    NewValue,
    ChangeDate,
    Remarks
)
VALUES
(
    @OrderID,
    @ChangedByEmpID,
    @ChangeType,
    @OldValue,
    @NewValue,
    SYSDATETIME(),
    @Remarks
);


END;
GO

-- =============================================
-- OrderAudit : Get
-- =============================================
CREATE PROCEDURE usp_OrderAudit_Get
(
@OrderAuditID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @OrderAuditID IS NULL
BEGIN
    SELECT
        OA.OrderAuditID,
        O.OrderId,
        E.EmployeeId,
        E.EmployeeName,
        OA.ChangeType,
        OA.OldValue,
        OA.NewValue,
        OA.ChangeDate,
        OA.Remarks
    FROM OrderAudit OA
    INNER JOIN Orders O
        ON OA.OrderID = O.OrderId
    LEFT JOIN Employee E
        ON OA.ChangedByEmpID = E.EmployeeId
    ORDER BY OA.OrderAuditID;
END
ELSE
BEGIN
    SELECT
        OA.OrderAuditID,
        O.OrderId,
        E.EmployeeId,
        E.EmployeeName,
        OA.ChangeType,
        OA.OldValue,
        OA.NewValue,
        OA.ChangeDate,
        OA.Remarks
    FROM OrderAudit OA
    INNER JOIN Orders O
        ON OA.OrderID = O.OrderId
    LEFT JOIN Employee E
        ON OA.ChangedByEmpID = E.EmployeeId
    WHERE OA.OrderAuditID = @OrderAuditID;
END


END;
GO

-- =============================================
-- OrderAudit : Update
-- =============================================
CREATE PROCEDURE usp_OrderAudit_Update
(
@OrderAuditID INT,
@OrderID INT,
@ChangedByEmpID INT,
@ChangeType VARCHAR(30),
@OldValue NVARCHAR(200),
@NewValue NVARCHAR(200),
@Remarks NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE OrderAudit
SET
    OrderID = @OrderID,
    ChangedByEmpID = @ChangedByEmpID,
    ChangeType = @ChangeType,
    OldValue = @OldValue,
    NewValue = @NewValue,
    Remarks = @Remarks
WHERE OrderAuditID = @OrderAuditID;


END;
GO

-- =============================================
-- OrderAudit : Delete
-- =============================================
CREATE PROCEDURE usp_OrderAudit_Delete
(
@OrderAuditID INT
)
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM OrderAudit
WHERE OrderAuditID = @OrderAuditID;


END;
GO

-- =============================================
-- InventoryAudit : Add
-- =============================================
CREATE PROCEDURE usp_InventoryAudit_Add
(
@ProductID INT,
@WarehouseID INT,
@OldQuantity INT,
@NewQuantity INT,
@ChangedByEmpID INT,
@Remarks NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO InventoryAudit
(
    ProductID,
    WarehouseID,
    OldQuantity,
    NewQuantity,
    ChangedByEmpID,
    ChangeDate,
    Remarks
)
VALUES
(
    @ProductID,
    @WarehouseID,
    @OldQuantity,
    @NewQuantity,
    @ChangedByEmpID,
    SYSDATETIME(),
    @Remarks
);


END;
GO

-- =============================================
-- InventoryAudit : Get
-- =============================================
CREATE PROCEDURE usp_InventoryAudit_Get
(
@InventoryAuditID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @InventoryAuditID IS NULL
BEGIN
    SELECT
        IA.InventoryAuditID,
        P.ProductCode,
        P.Name AS ProductName,
        W.WarehouseCode,
        IA.OldQuantity,
        IA.NewQuantity,
        IA.ChangeDate,
        E.EmployeeId,
        E.EmployeeName,
        IA.Remarks
    FROM InventoryAudit IA
    INNER JOIN Products P
        ON IA.ProductID = P.ProductID
    INNER JOIN Warehouses W
        ON IA.WarehouseID = W.WarehouseID
    LEFT JOIN Employee E
        ON IA.ChangedByEmpID = E.EmployeeId
    ORDER BY IA.InventoryAuditID;
END
ELSE
BEGIN
    SELECT
        IA.InventoryAuditID,
        P.ProductCode,
        P.Name AS ProductName,
        W.WarehouseCode,
        IA.OldQuantity,
        IA.NewQuantity,
        IA.ChangeDate,
        E.EmployeeId,
        E.EmployeeName,
        IA.Remarks
    FROM InventoryAudit IA
    INNER JOIN Products P
        ON IA.ProductID = P.ProductID
    INNER JOIN Warehouses W
        ON IA.WarehouseID = W.WarehouseID
    LEFT JOIN Employee E
        ON IA.ChangedByEmpID = E.EmployeeId
    WHERE IA.InventoryAuditID = @InventoryAuditID;
END


END;
GO

-- =============================================
-- InventoryAudit : Update
-- =============================================
CREATE PROCEDURE usp_InventoryAudit_Update
(
@InventoryAuditID INT,
@ProductID INT,
@WarehouseID INT,
@OldQuantity INT,
@NewQuantity INT,
@ChangedByEmpID INT,
@Remarks NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE InventoryAudit
SET
    ProductID = @ProductID,
    WarehouseID = @WarehouseID,
    OldQuantity = @OldQuantity,
    NewQuantity = @NewQuantity,
    ChangedByEmpID = @ChangedByEmpID,
    Remarks = @Remarks
WHERE InventoryAuditID = @InventoryAuditID;


END;
GO

-- =============================================
-- InventoryAudit : Delete
-- =============================================
CREATE PROCEDURE usp_InventoryAudit_Delete
(
@InventoryAuditID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM InventoryAudit
WHERE InventoryAuditID = @InventoryAuditID;


END;
GO

-- =============================================
-- SalesTargets : Add
-- =============================================
CREATE PROCEDURE usp_SalesTargets_Add
(
@EmployeeID INT,
@DepartmentID INT,
@TargetPeriod VARCHAR(10),
@TargetMonth TINYINT,
@TargetYear SMALLINT,
@TargetAmount DECIMAL(12,2),
@TargetQuantity INT
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO SalesTargets
(
    EmployeeID,
    DepartmentID,
    TargetPeriod,
    TargetMonth,
    TargetYear,
    TargetAmount,
    TargetQuantity
)
VALUES
(
    @EmployeeID,
    @DepartmentID,
    @TargetPeriod,
    @TargetMonth,
    @TargetYear,
    @TargetAmount,
    @TargetQuantity
);


END;
GO

-- =============================================
-- SalesTargets : Get
-- =============================================
CREATE PROCEDURE usp_SalesTargets_Get
(
@SalesTargetID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @SalesTargetID IS NULL
BEGIN
    SELECT
        ST.SalesTargetID,
        E.EmployeeId,
        E.EmployeeName,
        D.DepartmentName,
        ST.TargetPeriod,
        ST.TargetMonth,
        ST.TargetYear,
        ST.TargetAmount,
        ST.TargetQuantity
    FROM SalesTargets ST
    INNER JOIN Employee E
        ON ST.EmployeeID = E.EmployeeId
    INNER JOIN Department D
        ON ST.DepartmentID = D.DepartmentId
    ORDER BY ST.SalesTargetID;
END
ELSE
BEGIN
    SELECT
        ST.SalesTargetID,
        E.EmployeeId,
        E.EmployeeName,
        D.DepartmentName,
        ST.TargetPeriod,
        ST.TargetMonth,
        ST.TargetYear,
        ST.TargetAmount,
        ST.TargetQuantity
    FROM SalesTargets ST
    INNER JOIN Employee E
        ON ST.EmployeeID = E.EmployeeId
    INNER JOIN Department D
        ON ST.DepartmentID = D.DepartmentId
    WHERE ST.SalesTargetID = @SalesTargetID;
END


END;
GO

-- =============================================
-- SalesTargets : Update
-- =============================================
CREATE PROCEDURE usp_SalesTargets_Update
(
@SalesTargetID INT,
@EmployeeID INT,
@DepartmentID INT,
@TargetPeriod VARCHAR(10),
@TargetMonth TINYINT,
@TargetYear SMALLINT,
@TargetAmount DECIMAL(12,2),
@TargetQuantity INT
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE SalesTargets
SET
    EmployeeID = @EmployeeID,
    DepartmentID = @DepartmentID,
    TargetPeriod = @TargetPeriod,
    TargetMonth = @TargetMonth,
    TargetYear = @TargetYear,
    TargetAmount = @TargetAmount,
    TargetQuantity = @TargetQuantity
WHERE SalesTargetID = @SalesTargetID;


END;
GO

-- =============================================
-- SalesTargets : Delete
-- =============================================
CREATE PROCEDURE usp_SalesTargets_Delete
(
@SalesTargetID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM SalesTargets
WHERE SalesTargetID = @SalesTargetID;


END;
GO

-- =============================================
-- CustomerFeedback : Add
-- =============================================
CREATE PROCEDURE usp_CustomerFeedback_Add
(
@CustomerID INT,
@OrderID INT = NULL,
@Rating TINYINT,
@Comments NVARCHAR(300)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO CustomerFeedback
(
    CustomerID,
    OrderID,
    Rating,
    Comments,
    FeedbackDate
)
VALUES
(
    @CustomerID,
    @OrderID,
    @Rating,
    @Comments,
    SYSDATETIME()
);


END;
GO

-- =============================================
-- CustomerFeedback : Get
-- =============================================
CREATE PROCEDURE usp_CustomerFeedback_Get
(
@FeedbackID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @FeedbackID IS NULL
BEGIN
    SELECT
        CF.FeedbackID,
        C.CustomerId,
        C.NAME AS CustomerName,
        O.OrderId,
        CF.Rating,
        CF.Comments,
        CF.FeedbackDate
    FROM CustomerFeedback CF
    INNER JOIN Customer C
        ON CF.CustomerID = C.CustomerId
    LEFT JOIN Orders O
        ON CF.OrderID = O.OrderId
    ORDER BY CF.FeedbackID;
END
ELSE
BEGIN
    SELECT
        CF.FeedbackID,
        C.CustomerId,
        C.NAME AS CustomerName,
        O.OrderId,
        CF.Rating,
        CF.Comments,
        CF.FeedbackDate
    FROM CustomerFeedback CF
    INNER JOIN Customer C
        ON CF.CustomerID = C.CustomerId
    LEFT JOIN Orders O
        ON CF.OrderID = O.OrderId
    WHERE CF.FeedbackID = @FeedbackID;
END


END;
GO

-- =============================================
-- CustomerFeedback : Update
-- =============================================
CREATE PROCEDURE usp_CustomerFeedback_Update
(
@FeedbackID INT,
@CustomerID INT,
@OrderID INT = NULL,
@Rating TINYINT,
@Comments NVARCHAR(300)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE CustomerFeedback
SET
    CustomerID = @CustomerID,
    OrderID = @OrderID,
    Rating = @Rating,
    Comments = @Comments
WHERE FeedbackID = @FeedbackID;


END;
GO

-- =============================================
-- CustomerFeedback : Delete
-- =============================================
CREATE PROCEDURE usp_CustomerFeedback_Delete
(
@FeedbackID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM CustomerFeedback
WHERE FeedbackID = @FeedbackID;


END;
GO

-- =============================================
-- EmployeePerformance : Add
-- =============================================
CREATE PROCEDURE usp_EmployeePerformance_Add
(
@EmployeeID INT,
@KPIName VARCHAR(50),
@KPIValue DECIMAL(12,2),
@PeriodStart DATE,
@PeriodEnd DATE
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO EmployeePerformance
(
    EmployeeID,
    KPIName,
    KPIValue,
    PeriodStart,
    PeriodEnd,
    RecordedDate
)
VALUES
(
    @EmployeeID,
    @KPIName,
    @KPIValue,
    @PeriodStart,
    @PeriodEnd,
    SYSDATETIME()
);


END;
GO

-- =============================================
-- EmployeePerformance : Get
-- =============================================
CREATE PROCEDURE usp_EmployeePerformance_Get
(
@PerformanceID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @PerformanceID IS NULL
BEGIN
    SELECT
        EP.PerformanceID,
        E.EmployeeId,
        E.EmployeeName,
        EP.KPIName,
        EP.KPIValue,
        EP.PeriodStart,
        EP.PeriodEnd,
        EP.RecordedDate
    FROM EmployeePerformance EP
    INNER JOIN Employee E
        ON EP.EmployeeID = E.EmployeeId
    ORDER BY EP.PerformanceID;
END
ELSE
BEGIN
    SELECT
        EP.PerformanceID,
        E.EmployeeId,
        E.EmployeeName,
        EP.KPIName,
        EP.KPIValue,
        EP.PeriodStart,
        EP.PeriodEnd,
        EP.RecordedDate
    FROM EmployeePerformance EP
    INNER JOIN Employee E
        ON EP.EmployeeID = E.EmployeeId
    WHERE EP.PerformanceID = @PerformanceID;
END


END;
GO

-- =============================================
-- EmployeePerformance : Update
-- =============================================
CREATE PROCEDURE usp_EmployeePerformance_Update
(
@PerformanceID INT,
@EmployeeID INT,
@KPIName VARCHAR(50),
@KPIValue DECIMAL(12,2),
@PeriodStart DATE,
@PeriodEnd DATE
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE EmployeePerformance
SET
    EmployeeID = @EmployeeID,
    KPIName = @KPIName,
    KPIValue = @KPIValue,
    PeriodStart = @PeriodStart,
    PeriodEnd = @PeriodEnd
WHERE PerformanceID = @PerformanceID;


END;
GO

-- =============================================
-- EmployeePerformance : Delete
-- =============================================
CREATE PROCEDURE usp_EmployeePerformance_Delete
(
@PerformanceID INT
)
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM EmployeePerformance
WHERE PerformanceID = @PerformanceID;

END;
GO

-- =============================================
-- ErrorLog : Add
-- =============================================
CREATE PROCEDURE usp_ErrorLog_Add
(
@ErrorMessage NVARCHAR(400),
@ErrorSource VARCHAR(100),
@ErrorSeverity VARCHAR(20),
@StackTrace NVARCHAR(MAX),
@UserID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO ErrorLog
(
    ErrorMessage,
    ErrorSource,
    ErrorSeverity,
    StackTrace,
    OccurredOn,
    UserID
)
VALUES
(
    @ErrorMessage,
    @ErrorSource,
    @ErrorSeverity,
    @StackTrace,
    SYSDATETIME(),
    @UserID
);


END;
GO

-- =============================================
-- ErrorLog : Get
-- =============================================
CREATE PROCEDURE usp_ErrorLog_Get
(
@ErrorLogID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @ErrorLogID IS NULL
BEGIN
    SELECT
        EL.ErrorLogID,
        EL.ErrorMessage,
        EL.ErrorSource,
        EL.ErrorSeverity,
        EL.StackTrace,
        EL.OccurredOn,
        EL.UserID
    FROM ErrorLog EL
    ORDER BY EL.ErrorLogID DESC;
END
ELSE
BEGIN
    SELECT
        EL.ErrorLogID,
        EL.ErrorMessage,
        EL.ErrorSource,
        EL.ErrorSeverity,
        EL.StackTrace,
        EL.OccurredOn,
        EL.UserID
    FROM ErrorLog EL
    WHERE EL.ErrorLogID = @ErrorLogID;
END


END;
GO

-- =============================================
-- ErrorLog : Update
-- (Not recommended but included for completeness)
-- =============================================
CREATE PROCEDURE usp_ErrorLog_Update
(
@ErrorLogID INT,
@ErrorMessage NVARCHAR(400),
@ErrorSource VARCHAR(100),
@ErrorSeverity VARCHAR(20),
@StackTrace NVARCHAR(MAX),
@UserID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE ErrorLog
SET
    ErrorMessage = @ErrorMessage,
    ErrorSource = @ErrorSource,
    ErrorSeverity = @ErrorSeverity,
    StackTrace = @StackTrace,
    UserID = @UserID
WHERE ErrorLogID = @ErrorLogID;


END;
GO

-- =============================================
-- ErrorLog : Delete
-- (Usually restricted in production systems)
-- =============================================
CREATE PROCEDURE usp_ErrorLog_Delete
(
@ErrorLogID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM ErrorLog
WHERE ErrorLogID = @ErrorLogID;


END;
GO


-- =============================================
-- Promotions : Add
-- =============================================
CREATE PROCEDURE usp_Promotions_Add
(
@PromotionName NVARCHAR(100),
@DiscountType VARCHAR(20),
@DiscountValue DECIMAL(8,2),
@StartDate DATE,
@EndDate DATE,
@IsActive BIT
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Promotions
(
    PromotionName,
    DiscountType,
    DiscountValue,
    StartDate,
    EndDate,
    IsActive
)
VALUES
(
    @PromotionName,
    @DiscountType,
    @DiscountValue,
    @StartDate,
    @EndDate,
    @IsActive
);


END;
GO

-- =============================================
-- Promotions : Get
-- =============================================
CREATE PROCEDURE usp_Promotions_Get
(
@PromotionID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @PromotionID IS NULL
BEGIN
    SELECT
        PromotionID,
        PromotionName,
        DiscountType,
        DiscountValue,
        StartDate,
        EndDate,
        IsActive
    FROM Promotions
    ORDER BY PromotionID DESC;
END
ELSE
BEGIN
    SELECT
        PromotionID,
        PromotionName,
        DiscountType,
        DiscountValue,
        StartDate,
        EndDate,
        IsActive
    FROM Promotions
    WHERE PromotionID = @PromotionID;
END


END;
GO

-- =============================================
-- Promotions : Update
-- =============================================
CREATE PROCEDURE usp_Promotions_Update
(
@PromotionID INT,
@PromotionName NVARCHAR(100),
@DiscountType VARCHAR(20),
@DiscountValue DECIMAL(8,2),
@StartDate DATE,
@EndDate DATE,
@IsActive BIT
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Promotions
SET
    PromotionName = @PromotionName,
    DiscountType = @DiscountType,
    DiscountValue = @DiscountValue,
    StartDate = @StartDate,
    EndDate = @EndDate,
    IsActive = @IsActive
WHERE PromotionID = @PromotionID;


END;
GO

-- =============================================
-- Promotions : Delete
-- =============================================
CREATE PROCEDURE usp_Promotions_Delete
(
@PromotionID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Promotions
WHERE PromotionID = @PromotionID;


END;
GO

-- =============================================
-- Campaigns : Add
-- =============================================
CREATE PROCEDURE usp_Campaigns_Add
(
@CampaignName NVARCHAR(100),
@CampaignType VARCHAR(30),
@StartDate DATE,
@EndDate DATE,
@Budget DECIMAL(12,2)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO Campaigns
(
    CampaignName,
    CampaignType,
    StartDate,
    EndDate,
    Budget,
    CreatedDate
)
VALUES
(
    @CampaignName,
    @CampaignType,
    @StartDate,
    @EndDate,
    @Budget,
    SYSDATETIME()
);


END;
GO

-- =============================================
-- Campaigns : Get
-- =============================================
CREATE PROCEDURE usp_Campaigns_Get
(
@CampaignID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @CampaignID IS NULL
BEGIN
    SELECT
        CampaignID,
        CampaignName,
        CampaignType,
        StartDate,
        EndDate,
        Budget,
        CreatedDate
    FROM Campaigns
    ORDER BY CampaignID DESC;
END
ELSE
BEGIN
    SELECT
        CampaignID,
        CampaignName,
        CampaignType,
        StartDate,
        EndDate,
        Budget,
        CreatedDate
    FROM Campaigns
    WHERE CampaignID = @CampaignID;
END


END;
GO

-- =============================================
-- Campaigns : Update
-- =============================================
CREATE PROCEDURE usp_Campaigns_Update
(
@CampaignID INT,
@CampaignName NVARCHAR(100),
@CampaignType VARCHAR(30),
@StartDate DATE,
@EndDate DATE,
@Budget DECIMAL(12,2)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE Campaigns
SET
    CampaignName = @CampaignName,
    CampaignType = @CampaignType,
    StartDate = @StartDate,
    EndDate = @EndDate,
    Budget = @Budget
WHERE CampaignID = @CampaignID;


END;
GO

-- =============================================
-- Campaigns : Delete
-- =============================================
CREATE PROCEDURE usp_Campaigns_Delete
(
@CampaignID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM Campaigns
WHERE CampaignID = @CampaignID;


END;
GO

-- =============================================
-- CampaignResponses : Add
-- =============================================
CREATE PROCEDURE usp_CampaignResponses_Add
(
@CampaignID INT,
@CustomerID INT,
@ResponseType VARCHAR(20)
)
AS
BEGIN
SET NOCOUNT ON;


INSERT INTO CampaignResponses
(
    CampaignID,
    CustomerID,
    ResponseType,
    ResponseDate
)
VALUES
(
    @CampaignID,
    @CustomerID,
    @ResponseType,
    SYSDATETIME()
);


END;
GO

-- =============================================
-- CampaignResponses : Get
-- =============================================
CREATE PROCEDURE usp_CampaignResponses_Get
(
@ResponseID INT = NULL
)
AS
BEGIN
SET NOCOUNT ON;


IF @ResponseID IS NULL
BEGIN
    SELECT
        CR.ResponseID,
        C.CampaignName,
        CU.NAME AS CustomerName,
        CR.ResponseType,
        CR.ResponseDate
    FROM CampaignResponses CR
    INNER JOIN Campaigns C
        ON CR.CampaignID = C.CampaignID
    INNER JOIN Customer CU
        ON CR.CustomerID = CU.CustomerId
    ORDER BY CR.ResponseID DESC;
END
ELSE
BEGIN
    SELECT
        CR.ResponseID,
        C.CampaignName,
        CU.NAME AS CustomerName,
        CR.ResponseType,
        CR.ResponseDate
    FROM CampaignResponses CR
    INNER JOIN Campaigns C
        ON CR.CampaignID = C.CampaignID
    INNER JOIN Customer CU
        ON CR.CustomerID = CU.CustomerId
    WHERE CR.ResponseID = @ResponseID;
END


END;
GO

-- =============================================
-- CampaignResponses : Update
-- =============================================
CREATE PROCEDURE usp_CampaignResponses_Update
(
@ResponseID INT,
@CampaignID INT,
@CustomerID INT,
@ResponseType VARCHAR(20)
)
AS
BEGIN
SET NOCOUNT ON;


UPDATE CampaignResponses
SET
    CampaignID = @CampaignID,
    CustomerID = @CustomerID,
    ResponseType = @ResponseType
WHERE ResponseID = @ResponseID;


END;
GO

-- =============================================
-- CampaignResponses : Delete
-- =============================================
CREATE PROCEDURE usp_CampaignResponses_Delete
(
@ResponseID INT
)
AS
BEGIN
SET NOCOUNT ON;


DELETE FROM CampaignResponses
WHERE ResponseID = @ResponseID;


END;
GO


