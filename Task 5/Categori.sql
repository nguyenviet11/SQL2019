USE north

CREATE TABLE Categories
(CategoriID INT IDENTITY(1,1) NOT NULL,
CategoryName varchar(20) NOT NULL,
Description varchar(200),
CONSTRAINT cate PRIMARY KEY (CategoriID)
)
Go
set identity_insert "Categories" on 
GO
INSERT "Categories" ("CategoriID","CategoryName","Description") VALUES(1,'Beverages','Soft drinks, coffees, teas, beers, and ales')
INSERT "Categories" ("CategoriID","CategoryName","Description") VALUES(2,'Condiments','Sweet and savory sauces, relishes, spreads, and seasonings')
INSERT "Categories" ("CategoriID","CategoryName","Description") VALUES(3,'Confections','Desserts, candies, and sweet breads')
INSERT "Categories" ("CategoriID","CategoryName","Description") VALUES(4,'Dairy Products','Cheeses')
INSERT "Categories" ("CategoriID","CategoryName","Description") VALUES(5,'Grains/Cereals','Breads, crackers, pasta, and cereal')
INSERT "Categories" ("CategoriID","CategoryName","Description") VALUES(6,'Meat/Poultry','Prepared meats')
INSERT "Categories" ("CategoriID","CategoryName","Description") VALUES(7,'Produce','Dried fruit and bean curd')
INSERT "Categories" ("CategoriID","CategoryName","Description") VALUES(8,'Seafood','Seaweed and fish')
GO
select * from Categories

