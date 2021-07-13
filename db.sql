USE [master]
GO
/****** Object:  Database [AccountManagement]    Script Date: 7/13/2021 16:11:41 ******/
CREATE DATABASE [AccountManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AccountManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AccountManagement.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AccountManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AccountManagement_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AccountManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AccountManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AccountManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AccountManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AccountManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AccountManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [AccountManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AccountManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AccountManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AccountManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AccountManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AccountManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AccountManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AccountManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AccountManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AccountManagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AccountManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AccountManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AccountManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AccountManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AccountManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AccountManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AccountManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AccountManagement] SET RECOVERY FULL 
GO
ALTER DATABASE [AccountManagement] SET  MULTI_USER 
GO
ALTER DATABASE [AccountManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AccountManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AccountManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AccountManagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'AccountManagement', N'ON'
GO
USE [AccountManagement]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 7/13/2021 16:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[OwnerId] [int] NOT NULL,
	[AccountCurrencyId] [int] NOT NULL,
	[CityId] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[DeletedOn] [datetime] NULL,
	[DeletedBy] [int] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountCurrency]    Script Date: 7/13/2021 16:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountCurrency](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Currency] [varchar](5) NULL,
	[CurrencyGlobalIdentifier] [varchar](5) NULL,
	[Description] [varchar](50) NULL,
 CONSTRAINT [PK_AccountCurrency] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountTransaction]    Script Date: 7/13/2021 16:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountTransaction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OperationTypeId] [int] NOT NULL,
	[Amount] [decimal](15, 6) NOT NULL,
	[SourceAccountId] [int] NOT NULL,
	[DestinationAccountId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ProcessedOn] [datetime] NULL,
 CONSTRAINT [PK_AccountTransaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountTransactionHistory]    Script Date: 7/13/2021 16:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountTransactionHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountTransactionId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
	[Observation] [varchar](1000) NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_AccountTransactionHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[City]    Script Date: 7/13/2021 16:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Abbreviation] [varchar](3) NULL,
	[GMT] [int] NULL,
	[StateId] [int] NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 7/13/2021 16:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Abbreviation] [varchar](3) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OperationType]    Script Date: 7/13/2021 16:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OperationType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](15) NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[State]    Script Date: 7/13/2021 16:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[State](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Abbreviation] [varchar](3) NOT NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 7/13/2021 16:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[IsFinalStatus] [bit] NOT NULL,
 CONSTRAINT [PK_Status_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 7/13/2021 16:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Document] [varchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[DeletedOn] [datetime] NULL,
	[DeletedBy] [int] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_AccountCurrency] FOREIGN KEY([AccountCurrencyId])
REFERENCES [dbo].[AccountCurrency] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_AccountCurrency]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_City] FOREIGN KEY([CityId])
REFERENCES [dbo].[City] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_City]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_User] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_User]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_User1] FOREIGN KEY([DeletedBy])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_User1]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_User2] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_User2]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_User3] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_User3]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_User4] FOREIGN KEY([DeletedBy])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_User4]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_User5] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_User5]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_User6] FOREIGN KEY([DeletedBy])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_User6]
GO
ALTER TABLE [dbo].[AccountTransaction]  WITH CHECK ADD  CONSTRAINT [FK_AccountTransaction_Account] FOREIGN KEY([SourceAccountId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[AccountTransaction] CHECK CONSTRAINT [FK_AccountTransaction_Account]
GO
ALTER TABLE [dbo].[AccountTransaction]  WITH CHECK ADD  CONSTRAINT [FK_AccountTransaction_Account1] FOREIGN KEY([DestinationAccountId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[AccountTransaction] CHECK CONSTRAINT [FK_AccountTransaction_Account1]
GO
ALTER TABLE [dbo].[AccountTransaction]  WITH CHECK ADD  CONSTRAINT [FK_AccountTransaction_OperationType] FOREIGN KEY([OperationTypeId])
REFERENCES [dbo].[OperationType] ([Id])
GO
ALTER TABLE [dbo].[AccountTransaction] CHECK CONSTRAINT [FK_AccountTransaction_OperationType]
GO
ALTER TABLE [dbo].[AccountTransaction]  WITH CHECK ADD  CONSTRAINT [FK_AccountTransaction_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([Id])
GO
ALTER TABLE [dbo].[AccountTransaction] CHECK CONSTRAINT [FK_AccountTransaction_Status]
GO
ALTER TABLE [dbo].[AccountTransaction]  WITH CHECK ADD  CONSTRAINT [FK_AccountTransaction_User] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[AccountTransaction] CHECK CONSTRAINT [FK_AccountTransaction_User]
GO
ALTER TABLE [dbo].[AccountTransactionHistory]  WITH CHECK ADD  CONSTRAINT [FK_AccountTransactionHistory_AccountTransaction] FOREIGN KEY([AccountTransactionId])
REFERENCES [dbo].[AccountTransaction] ([Id])
GO
ALTER TABLE [dbo].[AccountTransactionHistory] CHECK CONSTRAINT [FK_AccountTransactionHistory_AccountTransaction]
GO
ALTER TABLE [dbo].[AccountTransactionHistory]  WITH CHECK ADD  CONSTRAINT [FK_AccountTransactionHistory_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([Id])
GO
ALTER TABLE [dbo].[AccountTransactionHistory] CHECK CONSTRAINT [FK_AccountTransactionHistory_Status]
GO
ALTER TABLE [dbo].[City]  WITH CHECK ADD  CONSTRAINT [FK_City_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([Id])
GO
ALTER TABLE [dbo].[City] CHECK CONSTRAINT [FK_City_State]
GO
ALTER TABLE [dbo].[State]  WITH CHECK ADD  CONSTRAINT [FK_State_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[State] CHECK CONSTRAINT [FK_State_Country]
GO
USE [master]
GO
ALTER DATABASE [AccountManagement] SET  READ_WRITE 
GO
