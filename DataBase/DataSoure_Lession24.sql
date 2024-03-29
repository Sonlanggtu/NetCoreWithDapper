USE [master]
GO
/****** Object:  Database [RestAPIDapper]    Script Date: 7/13/2019 10:49:33 PM ******/
CREATE DATABASE [RestAPIDapper]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RestAPIDapper', FILENAME = N'F:\Setup\SQL Server\Root directory\MSSQL13.MSSQLSERVER\MSSQL\DATA\RestAPIDapper.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RestAPIDapper_log', FILENAME = N'F:\Setup\SQL Server\Root directory\MSSQL13.MSSQLSERVER\MSSQL\DATA\RestAPIDapper_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [RestAPIDapper] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RestAPIDapper].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RestAPIDapper] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RestAPIDapper] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RestAPIDapper] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RestAPIDapper] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RestAPIDapper] SET ARITHABORT OFF 
GO
ALTER DATABASE [RestAPIDapper] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RestAPIDapper] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RestAPIDapper] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RestAPIDapper] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RestAPIDapper] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RestAPIDapper] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RestAPIDapper] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RestAPIDapper] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RestAPIDapper] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RestAPIDapper] SET  ENABLE_BROKER 
GO
ALTER DATABASE [RestAPIDapper] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RestAPIDapper] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RestAPIDapper] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RestAPIDapper] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RestAPIDapper] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RestAPIDapper] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RestAPIDapper] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RestAPIDapper] SET RECOVERY FULL 
GO
ALTER DATABASE [RestAPIDapper] SET  MULTI_USER 
GO
ALTER DATABASE [RestAPIDapper] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RestAPIDapper] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RestAPIDapper] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RestAPIDapper] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RestAPIDapper] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'RestAPIDapper', N'ON'
GO
ALTER DATABASE [RestAPIDapper] SET QUERY_STORE = OFF
GO
USE [RestAPIDapper]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [RestAPIDapper]
GO
/****** Object:  UserDefinedFunction [dbo].[ufn_CSVToTable]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[ufn_CSVToTable] ( @StringInput VARCHAR(8000), @Delimiter nvarchar(1))
RETURNS @OutputTable TABLE ( [String] VARCHAR(10) )
AS
BEGIN

    DECLARE @String    VARCHAR(10)

    WHILE LEN(@StringInput) > 0
    BEGIN
        SET @String      = LEFT(@StringInput, 
                                ISNULL(NULLIF(CHARINDEX(@Delimiter, @StringInput) - 1, -1),
                                LEN(@StringInput)))
        SET @StringInput = SUBSTRING(@StringInput,
                                     ISNULL(NULLIF(CHARINDEX(@Delimiter, @StringInput), 0),
                                     LEN(@StringInput)) + 1, LEN(@StringInput))

        INSERT INTO @OutputTable ( [String] )
        VALUES ( @String )
    END

    RETURN
END
GO
/****** Object:  Table [dbo].[AttributeOptions]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeOptions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AttributeId] [int] NULL,
	[SortOrder] [int] NULL,
 CONSTRAINT [PK_AttributeOptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeOptionValues]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeOptionValues](
	[Id] [int] NOT NULL,
	[OptionId] [int] NULL,
	[Value] [nvarchar](255) NULL,
 CONSTRAINT [PK_AttributeOptionValues] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attributes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[SortOrder] [int] NULL,
	[BackendType] [varchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Attributes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeValueDateTimes]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValueDateTimes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [ntext] NULL,
	[AttributeId] [int] NULL,
	[ProductId] [int] NULL,
	[LanguageId] [varchar](50) NULL,
 CONSTRAINT [PK_AttributeValueDateTimes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeValueDecimals]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValueDecimals](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [varchar](250) NULL,
	[AttributeId] [int] NULL,
	[ProductId] [int] NULL,
	[LanguageId] [varchar](50) NULL,
 CONSTRAINT [PK_AttributeValueDecimals] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeValueInts]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValueInts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AttributeId] [int] NULL,
	[Value] [int] NULL,
	[ProductId] [int] NULL,
	[LanguageId] [varchar](50) NULL,
 CONSTRAINT [PK_AttributeValueInts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeValueText]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValueText](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AttributeId] [int] NULL,
	[Value] [ntext] NULL,
	[ProductId] [int] NULL,
	[LanguageId] [varchar](50) NULL,
 CONSTRAINT [PK_AttributeValueText] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeValueVarchars]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValueVarchars](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [varchar](250) NULL,
	[AttributeId] [int] NULL,
	[ProductId] [int] NULL,
	[LanguageId] [varchar](50) NULL,
 CONSTRAINT [PK_AttributeValueVarchars] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[SeoAlias] [varchar](255) NULL,
	[SeoTitle] [nvarchar](255) NULL,
	[SeoKeyword] [nvarchar](255) NULL,
	[SeoDescription] [nvarchar](255) NULL,
	[ParentId] [int] NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[Id] [varchar](50) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsDefault] [bit] NULL,
	[SortOrder] [int] NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[ProductId] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[CustomerName] [nvarchar](50) NOT NULL,
	[CustomerAddress] [nvarchar](255) NOT NULL,
	[CustomerEmail] [nvarchar](255) NOT NULL,
	[CustomerPhone] [varchar](20) NOT NULL,
	[CustomerNote] [nvarchar](255) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductInCategories]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductInCategories](
	[ProductId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_ProductInCategories] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 7/13/2019 10:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Sku] [varchar](50) NOT NULL,
	[Price] [float] NOT NULL,
	[DiscountPrice] [float] NULL,
	[ImageUrl] [nvarchar](255) NOT NULL,
	[ImageList] [nvarchar](max) NULL,
	[ViewCount] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
	[RateTotal] [int] NULL,
	[RateCount] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductTranslations]    Script Date: 7/13/2019 10:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTranslations](
	[ProductId] [int] NOT NULL,
	[LanguageId] [varchar](50) NOT NULL,
	[Content] [ntext] NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[SeoDescription] [nvarchar](255) NULL,
	[SeoAlias] [varchar](255) NULL,
	[SeoTitle] [nvarchar](255) NULL,
	[SeoKeyword] [nvarchar](255) NULL,
 CONSTRAINT [PK_ProductTranslations] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Attributes] ON 

INSERT [dbo].[Attributes] ([Id], [Code], [Name], [SortOrder], [BackendType], [IsActive]) VALUES (1, N'chat-lieu', N'Chất liệu', 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[Attributes] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [SeoAlias], [SeoTitle], [SeoKeyword], [SeoDescription], [ParentId], [SortOrder], [IsActive]) VALUES (1, N'Áo phông nam', N'ao-phong-nam', N'Áo phông nam 2018', N'ao phong nam', N'Các sản phẩm áo phông nam', NULL, 1, 1)
SET IDENTITY_INSERT [dbo].[Categories] OFF
INSERT [dbo].[Languages] ([Id], [Name], [IsActive], [IsDefault], [SortOrder]) VALUES (N'en-US', N'English', 1, 0, 2)
INSERT [dbo].[Languages] ([Id], [Name], [IsActive], [IsDefault], [SortOrder]) VALUES (N'vi-VN', N'Tiếng Việt', 1, 1, 1)
INSERT [dbo].[ProductInCategories] ([ProductId], [CategoryId]) VALUES (3, 1)
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Sku], [Price], [DiscountPrice], [ImageUrl], [ImageList], [ViewCount], [CreatedAt], [UpdatedAt], [IsActive], [RateTotal], [RateCount]) VALUES (3, N'AN-2018-01-001', 120000, NULL, N'/images/ao-phong.jpg', NULL, 0, CAST(N'2018-12-12T00:00:00.000' AS DateTime), NULL, 1, 0, 0)
INSERT [dbo].[Products] ([Id], [Sku], [Price], [DiscountPrice], [ImageUrl], [ImageList], [ViewCount], [CreatedAt], [UpdatedAt], [IsActive], [RateTotal], [RateCount]) VALUES (4, N'AM-DDSS24', 300200, 0, N'/asset/image/sd.png', NULL, 321, CAST(N'2019-07-10T18:03:09.777' AS DateTime), NULL, 1, 0, 0)
INSERT [dbo].[Products] ([Id], [Sku], [Price], [DiscountPrice], [ImageUrl], [ImageList], [ViewCount], [CreatedAt], [UpdatedAt], [IsActive], [RateTotal], [RateCount]) VALUES (6, N'ffffga', 7000, 0, N'/asset/image/bng.png', NULL, 0, CAST(N'2019-07-11T13:31:17.180' AS DateTime), NULL, 1, 0, 0)
INSERT [dbo].[Products] ([Id], [Sku], [Price], [DiscountPrice], [ImageUrl], [ImageList], [ViewCount], [CreatedAt], [UpdatedAt], [IsActive], [RateTotal], [RateCount]) VALUES (8, N'AK-D9123', 250000, 230000, N'/asset/images/ao-khoac-da.png', NULL, 400, CAST(N'2019-07-13T12:15:10.647' AS DateTime), NULL, 1, 0, 0)
SET IDENTITY_INSERT [dbo].[Products] OFF
INSERT [dbo].[ProductTranslations] ([ProductId], [LanguageId], [Content], [Name], [Description], [SeoDescription], [SeoAlias], [SeoTitle], [SeoKeyword]) VALUES (3, N'en-US', N'Content T-Shirt', N'T Shirt', N'Discription T-Shirt', N'Discription T Shirt', N'seo-T-Shirt', N'T - Shirt', N'T - Shirt')
INSERT [dbo].[ProductTranslations] ([ProductId], [LanguageId], [Content], [Name], [Description], [SeoDescription], [SeoAlias], [SeoTitle], [SeoKeyword]) VALUES (3, N'vi-VN', N'Nội dung của áo phông', N'Áo phông', N'Mô tả áo phông', N'mo-ta-ao-phong', N'ao-phong', N'Áo phông', N'ao phong')
INSERT [dbo].[ProductTranslations] ([ProductId], [LanguageId], [Content], [Name], [Description], [SeoDescription], [SeoAlias], [SeoTitle], [SeoKeyword]) VALUES (8, N'vi-VN', N'nôi dung áo khoác da', N'Aó khoác da', N'mô tả áo khoác da', N'mo-ta-ao-khoac-da', N'Ao-khac-da', N'áo khoác da AK-D9123', N'áo khoác da')
ALTER TABLE [dbo].[AttributeOptions]  WITH CHECK ADD  CONSTRAINT [FK_AttributeOptions_Attributes] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[Attributes] ([Id])
GO
ALTER TABLE [dbo].[AttributeOptions] CHECK CONSTRAINT [FK_AttributeOptions_Attributes]
GO
ALTER TABLE [dbo].[AttributeOptionValues]  WITH CHECK ADD  CONSTRAINT [FK_AttributeOptionValues_AttributeOptions] FOREIGN KEY([OptionId])
REFERENCES [dbo].[AttributeOptions] ([Id])
GO
ALTER TABLE [dbo].[AttributeOptionValues] CHECK CONSTRAINT [FK_AttributeOptionValues_AttributeOptions]
GO
ALTER TABLE [dbo].[AttributeValueDateTimes]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueDateTimes_Attributes] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[Attributes] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueDateTimes] CHECK CONSTRAINT [FK_AttributeValueDateTimes_Attributes]
GO
ALTER TABLE [dbo].[AttributeValueDateTimes]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueDateTimes_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueDateTimes] CHECK CONSTRAINT [FK_AttributeValueDateTimes_Products]
GO
ALTER TABLE [dbo].[AttributeValueDecimals]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueDecimals_Attributes] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[Attributes] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueDecimals] CHECK CONSTRAINT [FK_AttributeValueDecimals_Attributes]
GO
ALTER TABLE [dbo].[AttributeValueDecimals]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueDecimals_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueDecimals] CHECK CONSTRAINT [FK_AttributeValueDecimals_Products]
GO
ALTER TABLE [dbo].[AttributeValueInts]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueInts_Attributes] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[Attributes] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueInts] CHECK CONSTRAINT [FK_AttributeValueInts_Attributes]
GO
ALTER TABLE [dbo].[AttributeValueInts]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueInts_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueInts] CHECK CONSTRAINT [FK_AttributeValueInts_Products]
GO
ALTER TABLE [dbo].[AttributeValueText]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueText_Attributes] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[Attributes] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueText] CHECK CONSTRAINT [FK_AttributeValueText_Attributes]
GO
ALTER TABLE [dbo].[AttributeValueText]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueText_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueText] CHECK CONSTRAINT [FK_AttributeValueText_Products]
GO
ALTER TABLE [dbo].[AttributeValueVarchars]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueVarchars_Attributes] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[Attributes] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueVarchars] CHECK CONSTRAINT [FK_AttributeValueVarchars_Attributes]
GO
ALTER TABLE [dbo].[AttributeValueVarchars]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValueVarchars_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[AttributeValueVarchars] CHECK CONSTRAINT [FK_AttributeValueVarchars_Products]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[ProductInCategories]  WITH CHECK ADD  CONSTRAINT [FK_ProductInCategories_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[ProductInCategories] CHECK CONSTRAINT [FK_ProductInCategories_Categories]
GO
ALTER TABLE [dbo].[ProductInCategories]  WITH CHECK ADD  CONSTRAINT [FK_ProductInCategories_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[ProductInCategories] CHECK CONSTRAINT [FK_ProductInCategories_Products]
GO
ALTER TABLE [dbo].[ProductTranslations]  WITH CHECK ADD  CONSTRAINT [FK_ProductTranslations_Languages] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[ProductTranslations] CHECK CONSTRAINT [FK_ProductTranslations_Languages]
GO
ALTER TABLE [dbo].[ProductTranslations]  WITH CHECK ADD  CONSTRAINT [FK_ProductTranslations_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[ProductTranslations] CHECK CONSTRAINT [FK_ProductTranslations_Products]
GO
/****** Object:  StoredProcedure [dbo].[Create_Product]    Script Date: 7/13/2019 10:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <7/10/2019>
-- Description:	<Get Product By ID>
-- =============================================
CREATE PROCEDURE [dbo].[Create_Product] 
@language varchar(5),
@sku varchar(50),
@price float,
@DiscountPrice float,
@ViewCount int,
@IsActive bit,
@imageUrl nvarchar(255),
@id int output,
@Name nvarchar(50),
@Content nvarchar(50),
@Description nvarchar(50),
@SeoAlias nvarchar(50), 
@SeoDescription nvarchar(50),
@SeoKeyword nvarchar(50),
@SeoTitle nvarchar(50),
@CategoryIds varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET xact_abort on;

	Begin Tran
		Begin TRY
			  insert into Products(Sku, Price, DiscountPrice, ImageList, ImageUrl, ViewCount, CreatedAt, IsActive, RateTotal, RateCount)
			  values (@sku, @price, @DiscountPrice, NULL, @imageUrl, @ViewCount, GETDATE(), @IsActive, 0,0)
			  set @id = SCOPE_IDENTITY();

			  insert into ProductTranslations([ProductId], [LanguageId], [Content]
			 ,[Name], [Description], [SeoDescription], [SeoAlias], [SeoTitle], [SeoKeyword])
			 values (@id, @language, @Content, @Name, @Description, @SeoDescription, @SeoAlias, @SeoTitle, @SeoKeyword)

			 insert into ProductInCategories
			 select @id as ProductId, CAST(string as int) as CategoryId from ufn_CSVToTable(@CategoryIds,',')
			COMMIT

		End TRY
		Begin catch
		ROLLBACK
			Declare @ErrorMessage varchar(2000)
			Select @ErrorMessage = N'Lỗi' + ERROR_MESSAGE()
			RAISError(@ErrorMessage, 16, 1)
		End catch

END

GO
/****** Object:  StoredProcedure [dbo].[Delete_Product]    Script Date: 7/13/2019 10:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: 7/10/2019
-- Description:	<Delete_Product >
-- =============================================
CREATE PROCEDURE [dbo].[Delete_Product]
@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set xact_abort on;
	Begin Tran
		Begin try
		Delete ProductTranslations where ProductId = @id;
		Delete Products  where Id = @id;
		COMMIT
		end try

		Begin catch
		ROLLBACK
			Declare @ErrorMessage varchar(2000)
			Select @ErrorMessage = N'Lỗi' + ERROR_MESSAGE()
			RAISError(@ErrorMessage, 16, 1)
		End catch
	

END
GO
/****** Object:  StoredProcedure [dbo].[Get_Product_AllPaging]    Script Date: 7/13/2019 10:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		....
-- Create date: 18/12/2018
-- Description:	Get all product with paging
-- =============================================
CREATE PROCEDURE [dbo].[Get_Product_AllPaging]
	@keyword nvarchar(50),
	@categoryId int,
	@pageIndex int,
	@pageSize int,
	@language varchar(5),
	@totalRow int output
AS
BEGIN
	SET NOCOUNT ON;

	select @totalRow = count(*) from Products p 
	inner join ProductTranslations pt on p.Id = pt.ProductId
	left join ProductInCategories pic on p.Id = pic.ProductId
	left join Categories c on c.Id = pic.CategoryId
	where (@keyword is null or p.Sku like @keyword +'%') and p.IsActive = 1
	and pic.CategoryId = @categoryId

	select p.Id,
		p.Sku,
		p.Price,
		p.DiscountPrice,
		p.ImageUrl,
		p.CreatedAt,
		p.IsActive,
		p.ViewCount,
		pt.Name,
		pt.Content,
		pt.Description,
		pt.SeoAlias,
		pt.SeoDescription,
		pt.SeoKeyword,
		pt.SeoTitle,
		pt.LanguageId,
		c.Name as CategoryName
	from Products p 
	inner join ProductTranslations pt on p.Id = pt.ProductId 
	left join ProductInCategories pic on p.Id = pic.ProductId
	left join Categories c on c.Id = pic.CategoryId
	where (@keyword is null or p.Sku like @keyword +'%')
	and pt.LanguageId = @language
	and p.IsActive = 1
	and pic.CategoryId = @categoryId
	order by p.CreatedAt desc
	offset (@pageIndex - 1) * @pageSize rows
	fetch next @pageSize row only

END
GO
/****** Object:  StoredProcedure [dbo].[Get_Product_By_Id]    Script Date: 7/13/2019 10:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <7/10/2019>
-- Description:	<Get Product By ID>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Product_By_Id]
@language varchar(5),
@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select p.id, p.Sku, p.Price, p.DiscountPrice, p.ImageUrl, p.ViewCount, p.IsActive
	,pt.Name, pt.Content, pt.Description, pt.SeoAlias, pt.SeoDescription, pt.SeoKeyword, pt.SeoTitle
	from Products p inner join ProductTranslations pt
	on p.Id = pt.ProductId
	where pt.LanguageId = @language and p.id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[GetALL_Product]    Script Date: 7/13/2019 10:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		GetALL_Product with language
-- Create date: 19/6/2019
-- Description:	Get id, Sku, Price, DiscountPrice, ImageUrl, ViewCount, IsActive
-- =============================================

CREATE PROCEDURE [dbo].[GetALL_Product] 
@language varchar(10)
AS
BEGIN
	select p.id, p.Sku, p.Price, p.DiscountPrice, p.ImageUrl, p.ViewCount, p.IsActive
	,pt.Name, pt.Content, pt.Description, pt.SeoAlias, pt.SeoDescription, pt.SeoKeyword, pt.SeoTitle
	from Products p inner join ProductTranslations pt
	on p.Id = pt.ProductId
	where pt.LanguageId = @language
END

GO
/****** Object:  StoredProcedure [dbo].[Update_Product]    Script Date: 7/13/2019 10:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: 7/10/2019
-- Description:	<Update Product,,>
-- =============================================
CREATE PROCEDURE [dbo].[Update_Product]
@language varchar(5),
@id int,
@sku varchar(50),
@price float,
@DiscountPrice float,
@ViewCount int,
@IsActive bit,
@imageUrl nvarchar(255),
@Name nvarchar(50),
@Content nvarchar(50),
@Description nvarchar(50),
@SeoAlias nvarchar(50), 
@SeoDescription nvarchar(50),
@SeoKeyword nvarchar(50),
@SeoTitle nvarchar(50),
@CategoryIds varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET xact_abort on;

	Begin Tran
		Begin TRY
			  update Products SET Sku = @sku, Price = @price, DiscountPrice = @DiscountPrice,
			  ImageUrl = @imageUrl, ViewCount = @ViewCount, IsActive = @IsActive
			  where id = @id;

			  update ProductTranslations SET [Content] = @Content
			 ,[Name] = @Name, [Description] = @Description, [SeoDescription] = @SeoDescription,
			 [SeoAlias] = @SeoAlias, [SeoTitle] = @SeoTitle, [SeoKeyword] = @SeoKeyword
			 where ProductId = @id and LanguageId = @language;

			 delete ProductInCategories where ProductId = @id;

			 insert into ProductInCategories
			 select @id as ProductId, CAST(string as int) as CategoryId from ufn_CSVToTable(@CategoryIds,',')
			COMMIT
		End TRY
		Begin catch
		ROLLBACK
			Declare @ErrorMessage varchar(2000)
			Select @ErrorMessage = N'Lỗi' + ERROR_MESSAGE()
			RAISError(@ErrorMessage, 16, 1)
		End catch

END
GO
USE [master]
GO
ALTER DATABASE [RestAPIDapper] SET  READ_WRITE 
GO
