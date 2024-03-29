USE [master]
GO
/****** Object:  Database [RestAPIDapper]    Script Date: 7/23/2019 10:54:03 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[Permission]    Script Date: 7/23/2019 10:54:04 PM ******/
CREATE TYPE [dbo].[Permission] AS TABLE(
	[RoleId] [uniqueidentifier] NULL,
	[FunctionId] [varchar](50) NOT NULL,
	[ActionId] [varchar](50) NOT NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[ufn_CSVToTable]    Script Date: 7/23/2019 10:54:04 PM ******/
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
/****** Object:  Table [dbo].[ActionInFunctions]    Script Date: 7/23/2019 10:54:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActionInFunctions](
	[FunctionId] [varchar](50) NOT NULL,
	[ActionId] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ActionInFunctions] PRIMARY KEY CLUSTERED 
(
	[FunctionId] ASC,
	[ActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Actions]    Script Date: 7/23/2019 10:54:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actions](
	[Id] [varchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[SortOrder] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Actions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 7/23/2019 10:54:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 7/23/2019 10:54:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 7/23/2019 10:54:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 7/23/2019 10:54:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 7/23/2019 10:54:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 7/23/2019 10:54:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[FullName] [nvarchar](250) NULL,
	[Address] [nvarchar](250) NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 7/23/2019 10:54:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [uniqueidentifier] NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttributeOptions]    Script Date: 7/23/2019 10:54:04 PM ******/
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
/****** Object:  Table [dbo].[AttributeOptionValues]    Script Date: 7/23/2019 10:54:04 PM ******/
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
/****** Object:  Table [dbo].[Attributes]    Script Date: 7/23/2019 10:54:04 PM ******/
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
/****** Object:  Table [dbo].[AttributeValueDateTimes]    Script Date: 7/23/2019 10:54:04 PM ******/
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
/****** Object:  Table [dbo].[AttributeValueDecimals]    Script Date: 7/23/2019 10:54:04 PM ******/
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
/****** Object:  Table [dbo].[AttributeValueInts]    Script Date: 7/23/2019 10:54:04 PM ******/
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
/****** Object:  Table [dbo].[AttributeValueText]    Script Date: 7/23/2019 10:54:04 PM ******/
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
/****** Object:  Table [dbo].[AttributeValueVarchars]    Script Date: 7/23/2019 10:54:04 PM ******/
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
/****** Object:  Table [dbo].[Categories]    Script Date: 7/23/2019 10:54:05 PM ******/
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
/****** Object:  Table [dbo].[Functions]    Script Date: 7/23/2019 10:54:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Functions](
	[Id] [varchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Url] [nvarchar](50) NULL,
	[ParentId] [varchar](50) NULL,
	[SortOrder] [int] NULL,
	[CssClass] [nvarchar](50) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Functions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 7/23/2019 10:54:05 PM ******/
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
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 7/23/2019 10:54:05 PM ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 7/23/2019 10:54:05 PM ******/
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
/****** Object:  Table [dbo].[Permissions]    Script Date: 7/23/2019 10:54:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[FunctionId] [varchar](50) NOT NULL,
	[ActionId] [varchar](50) NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
(
	[FunctionId] ASC,
	[ActionId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductInCategories]    Script Date: 7/23/2019 10:54:05 PM ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 7/23/2019 10:54:05 PM ******/
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
/****** Object:  Table [dbo].[ProductTranslations]    Script Date: 7/23/2019 10:54:05 PM ******/
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
INSERT [dbo].[ActionInFunctions] ([FunctionId], [ActionId]) VALUES (N'SYSTEM.USER', N'CREATE')
INSERT [dbo].[ActionInFunctions] ([FunctionId], [ActionId]) VALUES (N'SYSTEM.USER', N'DELETE')
INSERT [dbo].[ActionInFunctions] ([FunctionId], [ActionId]) VALUES (N'SYSTEM.USER', N'IMPORT')
INSERT [dbo].[ActionInFunctions] ([FunctionId], [ActionId]) VALUES (N'SYSTEM.USER', N'UPDATE')
INSERT [dbo].[ActionInFunctions] ([FunctionId], [ActionId]) VALUES (N'SYSTEM.USER', N'VIEW')
INSERT [dbo].[Actions] ([Id], [Name], [SortOrder], [IsActive]) VALUES (N'APPROVE', N'Duyệt', 7, 1)
INSERT [dbo].[Actions] ([Id], [Name], [SortOrder], [IsActive]) VALUES (N'CREATE', N'Tạo mới', 1, 1)
INSERT [dbo].[Actions] ([Id], [Name], [SortOrder], [IsActive]) VALUES (N'DELETE', N'Xóa', 3, 1)
INSERT [dbo].[Actions] ([Id], [Name], [SortOrder], [IsActive]) VALUES (N'EXPORT', N'Xuất', 6, 1)
INSERT [dbo].[Actions] ([Id], [Name], [SortOrder], [IsActive]) VALUES (N'IMPORT', N'Nhập', 5, 1)
INSERT [dbo].[Actions] ([Id], [Name], [SortOrder], [IsActive]) VALUES (N'UPDATE', N'Cập nhật', 2, 1)
INSERT [dbo].[Actions] ([Id], [Name], [SortOrder], [IsActive]) VALUES (N'VIEW', N'Truy cập', 4, 1)
SET IDENTITY_INSERT [dbo].[AspNetRoleClaims] ON 

INSERT [dbo].[AspNetRoleClaims] ([Id], [RoleId], [ClaimType], [ClaimValue]) VALUES (1, N'b6cde355-536a-4c4a-b059-af349a7c2a98', NULL, NULL)
SET IDENTITY_INSERT [dbo].[AspNetRoleClaims] OFF
INSERT [dbo].[AspNetRoles] ([Id], [UserName], [NormalizedName], [ConcurrencyStamp]) VALUES (N'4cc9c77c-404e-44d1-937f-168ffa7e6b9a', N'NguyenThuyLinh', N'NguyenThuyLinh', NULL)
INSERT [dbo].[AspNetRoles] ([Id], [UserName], [NormalizedName], [ConcurrencyStamp]) VALUES (N'b6cde355-536a-4c4a-b059-af349a7c2a98', N'Sonlanggtu', N'DNSon', NULL)
INSERT [dbo].[AspNetRoles] ([Id], [UserName], [NormalizedName], [ConcurrencyStamp]) VALUES (N'04109a4d-73f6-4279-bdd8-b7d8d3510acd', N'XuanBac', NULL, NULL)
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f31ee575-1787-4752-b018-18fc2def53e6', N'b6cde355-536a-4c4a-b059-af349a7c2a98')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9d909bb1-7bcd-4bb7-89d3-c9ff4f33df8e', N'4cc9c77c-404e-44d1-937f-168ffa7e6b9a')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'cdc867ca-e703-497b-a8ab-f41b2ada7dbe', N'04109a4d-73f6-4279-bdd8-b7d8d3510acd')
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [FullName], [Address]) VALUES (N'f31ee575-1787-4752-b018-18fc2def53e6', N'Sonlanggtu', N'SONLANGGTU', N'Son@company.com', N'SON@COMPANY.COM', 1, N'AQAAAAEAACcQAAAAEKP4ZQjeb+rOZLBnsjWOhbYYBH2jeQV6kntVSqwKDPraDJL59U17PRJ2lvRd8VkUAA==', NULL, NULL, N'0999195464', 0, 0, NULL, 0, 0, N'DamNgocSon', N'Xuân Quan, Văn Giang, Hưng Yên')
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [FullName], [Address]) VALUES (N'9d909bb1-7bcd-4bb7-89d3-c9ff4f33df8e', N'NguyenThuyLinh', N'NGUYENTHUYLINH', N'NguyenThuyLinh@gmail.com', N'NGUYENTHUYLINH@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEFuYkOwwzggbPTlYFcI9vz+4NqDVGywbfDjK5EBq0d7knfnNWOuflutICU5k57+xuA==', NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'NguyenThuyLinh', NULL)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [FullName], [Address]) VALUES (N'cdc867ca-e703-497b-a8ab-f41b2ada7dbe', N'XuanBac', N'XUANBAC', N'XuanBac@gmail.com', N'XUANBAC@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEOOEs7+8ePsNz+3MNJW8ZuTePbI+Typ08Ul3pIJYigTFQvUBE0qno3iNU3l2d6d/VA==', NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'Nguyễn Xuân Bắc', NULL)
SET IDENTITY_INSERT [dbo].[Attributes] ON 

