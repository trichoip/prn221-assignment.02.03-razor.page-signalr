USE [master]
GO
/****** Object:  Database [FlowerManagement]    Script Date: 30/06/2023 10:37:14 PM ******/
CREATE DATABASE [FlowerManagement]
GO
ALTER DATABASE [FlowerManagement] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FlowerManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FlowerManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FlowerManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FlowerManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FlowerManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FlowerManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [FlowerManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FlowerManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FlowerManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FlowerManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FlowerManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FlowerManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FlowerManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FlowerManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FlowerManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FlowerManagement] SET  ENABLE_BROKER 
GO
ALTER DATABASE [FlowerManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FlowerManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FlowerManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FlowerManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FlowerManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FlowerManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FlowerManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FlowerManagement] SET RECOVERY FULL 
GO
ALTER DATABASE [FlowerManagement] SET  MULTI_USER 
GO
ALTER DATABASE [FlowerManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FlowerManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FlowerManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FlowerManagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FlowerManagement] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FlowerManagement] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'FlowerManagement', N'ON'
GO
ALTER DATABASE [FlowerManagement] SET QUERY_STORE = OFF
GO
USE [FlowerManagement]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 30/06/2023 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](40) NULL,
	[CategoryDescription] [nvarchar](150) NULL,
 CONSTRAINT [PK__Category__19093A2BBDEA5A41] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 30/06/2023 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](100) NULL,
	[CustomerName] [varchar](180) NULL,
	[City] [varchar](15) NULL,
	[Country] [varchar](15) NULL,
	[Password] [varchar](30) NULL,
	[Birthday] [date] NULL,
 CONSTRAINT [PK__Customer__A4AE64B844FBC2C5] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FlowerBouquet]    Script Date: 30/06/2023 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlowerBouquet](
	[FlowerBouquetID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NULL,
	[FlowerBouquetName] [varchar](40) NULL,
	[Description] [varchar](220) NULL,
	[UnitPrice] [money] NULL,
	[UnitsInStock] [int] NULL,
	[FlowerBouquetStatus] [tinyint] NULL,
	[SupplierID] [int] NULL,
 CONSTRAINT [PK__FlowerBo__A13913015C29CF80] PRIMARY KEY CLUSTERED 
(
	[FlowerBouquetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 30/06/2023 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[Total] [money] NULL,
	[OrderStatus] [nchar](10) NULL,
 CONSTRAINT [PK__Order__C3905BAF5A986666] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 30/06/2023 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderID] [int] NOT NULL,
	[FlowerBouquetID] [int] NOT NULL,
	[UnitPrice] [money] NULL,
	[Quantity] [int] NULL,
	[Discount] [float] NULL,
 CONSTRAINT [PK__OrderDet__C983CA9F92C9BB43] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[FlowerBouquetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 30/06/2023 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierName] [nvarchar](50) NULL,
	[SupplierAddress] [nvarchar](150) NULL,
	[Telephone] [nchar](15) NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 
GO
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryDescription]) VALUES (1, N'Hand-tied bouquets', N'This type of bouquet is made by gathering flowers and foliage in a natural, unstructured way, then tying them together with ribbon or twine.')
GO
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryDescription]) VALUES (2, N'Posy bouquets', N'Posy bouquets are small, compact bouquets that are often used for bridesmaids or as a toss bouquet.')
GO
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryDescription]) VALUES (3, N'Cascading bouquets', N'These bouquets feature flowers that trail down in a cascading shape, often with a mix of different types of flowers and foliage.')
GO
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryDescription]) VALUES (4, N'Presentation bouquets', N'These bouquets are often long-stemmed and held upright, such as when presenting flowers to a performer or as a gift to someone.')
GO
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryDescription]) VALUES (5, N'Nosegay bouquets', N'Nosegay bouquets are dense, circular bouquets that are often used for weddings and feature a mix of different types of flowers and foliage.')
GO
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 
GO
INSERT [dbo].[Customer] ([CustomerID], [Email], [CustomerName], [City], [Country], [Password], [Birthday]) VALUES (1, N'admin', N'David Copperfield', N'HCM', N'Viet Nam', N'1', CAST(N'1990-02-02' AS Date))
GO
INSERT [dbo].[Customer] ([CustomerID], [Email], [CustomerName], [City], [Country], [Password], [Birthday]) VALUES (2, N'StevenAllanSpielber@fuflowerbouquetsystem.com', N'Steven Allan Spielber', N'HCM', N'Viet Nam', N'1', CAST(N'1999-05-05' AS Date))
GO
INSERT [dbo].[Customer] ([CustomerID], [Email], [CustomerName], [City], [Country], [Password], [Birthday]) VALUES (3, N'RobertCapshaw@fuflowerbouquetsystem.com', N'Robert Capshaw', N'London', N'UK', N'1', CAST(N'1988-05-09' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[FlowerBouquet] ON 
GO
INSERT [dbo].[FlowerBouquet] ([FlowerBouquetID], [CategoryID], [FlowerBouquetName], [Description], [UnitPrice], [UnitsInStock], [FlowerBouquetStatus], [SupplierID]) VALUES (1, 1, N'A New Day', N'Flowers to put a smile on their face. Let them know that you''re thinking of them with this fun petite collection of flowers and foliage to send same day. ', 100.0000, 10, 1, 1)
GO
INSERT [dbo].[FlowerBouquet] ([FlowerBouquetID], [CategoryID], [FlowerBouquetName], [Description], [UnitPrice], [UnitsInStock], [FlowerBouquetStatus], [SupplierID]) VALUES (2, 1, N'Hello', N'Say hello in style with this fabulous hand-tied.', 120.0000, 10, 1, 2)
GO
INSERT [dbo].[FlowerBouquet] ([FlowerBouquetID], [CategoryID], [FlowerBouquetName], [Description], [UnitPrice], [UnitsInStock], [FlowerBouquetStatus], [SupplierID]) VALUES (3, 2, N'Splash of Colour', N'A vibrant gerbera posy hand-tied featuring a mix of colours carefully selected by the local florist. Hand-delivered in a gift bag or box.', 230.0000, 10, 1, 2)
GO
INSERT [dbo].[FlowerBouquet] ([FlowerBouquetID], [CategoryID], [FlowerBouquetName], [Description], [UnitPrice], [UnitsInStock], [FlowerBouquetStatus], [SupplierID]) VALUES (4, 2, N'Lemon & Lime', N'A beautiful collection of flowers simply wrapped and ready to arrange.
', 140.0000, 10, 1, 1)
GO
INSERT [dbo].[FlowerBouquet] ([FlowerBouquetID], [CategoryID], [FlowerBouquetName], [Description], [UnitPrice], [UnitsInStock], [FlowerBouquetStatus], [SupplierID]) VALUES (5, 3, N'Mother''s Day', N'Let the experts work their magic with a unique Mother’s Day gift.', 160.0000, 5, 1, 1)
GO
INSERT [dbo].[FlowerBouquet] ([FlowerBouquetID], [CategoryID], [FlowerBouquetName], [Description], [UnitPrice], [UnitsInStock], [FlowerBouquetStatus], [SupplierID]) VALUES (6, 1, N'Pink Roses', N'Vase of pink roses with mixed foliages and white waxflower', 175.0000, 5, 1, 1)
GO
INSERT [dbo].[FlowerBouquet] ([FlowerBouquetID], [CategoryID], [FlowerBouquetName], [Description], [UnitPrice], [UnitsInStock], [FlowerBouquetStatus], [SupplierID]) VALUES (7, 1, N'Cool Breeze', N'This classical stylish collection of flowers make this hand tied the perfect gift. Professionally arranged and delivered by a local florist. Available for same day delivery when ordered before 2pm.', 120.0000, 10, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[FlowerBouquet] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 
GO
INSERT [dbo].[Order] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [Total], [OrderStatus]) VALUES (4000, 1, CAST(N'2023-04-26T00:00:00.000' AS DateTime), CAST(N'2023-04-27T00:00:00.000' AS DateTime), 670.0000, N'Done      ')
GO
INSERT [dbo].[Order] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [Total], [OrderStatus]) VALUES (4001, 2, CAST(N'2023-04-26T00:00:00.000' AS DateTime), CAST(N'2023-04-27T00:00:00.000' AS DateTime), 295.0000, N'Done      ')
GO
INSERT [dbo].[Order] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [Total], [OrderStatus]) VALUES (4002, 1, CAST(N'2023-04-29T00:00:00.000' AS DateTime), CAST(N'2023-04-30T00:00:00.000' AS DateTime), 510.0000, N'Done      ')
GO
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
INSERT [dbo].[OrderDetail] ([OrderID], [FlowerBouquetID], [UnitPrice], [Quantity], [Discount]) VALUES (4000, 1, 100.0000, 2, 0)
GO
INSERT [dbo].[OrderDetail] ([OrderID], [FlowerBouquetID], [UnitPrice], [Quantity], [Discount]) VALUES (4000, 2, 120.0000, 2, 0)
GO
INSERT [dbo].[OrderDetail] ([OrderID], [FlowerBouquetID], [UnitPrice], [Quantity], [Discount]) VALUES (4000, 3, 230.0000, 1, 0)
GO
INSERT [dbo].[OrderDetail] ([OrderID], [FlowerBouquetID], [UnitPrice], [Quantity], [Discount]) VALUES (4001, 1, 120.0000, 1, 0)
GO
INSERT [dbo].[OrderDetail] ([OrderID], [FlowerBouquetID], [UnitPrice], [Quantity], [Discount]) VALUES (4001, 6, 175.0000, 1, 0)
GO
INSERT [dbo].[OrderDetail] ([OrderID], [FlowerBouquetID], [UnitPrice], [Quantity], [Discount]) VALUES (4002, 3, 230.0000, 1, 0)
GO
INSERT [dbo].[OrderDetail] ([OrderID], [FlowerBouquetID], [UnitPrice], [Quantity], [Discount]) VALUES (4002, 4, 140.0000, 2, 0)
GO
SET IDENTITY_INSERT [dbo].[Supplier] ON 
GO
INSERT [dbo].[Supplier] ([SupplierID], [SupplierName], [SupplierAddress], [Telephone]) VALUES (1, N'007 Flower', N'142A Vo Thi Sau Street, Ward 12, District 3, HCMC', N'1800 6102      ')
GO
INSERT [dbo].[Supplier] ([SupplierID], [SupplierName], [SupplierAddress], [Telephone]) VALUES (2, N'Flower Lovers', N'09 3/2 Street, Ward 11, District 10, HCMC', N'093 204 05 15  ')
GO
INSERT [dbo].[Supplier] ([SupplierID], [SupplierName], [SupplierAddress], [Telephone]) VALUES (3, N'Love Florist', N'3 Tran Quoc Thao Streed, Ward 6, District 3, HCMC', N'093 888 61 02  ')
GO
SET IDENTITY_INSERT [dbo].[Supplier] OFF
GO
ALTER TABLE [dbo].[FlowerBouquet]  WITH CHECK ADD  CONSTRAINT [FK__FlowerBou__Categ__2E1BDC42] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FlowerBouquet] CHECK CONSTRAINT [FK__FlowerBou__Categ__2E1BDC42]
GO
ALTER TABLE [dbo].[FlowerBouquet]  WITH CHECK ADD  CONSTRAINT [FK__FlowerBou__Suppl__2F10007B] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Supplier] ([SupplierID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FlowerBouquet] CHECK CONSTRAINT [FK__FlowerBou__Suppl__2F10007B]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK__Order__CustomerI__300424B4] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK__Order__CustomerI__300424B4]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK__OrderDeta__Flowe__30F848ED] FOREIGN KEY([FlowerBouquetID])
REFERENCES [dbo].[FlowerBouquet] ([FlowerBouquetID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK__OrderDeta__Flowe__30F848ED]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK__OrderDeta__Order__31EC6D26] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK__OrderDeta__Order__31EC6D26]
GO
USE [master]
GO
ALTER DATABASE [FlowerManagement] SET  READ_WRITE 
GO
