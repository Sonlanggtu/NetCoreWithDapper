USE [master]
GO
/****** Object:  Database [Identity_RestAPIDapper]    Script Date: 7/17/2019 1:40:15 PM ******/
CREATE DATABASE [Identity_RestAPIDapper]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Identity_RestAPIDapper', FILENAME = N'F:\Setup\SQL Server\Root directory\MSSQL13.MSSQLSERVER\MSSQL\DATA\Identity_RestAPIDapper.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Identity_RestAPIDapper_log', FILENAME = N'F:\Setup\SQL Server\Root directory\MSSQL13.MSSQLSERVER\MSSQL\DATA\Identity_RestAPIDapper_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Identity_RestAPIDapper] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Identity_RestAPIDapper].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Identity_RestAPIDapper] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET ARITHABORT OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET RECOVERY FULL 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET  MULTI_USER 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Identity_RestAPIDapper] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Identity_RestAPIDapper] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Identity_RestAPIDapper', N'ON'
GO
ALTER DATABASE [Identity_RestAPIDapper] SET QUERY_STORE = OFF
GO
USE [Identity_RestAPIDapper]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [Identity_RestAPIDapper]
GO
/****** Object:  Table [dbo].[ActionInFunctions]    Script Date: 7/17/2019 1:40:15 PM ******/
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
/****** Object:  Table [dbo].[Actions]    Script Date: 7/17/2019 1:40:15 PM ******/
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
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 7/17/2019 1:40:15 PM ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 7/17/2019 1:40:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 7/17/2019 1:40:15 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 7/17/2019 1:40:15 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 7/17/2019 1:40:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 7/17/2019 1:40:15 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 7/17/2019 1:40:16 PM ******/
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
/****** Object:  Table [dbo].[Functions]    Script Date: 7/17/2019 1:40:16 PM ******/
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
/****** Object:  Table [dbo].[Permissions]    Script Date: 7/17/2019 1:40:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[FunctionId] [varchar](50) NULL,
	[ActionId] [varchar](50) NULL,
	[RoleId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'b6cde355-536a-4c4a-b059-af349a7c2a98', N'DamNgocSOn', N'DNSOn', NULL)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [FullName], [Address]) VALUES (N'f31ee575-1787-4752-b018-18fc2def53e6', N'Sonlanggtu', N'SONLANGGTU', N'Son@company.com', N'SON@COMPANY.COM', 0, N'AQAAAAEAACcQAAAAEKP4ZQjeb+rOZLBnsjWOhbYYBH2jeQV6kntVSqwKDPraDJL59U17PRJ2lvRd8VkUAA==', NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'DamNgocSon', NULL)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [FullName], [Address]) VALUES (N'5efa1809-585b-41a6-aba3-19514cb9aaaf', N'NguyenThuHa', N'NGUYENTHUHA', N'string', N'STRING', 1, N'abc123ASD', NULL, NULL, N'string', 1, 1, NULL, 0, 0, N'string', NULL)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [FullName], [Address]) VALUES (N'c66aa8d8-4899-4972-a96a-3e244022f152', N'cvsdas', N'CVSDAS', N'csacsac@dfedefds.com', N'CSACSAC@DFEDEFDS.COM', 0, N'AQAAAAEAACcQAAAAEKr+pyAzWigFHadgH5aPEWQw4Ow+O8uyEOJ0jYlcKpI4SAfykXNxgThEWK2qgZJcrg==', NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'csacsa', NULL)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [FullName], [Address]) VALUES (N'196b323a-ba1e-48b8-b2ce-5d8dd8f6331c', N'NguyecnTvcxvhgdsguHa', N'NGUYECNTVCXVHGDSGUHA', N'string', N'STRING', 1, N'abc123cgdscASD', NULL, NULL, N'string', 1, 1, NULL, 0, 0, N'string', NULL)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [FullName], [Address]) VALUES (N'06908cf9-efb4-4755-8f7b-a3a21475d3f8', N'cvfdfsdscdas', N'CVFDFSDSCDAS', N'csacsac@dfedefds.com', N'CSACSAC@DFEDEFDS.COM', 0, N'AQAAAAEAACcQAAAAEFH74aClGKS7ur42QjJ24NpXi6nCOn7Q8BdOWi65XwT/T156vIelxlG8VLoXV94Hsg==', NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'csacsa', NULL)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [FullName], [Address]) VALUES (N'b183436b-d227-498c-ab3b-d53310edf7e7', N'cvscdas', N'CVSCDAS', N'csacsac@dfedefds.com', N'CSACSAC@DFEDEFDS.COM', 0, N'AQAAAAEAACcQAAAAEOnM4aqR8n+x4TF8nUmJ03twDS287XXV9r5GzP1+qHqTdyEwX+XJ2t7ZPCTcOmrnIA==', NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'csacsa', NULL)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [FullName], [Address]) VALUES (N'a7fe1c85-5202-4975-b503-f450a1fcbf34', N'NguyecnTvcxgdfgfdvhgdsguHa', N'NGUYECNTVCXGDFGFDVHGDSGUHA', N'string', N'STRING', 1, N'abc123cggdscASD', NULL, NULL, N'string', 1, 1, NULL, 0, 0, N'string', NULL)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [FullName], [Address]) VALUES (N'f0a8d17f-6f34-41b9-a735-f9ce76349b91', N'NguyecnThuHa', N'NGUYECNTHUHA', N'string', N'STRING', 1, N'abc123ccASD', NULL, NULL, N'string', 1, 1, NULL, 0, 0, N'string', NULL)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [FullName], [Address]) VALUES (N'dafeae4f-8402-4482-9ea7-fc76a33269e1', N'NguyecnThgdsguHa', N'NGUYECNTHGDSGUHA', N'string', N'STRING', 1, N'abc123cgdscASD', NULL, NULL, N'string', 1, 1, NULL, 0, 0, N'string', NULL)
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
/****** Object:  StoredProcedure [dbo].[Get_Role_All]    Script Date: 7/17/2019 1:40:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Get_Role_All]
as
begin
	set nocount on;
	select iD, Name, NormalizedName from AspNetRoles
end
GO
/****** Object:  StoredProcedure [dbo].[Get_Role_AllPaging]    Script Date: 7/17/2019 1:40:16 PM ******/
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
	where (@keyword is null or r.Name like @keyword + '%')

	select iD, Name, NormalizedName from AspNetRoles r
	where (@keyword is null or r.Name like @keyword + '%')
	order by r.Name
	offset (@pageIndex -1)*@pageSize rows
	fetch next @pageSize row only
end
GO
/****** Object:  StoredProcedure [dbo].[Get_User_All]    Script Date: 7/17/2019 1:40:16 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Get_User_AllPaging]    Script Date: 7/17/2019 1:40:16 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Get_User_By_Id]    Script Date: 7/17/2019 1:40:16 PM ******/
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
USE [master]
GO
ALTER DATABASE [Identity_RestAPIDapper] SET  READ_WRITE 
GO