INSERT [dbo].[Attributes] ([Id], [Code], [Name], [SortOrder], [BackendType], [IsActive]) VALUES (1, N'chat-lieu', N'Chất liệu', 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[Attributes] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [SeoAlias], [SeoTitle], [SeoKeyword], [SeoDescription], [ParentId], [SortOrder], [IsActive]) VALUES (1, N'Áo phông nam', N'ao-phong-nam', N'Áo phông nam 2018', N'ao phong nam', N'Các sản phẩm áo phông nam', NULL, 1, 1)
SET IDENTITY_INSERT [dbo].[Categories] OFF
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'REPORT', N'Báo cáo', N'/admin/report', NULL, 3, N'icon-system', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'REPORT.INVENTORY', N'Tồn kho', N'/admin/report/inventory', N'REPORT', 2, N'icon-inventory', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'REPORT.REVENUE', N'Doanh thu', N'/admin/report/revenue', N'REPORT', 1, N'icon-revenue', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'REPORT.VISITOR', N'Truy cập', N'/admin/report/visitor', N'REPORT', 3, N'icon-visitor', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SALES', N'Kinh doanh', N'/admin/sales', NULL, 2, N'icon-sales', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SALES.ATTRIBUTE', N'Thuộc tính', N'/admin/sales/attribute', N'SALES', 4, N'icon-attribute', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SALES.CATALOG', N'Nhóm sản phẩm', N'/admin/sales/catalog', N'SALES', 1, N'icon-catalog', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SALES.ORDER', N'Hóa đơn', N'/admin/sales/order', N'SALES', 3, N'icon-order', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SALES.PRODUCT', N'Sản phẩm', N'/admin/sales/product', N'SALES', 2, N'icon-product', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SYSTEM', N'Hệ thống', N'/admin/system', NULL, 1, N'icon-system', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SYSTEM.ROLE', N'Nhóm người dùng', N'/admin/system/role', N'SYSTEM', 1, N'icon-role', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SYSTEM.SETTING', N'Cấu hình', N'/admin/system/setting', N'SYSTEM', 3, N'icon-setting', 1)
INSERT [dbo].[Functions] ([Id], [Name], [Url], [ParentId], [SortOrder], [CssClass], [IsActive]) VALUES (N'SYSTEM.USER', N'Người dùng', N'/admin/system/user', N'SYSTEM', 2, N'icon-user', 1)
INSERT [dbo].[Languages] ([Id], [Name], [IsActive], [IsDefault], [SortOrder]) VALUES (N'en-US', N'English', 1, 0, 2)
INSERT [dbo].[Languages] ([Id], [Name], [IsActive], [IsDefault], [SortOrder]) VALUES (N'vi-VN', N'Tiếng Việt', 1, 1, 1)
INSERT [dbo].[Permissions] ([FunctionId], [ActionId], [RoleId]) VALUES (N'System.user', N'approve', N'b6cde355-536a-4c4a-b059-af349a7c2a98')
INSERT [dbo].[Permissions] ([FunctionId], [ActionId], [RoleId]) VALUES (N'SYSTEM.USER', N'CREATE', N'b6cde355-536a-4c4a-b059-af349a7c2a98')
INSERT [dbo].[Permissions] ([FunctionId], [ActionId], [RoleId]) VALUES (N'system.user', N'create', N'04109a4d-73f6-4279-bdd8-b7d8d3510acd')
INSERT [dbo].[Permissions] ([FunctionId], [ActionId], [RoleId]) VALUES (N'System.user', N'delete', N'b6cde355-536a-4c4a-b059-af349a7c2a98')
INSERT [dbo].[Permissions] ([FunctionId], [ActionId], [RoleId]) VALUES (N'system.user', N'export', N'b6cde355-536a-4c4a-b059-af349a7c2a98')
INSERT [dbo].[Permissions] ([FunctionId], [ActionId], [RoleId]) VALUES (N'system.user', N'import', N'b6cde355-536a-4c4a-b059-af349a7c2a98')
INSERT [dbo].[Permissions] ([FunctionId], [ActionId], [RoleId]) VALUES (N'SYSTEM.USER', N'UPDATE', N'b6cde355-536a-4c4a-b059-af349a7c2a98')
INSERT [dbo].[Permissions] ([FunctionId], [ActionId], [RoleId]) VALUES (N'SYSTEM.USER', N'VIEW', N'b6cde355-536a-4c4a-b059-af349a7c2a98')
INSERT [dbo].[Permissions] ([FunctionId], [ActionId], [RoleId]) VALUES (N'system.user', N'view', N'04109a4d-73f6-4279-bdd8-b7d8d3510acd')
INSERT [dbo].[ProductInCategories] ([ProductId], [CategoryId]) VALUES (3, 1)
INSERT [dbo].[ProductInCategories] ([ProductId], [CategoryId]) VALUES (16, 1)
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Sku], [Price], [DiscountPrice], [ImageUrl], [ImageList], [ViewCount], [CreatedAt], [UpdatedAt], [IsActive], [RateTotal], [RateCount]) VALUES (3, N'AN-2018-01-001', 120000, NULL, N'/images/ao-phong.jpg', NULL, 0, CAST(N'2018-12-12T00:00:00.000' AS DateTime), NULL, 1, 0, 0)
INSERT [dbo].[Products] ([Id], [Sku], [Price], [DiscountPrice], [ImageUrl], [ImageList], [ViewCount], [CreatedAt], [UpdatedAt], [IsActive], [RateTotal], [RateCount]) VALUES (4, N'AM-DDSS24', 300200, 0, N'/asset/image/sd.png', NULL, 321, CAST(N'2019-07-10T18:03:09.777' AS DateTime), NULL, 1, 0, 0)
INSERT [dbo].[Products] ([Id], [Sku], [Price], [DiscountPrice], [ImageUrl], [ImageList], [ViewCount], [CreatedAt], [UpdatedAt], [IsActive], [RateTotal], [RateCount]) VALUES (6, N'ffffga', 7000, 0, N'/asset/image/bng.png', NULL, 0, CAST(N'2019-07-11T13:31:17.180' AS DateTime), NULL, 1, 0, 0)
INSERT [dbo].[Products] ([Id], [Sku], [Price], [DiscountPrice], [ImageUrl], [ImageList], [ViewCount], [CreatedAt], [UpdatedAt], [IsActive], [RateTotal], [RateCount]) VALUES (8, N'AK-D9123', 250000, 230000, N'/asset/images/ao-khoac-da.png', NULL, 400, CAST(N'2019-07-13T12:15:10.647' AS DateTime), NULL, 1, 0, 0)
INSERT [dbo].[Products] ([Id], [Sku], [Price], [DiscountPrice], [ImageUrl], [ImageList], [ViewCount], [CreatedAt], [UpdatedAt], [IsActive], [RateTotal], [RateCount]) VALUES (16, N'fdsf', 0, 0, N'string', NULL, 0, CAST(N'2019-07-13T23:21:24.633' AS DateTime), NULL, 1, 0, 0)
SET IDENTITY_INSERT [dbo].[Products] OFF
INSERT [dbo].[ProductTranslations] ([ProductId], [LanguageId], [Content], [Name], [Description], [SeoDescription], [SeoAlias], [SeoTitle], [SeoKeyword]) VALUES (3, N'en-US', N'Content T-Shirt', N'T Shirt', N'Discription T-Shirt', N'Discription T Shirt', N'seo-T-Shirt', N'T - Shirt', N'T - Shirt')
INSERT [dbo].[ProductTranslations] ([ProductId], [LanguageId], [Content], [Name], [Description], [SeoDescription], [SeoAlias], [SeoTitle], [SeoKeyword]) VALUES (3, N'vi-VN', N'Nội dung của áo phông', N'Áo phông', N'Mô tả áo phông', N'mo-ta-ao-phong', N'ao-phong', N'Áo phông', N'ao phong')
INSERT [dbo].[ProductTranslations] ([ProductId], [LanguageId], [Content], [Name], [Description], [SeoDescription], [SeoAlias], [SeoTitle], [SeoKeyword]) VALUES (8, N'vi-VN', N'nôi dung áo khoác da', N'Aó khoác da', N'mô tả áo khoác da', N'mo-ta-ao-khoac-da', N'Ao-khac-da', N'áo khoác da AK-D9123', N'áo khoác da')
INSERT [dbo].[ProductTranslations] ([ProductId], [LanguageId], [Content], [Name], [Description], [SeoDescription], [SeoAlias], [SeoTitle], [SeoKeyword]) VALUES (16, N'vi-VN', N'fsaf', N'fafas', N'stsafsaring', N'string', N'fsaff', N'string', N'string')
ALTER TABLE [dbo].[ActionInFunctions]  WITH CHECK ADD  CONSTRAINT [FK_ActionInFunctions_Actions] FOREIGN KEY([ActionId])
REFERENCES [dbo].[Actions] ([Id])
GO
ALTER TABLE [dbo].[ActionInFunctions] CHECK CONSTRAINT [FK_ActionInFunctions_Actions]
GO
ALTER TABLE [dbo].[ActionInFunctions]  WITH CHECK ADD  CONSTRAINT [FK_ActionInFunctions_Functions] FOREIGN KEY([FunctionId])
REFERENCES [dbo].[Functions] ([Id])
GO
ALTER TABLE [dbo].[ActionInFunctions] CHECK CONSTRAINT [FK_ActionInFunctions_Functions]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
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
ALTER TABLE [dbo].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_Actions] FOREIGN KEY([ActionId])
REFERENCES [dbo].[Actions] ([Id])
GO
ALTER TABLE [dbo].[Permissions] CHECK CONSTRAINT [FK_Permissions_Actions]
GO
ALTER TABLE [dbo].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_AspNetRoles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
GO
ALTER TABLE [dbo].[Permissions] CHECK CONSTRAINT [FK_Permissions_AspNetRoles]
GO
ALTER TABLE [dbo].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_Functions] FOREIGN KEY([FunctionId])
REFERENCES [dbo].[Functions] ([Id])
GO
ALTER TABLE [dbo].[Permissions] CHECK CONSTRAINT [FK_Permissions_Functions]
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
/****** Object:  StoredProcedure [dbo].[Create_Function]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Create_Function]
@Id varchar(50),
@Name nvarchar(50),
@Url nvarchar(50),
@ParentId varchar(50),
@SortOrder INT,
@CssClass nvarchar(50),
@IsActive BIT
as
begin
	set nocount on;
	  insert into Functions(Id, Name, Url, ParentId, SortOrder, CssClass, IsActive)
	  values(@Id, @Name, @Url, @ParentId, @SortOrder, @CssClass, @IsActive)
end

GO
/****** Object:  StoredProcedure [dbo].[Create_Permission]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Create_Permission]
	@roleId uniqueidentifier,
	@permissions dbo.Permission readonly
AS
BEGIN
	SET NOCOUNT ON;
	set xact_abort on;
	begin tran
	begin try
	   insert into Permissions (RoleId,FunctionId,ActionId)
	   select RoleId,FunctionId,ActionId from @permissions

	commit
	end try
	begin catch
		rollback
		  DECLARE @ErrorMessage VARCHAR(2000)
		  SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
		  RAISERROR(@ErrorMessage, 16, 1)
	end catch



  
END
GO
/****** Object:  StoredProcedure [dbo].[Create_Product]    Script Date: 7/23/2019 10:54:06 PM ******/
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

			  insert into ProductTranslations(ProductId, LanguageId, Content
			 ,Name, Description, SeoDescription, SeoAlias, SeoTitle, SeoKeyword)
			 values (@id, @language, @Content, @Name, @Description, @SeoDescription, @SeoAlias, @SeoTitle, @SeoKeyword)

			 insert into ProductInCategories(CategoryId,ProductId)
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
/****** Object:  StoredProcedure [dbo].[Create_Role_UserRole]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Create_Role_UserRole]
	@RoleId uniqueidentifier,
	@UserName varchar(30),
	@UserId uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;
	set xact_abort on;
	begin tran
	begin try
		
		insert into AspNetRoles(Id, UserName)
	   values (@RoleId, @UserName);

	   insert into AspNetUserRoles(UserId, RoleId)
	   values (@UserId, @RoleId);

	   insert into Permissions(FunctionId, ActionId, RoleId)
	   values('SYSTEM.USER', 'VIEW', @RoleId)

	commit
	end try
	begin catch
		rollback
		  DECLARE @ErrorMessage VARCHAR(2000)
		  SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
		  RAISERROR(@ErrorMessage, 16, 1)
	end catch
  
END
GO
/****** Object:  StoredProcedure [dbo].[Create_UserRole]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Create_UserRole]
	@UserId uniqueidentifier,
	@RoleId uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;
	set xact_abort on;
	begin tran
	begin try
	   insert into AspNetUserRoles(UserId, RoleId)
	   values (@UserId, @RoleId);

	commit
	end try
	begin catch
		rollback
		  DECLARE @ErrorMessage VARCHAR(2000)
		  SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
		  RAISERROR(@ErrorMessage, 16, 1)
	end catch
  
END
GO
/****** Object:  StoredProcedure [dbo].[Del_Permission_User]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Del_Permission_User]
	@UserName varchar(30),
	@ActionId varchar(10)
AS
BEGIN
	SET NOCOUNT ON;
	set xact_abort on;
	begin tran
	begin try
	declare @roleId uniqueidentifier
		set @roleId = (select ID from AspNetRoles where UserName = @UserName);

	   delete Permissions where RoleId = @roleId and ActionId = @ActionId

	commit
	end try
	begin catch
		rollback
		  DECLARE @ErrorMessage VARCHAR(2000)
		  SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
		  RAISERROR(@ErrorMessage, 16, 1)
	end catch



  
END
GO
/****** Object:  StoredProcedure [dbo].[Delete_Function]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Delete_Function]
@id varchar(50)
as
begin
	delete Functions where Id = @id
end
GO
/****** Object:  StoredProcedure [dbo].[Delete_Product]    Script Date: 7/23/2019 10:54:06 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Get_Function_All]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Get_Function_All]

as
begin
	set nocount on;
	select [Id]
      ,[Name]
      ,[Url]
      ,[ParentId]
      ,[SortOrder]
      ,[CssClass]
      ,[IsActive]
  FROM [RestAPIDapper].[dbo].[Functions]
end
GO
/****** Object:  StoredProcedure [dbo].[Get_Function_By_Id]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Get_Function_By_Id]
@id nvarchar(50)
as
begin
	set nocount on;
	select [Id]
      ,[Name]
      ,[Url]
      ,[ParentId]
      ,[SortOrder]
      ,[CssClass]
      ,[IsActive]
  FROM [RestAPIDapper].[dbo].[Functions]
  where Id = @id
end
GO
/****** Object:  StoredProcedure [dbo].[Get_Function_ByPermission]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		........
-- Create date: 11/1/2019
-- Description:	Get function by permission
-- =============================================
CREATE PROCEDURE [dbo].[Get_Function_ByPermission]
	@userId varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select 
		f.Id,
		f.Name,
		f.Url,
		f.ParentId,
		f.IsActive,
		f.SortOrder,
		f.CssClass
	 from Functions f
	join Permissions p on f.Id = p.FunctionId
	join AspNetRoles r on p.RoleId = r.Id
	join Actions a on p.ActionId = a.Id
	join AspNetUserRoles ur on r.Id = ur.RoleId
	where ur.UserId = @userId and a.Id ='VIEW'
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Function_ByPermission_APPROVE_CREATE_DELETE_EXPORT_IMPORT_UPDATE]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Function_ByPermission_APPROVE_CREATE_DELETE_EXPORT_IMPORT_UPDATE]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select 
		f.Id,
		f.Name,
		f.Url,
		f.ParentId,
		f.IsActive,
		f.SortOrder,
		f.CssClass,
		r.UserName as UserName
	 from Functions f
	join Permissions p on f.Id = p.FunctionId
	join AspNetRoles r on p.RoleId = r.Id
	join Actions a on p.ActionId = a.Id
	join AspNetUserRoles ur on r.Id = ur.RoleId
	where (a.Id ='create' or a.Id='APPROVE' or
	a.Id = 'DELETE' or a.Id = 'EXPORT'or a.Id = 'IMPORT' or a.Id = 'UPDATE') and a.IsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Function_ByPermission_view_all]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Function_ByPermission_view_all]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select 
		f.Id,
		f.Name,
		f.Url,
		f.ParentId,
		f.IsActive,
		f.SortOrder,
		f.CssClass,
		r.UserName as UserName

	 from Functions f
	join Permissions p on f.Id = p.FunctionId
	join AspNetRoles r on p.RoleId = r.Id
	join Actions a on p.ActionId = a.Id
	join AspNetUserRoles ur on r.Id = ur.RoleId
	where a.Id ='VIEW'
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Function_WithActions]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		.....
-- Create date: 8/1/2019
-- Description:	Get function with action
-- =============================================
create PROCEDURE [dbo].[Get_Function_WithActions]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
			f.Id,
			f.Name,
			f.ParentId,
			case when sum(case when a.Id='CREATE' then 1 else 0 end)>0 then 1 else 0 end as HasCreated,
			case when sum(case when a.Id='UPDATE' then 1 else 0 end)>0 then 1 else 0 end as HasUpdate,
			case when sum(case when a.Id='DELETE' then 1 else 0 end)>0 then 1 else 0 end as HasDelete,
			case when sum(case when a.Id='VIEW' then 1 else 0 end)>0 then 1 else 0 end as HasView,
			case when sum(case when a.Id='IMPORT' then 1 else 0 end)>0 then 1 else 0 end as HasImport,
			case when sum(case when a.Id='EXPORT' then 1 else 0 end)>0 then 1 else 0 end as HasExport,
			case when sum(case when a.Id='APPROVE' then 1 else 0 end)>0 then 1 else 0 end as HasApprove
		from Functions f
			left join ActionInFunctions aif on f.Id = aif.FunctionId
			left join Actions a on aif.ActionId = a.Id
	    group by f.Id,f.Name,f.ParentId
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Funtion_AllPaging]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Get_Funtion_AllPaging]
@keyword nvarchar(50),
@pageIndex int,
@pageSize int,
@totalRow int output
as
begin
	set nocount on;
	
	select @totalRow = COUNT(*) from Functions f
	where (@keyword is null or f.Name like @keyword + '%')

	select [Id]
      ,[Name]
      ,[Url]
      ,[ParentId]
      ,[SortOrder]
      ,[CssClass]
      ,[IsActive]
  FROM Functions f
	where (@keyword is null or f.Name like @keyword + '%')
	order by f.Name
	offset (@pageIndex -1)*@pageSize rows
	fetch next @pageSize row only
end

GO
/****** Object:  StoredProcedure [dbo].[Get_Permission_ByRoleId]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ToanBN - TEDU.COM.VN
-- Create date: 11/1/2019
-- Description:	Get permission by role id
-- =============================================
create PROCEDURE [dbo].[Get_Permission_ByRoleId]
	@roleId uniqueidentifier null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select 
		p.FunctionId,
		p.ActionId,
		p.RoleId
	from Permissions p inner join Actions a
		on p.ActionId = a.Id 
	where p.RoleId = @roleId
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Permission_ByUserId]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		.........
-- Create date: 11/1/2019
-- Description:	Get permission by userId
-- =============================================
CREATE PROCEDURE [dbo].[Get_Permission_ByUserId]
	@userId varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select distinct 
		f.Id + '_' + a.Id
	from Permissions p 
	join Functions f on f.Id = p.FunctionId
	join AspNetRoles r on p.RoleId = r.Id
	join Actions a on p.ActionId = a.Id
	join AspNetUserRoles ur on r.Id = ur.RoleId
	where ur.UserId = @userId 
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Permission_ByUserName]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Get_Permission_ByUserName]
	@UserName varchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select 
		p.FunctionId,
		p.ActionId
	from Permissions p inner join AspNetRoles r
	on (p.RoleId = r.Id and r.UserName = @UserName) 
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Product_AllPaging]    Script Date: 7/23/2019 10:54:06 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Get_Product_By_Id]    Script Date: 7/23/2019 10:54:06 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Get_Role_All]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Get_Role_All]
as
begin
	set nocount on;
	select iD, UserName, NormalizedName from AspNetRoles
end
GO
/****** Object:  StoredProcedure [dbo].[Get_Role_AllPaging]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Get_Role_AllPaging]
@keyword nvarchar(50),
@pageIndex int,
@pageSize int,
@totalRow int output
as
begin
	set nocount on;

	select @totalRow = COUNT(*) from AspNetRoles r
	where (@keyword is null or r.UserName like @keyword + '%')

	select iD, UserName, NormalizedName from AspNetRoles r
	where (@keyword is null or r.UserName like @keyword + '%')
	order by r.UserName
	offset (@pageIndex -1)*@pageSize rows
	fetch next @pageSize row only
end
GO
/****** Object:  StoredProcedure [dbo].[Get_User_All]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Get_User_All]

as
begin
	set nocount on;
	select Id, UserName, NormalizedUserName, Email, PhoneNumber, FullName, Address  from AspNetUsers 
end
GO
/****** Object:  StoredProcedure [dbo].[Get_User_AllPaging]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Get_User_AllPaging]
@keyword nvarchar(50),
@pageIndex int,
@pageSize int,
@totalRow int output
as
begin
	set nocount on;

	select @totalRow = COUNT(*) from AspNetUsers u
	where (@keyword is null or u.UserName like @keyword + '%')

	select Id, UserName, NormalizedUserName, Email, PhoneNumber, FullName, Address  from AspNetUsers u
	where (@keyword is null or u.UserName like @keyword + '%')
	order by u.UserName
	offset (@pageIndex -1)*@pageSize rows
	fetch next @pageSize row only
end
GO
/****** Object:  StoredProcedure [dbo].[Get_User_By_Id]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Get_User_By_Id]
@id nvarchar(50)
as
begin
	set nocount on;
	select Id, UserName, NormalizedUserName, Email, PhoneNumber, FullName, Address  from AspNetUsers where @id = Id
end
GO
/****** Object:  StoredProcedure [dbo].[GetALL_Product]    Script Date: 7/23/2019 10:54:06 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Update_Function]    Script Date: 7/23/2019 10:54:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Update_Function]
@Id varchar(50),
@Name nvarchar(50),
@Url nvarchar(50),
@ParentId varchar(50),
@SortOrder INT,
@CssClass nvarchar(50),
@IsActive BIT
as
begin
	set nocount on;
	  update Functions set Name = @Name, Url = @Url, ParentId = @ParentId,
	   SortOrder = @SortOrder, CssClass = @CssClass, IsActive = @IsActive
	   where Id = @Id
	  
end

GO
/****** Object:  StoredProcedure [dbo].[Update_Product]    Script Date: 7/23/2019 10:54:06 PM ******/
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
