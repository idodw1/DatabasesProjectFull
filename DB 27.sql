USE [master]
GO

/****** Object:  Database [PART C]    Script Date: 25/06/2022 23:54:23 ******/
CREATE DATABASE [PART C]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PART C', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\PART C.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PART C_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\PART C_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

--  Tables:
CREATE TABLE CUSTOMERS(
		Email			varchar(40) primary key	not null,
		FirstName		varchar(20)				not null,
		LastName		varchar(20)				not null,
		AdressCountry		varchar(20)				not null,
		AdressCity		varchar(20)				not null,
		AdressZipcode		varchar(20)				not null,
		AdressNumber		Integer					not null,
		Phone			varchar(10)				not null
		)

		ALTER TABLE CUSTOMERS ADD AdressStreet varchar(20)
		ALTER TABLE CUSTOMERS ADD IPAdress varchar(32)
		ALTER TABLE Customers	
		ADD CONSTRAINT fk_IPADRESS
		FOREIGN KEY (IPAdress)
		REFERENCES VISITORS(IPAdress) 

ALTER TABLE CUSTOMERS Add Constraint CK_EMAIL CHECK (Email LIKE '%@%')

CREATE TABLE VISITORS(
		IPAdress		varchar(32) primary key	not null,
		)

CREATE TABLE CREDITCARDS(
		Number			varchar(16)	primary key	not null,
		CreditType		varchar(16)				not null,
		ExpirationYear	Integer					not null,				
		ExpirationMonth	Integer					not null,
		CVV				Integer					not null,
		Email			Varchar(40)				not null,

		FOREIGN KEY (Email) 
		REFERENCES CusTomers(Email) 
		)

ALTER TABLE CREDITCARDS Add Constraint CK_EXP_MONTH CHECK (ExpirationMonth>0 AND ExpirationMonth<13)
ALTER TABLE CREDITCARDS Add Constraint CK_YEAR CHECK (ExpirationYear>2021 AND ExpirationMonth<2030 )
ALTER TABLE CREDITCARDS ADD CREDITTYPE varchar(16) 

CREATE TABLE PRODUCTS(
		ProductID		Integer primary key		not null,	
		ProductName		Varchar(40)				not null,
		Price			Integer					not null,
		Category		Integer					not null,
		)

		ALTER TABLE PRODUCTS ALTER COLUMN CATEGORY VARCHAR(20)

ALTER TABLE PRODUCTS Add Constraint CK_PRICE CHECK (Price>0)

CREATE TABLE PERSONALDESIGNS(
		DesignID		Integer					not null,
		Size			char(1)					not null,
		Color			varChar(20)				not null,
		IconNumber		Integer					not null,
		IconChoices		Varchar(20)				not null,
		IconNames		VarChar(20)				not null,
		ProductID		Integer

		FOREIGN KEY (ProductID) 
		REFERENCES  PRODUCTS(ProductID) 
)



CREATE TABLE ORDERS(
		OrderID         Integer primary key	not null,
		Email           Varchar(40)			not null,
		Number          Varchar(16)			not null,
		DT				Datetime			not null,
)

		ALTER TABLE ORDERS	
		ADD CONSTRAINT fk_email
		FOREIGN KEY (Email)
		REFERENCES CusTomers(Email) ,
		
		ALTER TABLE ORDERS	
		ADD CONSTRAINT fk_number
		FOREIGN KEY (Number) 
		REFERENCES  CREDITCARDS(NUMBER) 

CREATE TABLE SEARCHES(
		IPID           Varchar(32) primary key	not null,
		KeyWord		   Varchar(20)				not null,
		DT             Datetime					not null,
		Email		   Varchar(40)				not null,

)

		Alter Table Searches
		add constraint fk_ipidsSecond
		foreign key (IPID)
		REFEReNCES VISITORS(IPAdress)

		ALTER TABLE Searches
		add Unique (DT);

CREATE TABLE EXIST(
		ProductID		Integer					not null,
		OrderID			Integer PRIMARY KEY		not null,

		FOREIGN KEY (OrderID)
		REFERENCES Orders(OrderID)
)

CREATE TABLE APPEARS(
		ProductID		Integer	Primary key		not null,
		IPID			Varchar(32)				not null,
		DT				Datetime				not null,
)

		ALTER TABLE APPEARS	
		ADD CONSTRAINT fk_Product
		FOREIGN KEY (ProductID)
		REFERENCES Products(ProductID) ,
		
		ALTER TABLE ORDERS	
		ADD CONSTRAINT fk_numberForAppears
		FOREIGN KEY (Number) 
		REFERENCES  CREDITCARDS(NUMBER) 

		ALTER TABLE Searches	
		ADD CONSTRAINT fk_IPID
		FOREIGN KEY (IPID) 
		REFERENCES  Searches(IPID)

		ALTER TABLE APPEARS
		add constraint fk_IPIDthird
		foreign key (IPID)
		REFERENCES Searches(IPID)

		ALTER TABLE APPEARS
		add constraint fk_DT
		foreign key (DT)
		REFERENCES Searches(DT)

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PART C].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [PART C] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [PART C] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [PART C] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [PART C] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [PART C] SET ARITHABORT OFF 
GO

ALTER DATABASE [PART C] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [PART C] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [PART C] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [PART C] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [PART C] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [PART C] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [PART C] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [PART C] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [PART C] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [PART C] SET  DISABLE_BROKER 
GO

ALTER DATABASE [PART C] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [PART C] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [PART C] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [PART C] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [PART C] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [PART C] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [PART C] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [PART C] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [PART C] SET  MULTI_USER 
GO

ALTER DATABASE [PART C] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [PART C] SET DB_CHAINING OFF 
GO

ALTER DATABASE [PART C] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [PART C] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [PART C] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [PART C] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [PART C] SET QUERY_STORE = OFF
GO

ALTER DATABASE [PART C] SET  READ_WRITE 
GO

