USE [master]
GO
/****** Object:  Database [DostawyWody]    Script Date: 20.02.2022 12:13:52 ******/
CREATE DATABASE [DostawyWody]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DostawyWody', FILENAME = N'D:\New folder (3)\MSSQL15.MSSQLSERVER\MSSQL\DATA\DostawyWody.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DostawyWody_log', FILENAME = N'D:\New folder (3)\MSSQL15.MSSQLSERVER\MSSQL\DATA\DostawyWody_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DostawyWody] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DostawyWody].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DostawyWody] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DostawyWody] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DostawyWody] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DostawyWody] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DostawyWody] SET ARITHABORT OFF 
GO
ALTER DATABASE [DostawyWody] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DostawyWody] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DostawyWody] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DostawyWody] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DostawyWody] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DostawyWody] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DostawyWody] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DostawyWody] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DostawyWody] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DostawyWody] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DostawyWody] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DostawyWody] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DostawyWody] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DostawyWody] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DostawyWody] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DostawyWody] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DostawyWody] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DostawyWody] SET RECOVERY FULL 
GO
ALTER DATABASE [DostawyWody] SET  MULTI_USER 
GO
ALTER DATABASE [DostawyWody] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DostawyWody] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DostawyWody] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DostawyWody] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DostawyWody] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DostawyWody] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DostawyWody', N'ON'
GO
ALTER DATABASE [DostawyWody] SET QUERY_STORE = OFF
GO
USE [DostawyWody]
GO
/****** Object:  Table [dbo].[Klient]    Script Date: 20.02.2022 12:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Klient](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NazwaFirmy] [nvarchar](50) NOT NULL,
	[NIP] [bigint] NOT NULL,
 CONSTRAINT [PK_Klient] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PunktDostaw]    Script Date: 20.02.2022 12:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PunktDostaw](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Miasto] [nvarchar](50) NOT NULL,
	[Ulica] [nvarchar](50) NOT NULL,
	[NumerUlicy] [int] NOT NULL,
 CONSTRAINT [PK_PunktDostaw] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PunktyDostawKlienta]    Script Date: 20.02.2022 12:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PunktyDostawKlienta](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_Klient] [int] NOT NULL,
	[ID_PunktDostaw] [int] NOT NULL,
 CONSTRAINT [PK_PunktyDostawKlienta] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PunktyDostawKlientaView]    Script Date: 20.02.2022 12:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PunktyDostawKlientaView] AS	
SELECT
	PunktyDostawKlienta.ID_Klient as IDKlienta,
	Klient.NazwaFirmy,
	Klient.NIP,
	PunktyDostawKlienta.ID_PunktDostaw AS IDPunktDostaw,	
	PunktDostaw.Miasto,
	PunktDostaw.Ulica,
	PunktDostaw.NumerUlicy
FROM PunktyDostawKlienta
Join Klient on PunktyDostawKlienta.ID_Klient = Klient.ID
Join PunktDostaw ON PunktyDostawKlienta.ID_PunktDostaw = PunktDostaw.ID

GO
/****** Object:  Table [dbo].[Dystrybutor]    Script Date: 20.02.2022 12:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dystrybutor](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Model] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Dystrybutor] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DystrybutoryNaPunkcieDostaw]    Script Date: 20.02.2022 12:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DystrybutoryNaPunkcieDostaw](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_PunktDostaw] [int] NOT NULL,
	[ID_Dystrubutor] [int] NOT NULL,
 CONSTRAINT [PK_DystrybutoryNaPunkcieDostaw] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DystrybutoryNaPunkcieDostawView]    Script Date: 20.02.2022 12:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[DystrybutoryNaPunkcieDostawView]
as
Select
[DostawyWody].[dbo].[DystrybutoryNaPunkcieDostaw].[ID] AS ID_Urz_Na_Pkt_Dst,
[DostawyWody].[dbo].[DystrybutoryNaPunkcieDostaw].[ID_PunktDostaw],
[DostawyWody].[dbo].[PunktDostaw].Miasto,
[DostawyWody].[dbo].[PunktDostaw].Ulica,
[DostawyWody].[dbo].[PunktDostaw].NumerUlicy,
[DostawyWody].[dbo].[DystrybutoryNaPunkcieDostaw].[ID_Dystrubutor],
[DostawyWody].[dbo].[Dystrybutor].Model
From
DystrybutoryNaPunkcieDostaw
Join DostawyWody.dbo.PunktDostaw on [DostawyWody].[dbo].[DystrybutoryNaPunkcieDostaw].[ID_PunktDostaw] = [DostawyWody].[dbo].[PunktDostaw].ID
join DostawyWody.dbo.[Dystrybutor] ON [DostawyWody].[dbo].[DystrybutoryNaPunkcieDostaw].[ID_Dystrubutor] = [DostawyWody].[dbo].[Dystrybutor].ID


GO
/****** Object:  Table [dbo].[OsobaDoKontaktuNaPktDst]    Script Date: 20.02.2022 12:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OsobaDoKontaktuNaPktDst](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_PunktDostaw] [int] NOT NULL,
	[ID_OsobaDoKontaktu] [int] NOT NULL,
 CONSTRAINT [PK_OsobaDoKontaktuNaPktDst] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OsobaDoKontatku]    Script Date: 20.02.2022 12:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OsobaDoKontatku](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Imie] [nvarchar](50) NOT NULL,
	[Nazwisko] [nvarchar](50) NOT NULL,
	[Nr_Telefonu] [int] NOT NULL,
 CONSTRAINT [PK_OsobaDoKontatku] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PojemnoscButli]    Script Date: 20.02.2022 12:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PojemnoscButli](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Poejmnosc] [decimal](6, 2) NOT NULL,
 CONSTRAINT [PK_PojemnoscButli] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypWody]    Script Date: 20.02.2022 12:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypWody](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TypWody] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TypWody] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ZamowieniaButli]    Script Date: 20.02.2022 12:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZamowieniaButli](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_PojemnoscButli] [int] NOT NULL,
	[ID_TypWody] [int] NOT NULL,
	[Ilosc] [int] NOT NULL,
	[CenaZaSztuke] [decimal](18, 2) NOT NULL,
	[DataZamowienia] [date] NOT NULL,
	[DataDostarczenia] [date] NULL,
 CONSTRAINT [PK_ZamowieniaButli] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ZamowienieNaPunktDostaw]    Script Date: 20.02.2022 12:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZamowienieNaPunktDostaw](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_PunktDostaw] [int] NOT NULL,
	[ID_ZamowienieButli] [int] NOT NULL,
 CONSTRAINT [PK_ZamowienieNaPunktDostaw] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Dystrybutor] ON 

INSERT [dbo].[Dystrybutor] ([ID], [Model]) VALUES (1, N'Kropelka')
INSERT [dbo].[Dystrybutor] ([ID], [Model]) VALUES (2, N'Kałuża')
INSERT [dbo].[Dystrybutor] ([ID], [Model]) VALUES (3, N'Oaza')
SET IDENTITY_INSERT [dbo].[Dystrybutor] OFF
GO
SET IDENTITY_INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ON 

INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (1, 1, 1)
INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (2, 1, 1)
INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (3, 1, 2)
INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (5, 4, 3)
INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (6, 4, 1)
INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (7, 5, 1)
INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (8, 6, 3)
INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (9, 6, 3)
INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (10, 6, 3)
INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (11, 6, 3)
INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (12, 2, 3)
INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (13, 2, 3)
INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (14, 2, 3)
INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (15, 2, 1)
INSERT [dbo].[DystrybutoryNaPunkcieDostaw] ([ID], [ID_PunktDostaw], [ID_Dystrubutor]) VALUES (16, 3, 1)
SET IDENTITY_INSERT [dbo].[DystrybutoryNaPunkcieDostaw] OFF
GO
SET IDENTITY_INSERT [dbo].[Klient] ON 

INSERT [dbo].[Klient] ([ID], [NazwaFirmy], [NIP]) VALUES (1, N'Zakład przetwórstwa rybnego "Jedzie Mułem"', 7456216852)
INSERT [dbo].[Klient] ([ID], [NazwaFirmy], [NIP]) VALUES (2, N'Biuro rachunkowe "KLOSS i partnerzy"', 6945123547)
INSERT [dbo].[Klient] ([ID], [NazwaFirmy], [NIP]) VALUES (3, N'Zakład fryzjerski "Anetka"', 4556966545)
SET IDENTITY_INSERT [dbo].[Klient] OFF
GO
SET IDENTITY_INSERT [dbo].[OsobaDoKontaktuNaPktDst] ON 

INSERT [dbo].[OsobaDoKontaktuNaPktDst] ([ID], [ID_PunktDostaw], [ID_OsobaDoKontaktu]) VALUES (1, 3, 3)
INSERT [dbo].[OsobaDoKontaktuNaPktDst] ([ID], [ID_PunktDostaw], [ID_OsobaDoKontaktu]) VALUES (2, 2, 1)
INSERT [dbo].[OsobaDoKontaktuNaPktDst] ([ID], [ID_PunktDostaw], [ID_OsobaDoKontaktu]) VALUES (3, 2, 2)
INSERT [dbo].[OsobaDoKontaktuNaPktDst] ([ID], [ID_PunktDostaw], [ID_OsobaDoKontaktu]) VALUES (4, 6, 4)
INSERT [dbo].[OsobaDoKontaktuNaPktDst] ([ID], [ID_PunktDostaw], [ID_OsobaDoKontaktu]) VALUES (6, 6, 6)
INSERT [dbo].[OsobaDoKontaktuNaPktDst] ([ID], [ID_PunktDostaw], [ID_OsobaDoKontaktu]) VALUES (7, 1, 7)
INSERT [dbo].[OsobaDoKontaktuNaPktDst] ([ID], [ID_PunktDostaw], [ID_OsobaDoKontaktu]) VALUES (8, 5, 8)
INSERT [dbo].[OsobaDoKontaktuNaPktDst] ([ID], [ID_PunktDostaw], [ID_OsobaDoKontaktu]) VALUES (9, 4, 9)
SET IDENTITY_INSERT [dbo].[OsobaDoKontaktuNaPktDst] OFF
GO
SET IDENTITY_INSERT [dbo].[OsobaDoKontatku] ON 

INSERT [dbo].[OsobaDoKontatku] ([ID], [Imie], [Nazwisko], [Nr_Telefonu]) VALUES (1, N'Ania', N'Nowak', 655789945)
INSERT [dbo].[OsobaDoKontatku] ([ID], [Imie], [Nazwisko], [Nr_Telefonu]) VALUES (2, N'Jarosław', N'Pompa', 666545777)
INSERT [dbo].[OsobaDoKontatku] ([ID], [Imie], [Nazwisko], [Nr_Telefonu]) VALUES (3, N'Aneta', N'Kryształ', 565748987)
INSERT [dbo].[OsobaDoKontatku] ([ID], [Imie], [Nazwisko], [Nr_Telefonu]) VALUES (4, N'Jan', N'Jądro', 514447898)
INSERT [dbo].[OsobaDoKontatku] ([ID], [Imie], [Nazwisko], [Nr_Telefonu]) VALUES (6, N'Jonasz', N'Pierd', 522145788)
INSERT [dbo].[OsobaDoKontatku] ([ID], [Imie], [Nazwisko], [Nr_Telefonu]) VALUES (7, N'Gosia', N'Kermit', 555474878)
INSERT [dbo].[OsobaDoKontatku] ([ID], [Imie], [Nazwisko], [Nr_Telefonu]) VALUES (8, N'Ania', N'Żaba', 654457555)
INSERT [dbo].[OsobaDoKontatku] ([ID], [Imie], [Nazwisko], [Nr_Telefonu]) VALUES (9, N'Mirosław', N'Trup', 777854545)
SET IDENTITY_INSERT [dbo].[OsobaDoKontatku] OFF
GO
SET IDENTITY_INSERT [dbo].[PojemnoscButli] ON 

INSERT [dbo].[PojemnoscButli] ([ID], [Poejmnosc]) VALUES (1, CAST(18.90 AS Decimal(6, 2)))
INSERT [dbo].[PojemnoscButli] ([ID], [Poejmnosc]) VALUES (2, CAST(11.34 AS Decimal(6, 2)))
SET IDENTITY_INSERT [dbo].[PojemnoscButli] OFF
GO
SET IDENTITY_INSERT [dbo].[PunktDostaw] ON 

INSERT [dbo].[PunktDostaw] ([ID], [Miasto], [Ulica], [NumerUlicy]) VALUES (1, N'Warszawa', N'Aleje Jerozolimskie', 69)
INSERT [dbo].[PunktDostaw] ([ID], [Miasto], [Ulica], [NumerUlicy]) VALUES (2, N'Bydgoszcz', N'Jagiellońska', 40)
INSERT [dbo].[PunktDostaw] ([ID], [Miasto], [Ulica], [NumerUlicy]) VALUES (3, N'Toruń', N'Bydgoska', 20)
INSERT [dbo].[PunktDostaw] ([ID], [Miasto], [Ulica], [NumerUlicy]) VALUES (4, N'Poznań', N'Gdańska', 5)
INSERT [dbo].[PunktDostaw] ([ID], [Miasto], [Ulica], [NumerUlicy]) VALUES (5, N'Rzeszów', N'Kobylarska', 1)
INSERT [dbo].[PunktDostaw] ([ID], [Miasto], [Ulica], [NumerUlicy]) VALUES (6, N'Gdynia', N'Rybna', 80)
SET IDENTITY_INSERT [dbo].[PunktDostaw] OFF
GO
SET IDENTITY_INSERT [dbo].[PunktyDostawKlienta] ON 

INSERT [dbo].[PunktyDostawKlienta] ([ID], [ID_Klient], [ID_PunktDostaw]) VALUES (1, 2, 5)
INSERT [dbo].[PunktyDostawKlienta] ([ID], [ID_Klient], [ID_PunktDostaw]) VALUES (2, 2, 4)
INSERT [dbo].[PunktyDostawKlienta] ([ID], [ID_Klient], [ID_PunktDostaw]) VALUES (3, 2, 1)
INSERT [dbo].[PunktyDostawKlienta] ([ID], [ID_Klient], [ID_PunktDostaw]) VALUES (6, 1, 6)
INSERT [dbo].[PunktyDostawKlienta] ([ID], [ID_Klient], [ID_PunktDostaw]) VALUES (7, 1, 2)
INSERT [dbo].[PunktyDostawKlienta] ([ID], [ID_Klient], [ID_PunktDostaw]) VALUES (8, 3, 3)
SET IDENTITY_INSERT [dbo].[PunktyDostawKlienta] OFF
GO
SET IDENTITY_INSERT [dbo].[TypWody] ON 

INSERT [dbo].[TypWody] ([ID], [TypWody]) VALUES (1, N'Mineralna')
INSERT [dbo].[TypWody] ([ID], [TypWody]) VALUES (2, N'Niskomineralizowana')
SET IDENTITY_INSERT [dbo].[TypWody] OFF
GO
SET IDENTITY_INSERT [dbo].[ZamowieniaButli] ON 

INSERT [dbo].[ZamowieniaButli] ([ID], [ID_PojemnoscButli], [ID_TypWody], [Ilosc], [CenaZaSztuke], [DataZamowienia], [DataDostarczenia]) VALUES (1, 1, 1, 15, CAST(8.99 AS Decimal(18, 2)), CAST(N'2022-02-10' AS Date), CAST(N'2022-02-15' AS Date))
INSERT [dbo].[ZamowieniaButli] ([ID], [ID_PojemnoscButli], [ID_TypWody], [Ilosc], [CenaZaSztuke], [DataZamowienia], [DataDostarczenia]) VALUES (2, 1, 1, 17, CAST(8.99 AS Decimal(18, 2)), CAST(N'2022-02-12' AS Date), CAST(N'2022-02-17' AS Date))
INSERT [dbo].[ZamowieniaButli] ([ID], [ID_PojemnoscButli], [ID_TypWody], [Ilosc], [CenaZaSztuke], [DataZamowienia], [DataDostarczenia]) VALUES (3, 2, 2, 4, CAST(8.99 AS Decimal(18, 2)), CAST(N'2022-02-12' AS Date), CAST(N'2022-02-13' AS Date))
INSERT [dbo].[ZamowieniaButli] ([ID], [ID_PojemnoscButli], [ID_TypWody], [Ilosc], [CenaZaSztuke], [DataZamowienia], [DataDostarczenia]) VALUES (4, 1, 2, 7, CAST(10.80 AS Decimal(18, 2)), CAST(N'2022-02-01' AS Date), CAST(N'2022-02-08' AS Date))
INSERT [dbo].[ZamowieniaButli] ([ID], [ID_PojemnoscButli], [ID_TypWody], [Ilosc], [CenaZaSztuke], [DataZamowienia], [DataDostarczenia]) VALUES (5, 1, 2, 8, CAST(10.80 AS Decimal(18, 2)), CAST(N'2022-02-01' AS Date), CAST(N'2022-02-10' AS Date))
INSERT [dbo].[ZamowieniaButli] ([ID], [ID_PojemnoscButli], [ID_TypWody], [Ilosc], [CenaZaSztuke], [DataZamowienia], [DataDostarczenia]) VALUES (6, 1, 2, 7, CAST(10.80 AS Decimal(18, 2)), CAST(N'2022-02-02' AS Date), CAST(N'2022-02-09' AS Date))
SET IDENTITY_INSERT [dbo].[ZamowieniaButli] OFF
GO
SET IDENTITY_INSERT [dbo].[ZamowienieNaPunktDostaw] ON 

INSERT [dbo].[ZamowienieNaPunktDostaw] ([ID], [ID_PunktDostaw], [ID_ZamowienieButli]) VALUES (1, 6, 1)
INSERT [dbo].[ZamowienieNaPunktDostaw] ([ID], [ID_PunktDostaw], [ID_ZamowienieButli]) VALUES (2, 2, 2)
INSERT [dbo].[ZamowienieNaPunktDostaw] ([ID], [ID_PunktDostaw], [ID_ZamowienieButli]) VALUES (3, 3, 3)
INSERT [dbo].[ZamowienieNaPunktDostaw] ([ID], [ID_PunktDostaw], [ID_ZamowienieButli]) VALUES (4, 5, 4)
INSERT [dbo].[ZamowienieNaPunktDostaw] ([ID], [ID_PunktDostaw], [ID_ZamowienieButli]) VALUES (5, 4, 5)
INSERT [dbo].[ZamowienieNaPunktDostaw] ([ID], [ID_PunktDostaw], [ID_ZamowienieButli]) VALUES (6, 1, 6)
SET IDENTITY_INSERT [dbo].[ZamowienieNaPunktDostaw] OFF
GO
ALTER TABLE [dbo].[DystrybutoryNaPunkcieDostaw]  WITH CHECK ADD  CONSTRAINT [FK_DystrybutoryNaPunkcieDostaw_Dystrybutor] FOREIGN KEY([ID_Dystrubutor])
REFERENCES [dbo].[Dystrybutor] ([ID])
GO
ALTER TABLE [dbo].[DystrybutoryNaPunkcieDostaw] CHECK CONSTRAINT [FK_DystrybutoryNaPunkcieDostaw_Dystrybutor]
GO
ALTER TABLE [dbo].[DystrybutoryNaPunkcieDostaw]  WITH CHECK ADD  CONSTRAINT [FK_DystrybutoryNaPunkcieDostaw_PunktDostaw] FOREIGN KEY([ID_PunktDostaw])
REFERENCES [dbo].[PunktDostaw] ([ID])
GO
ALTER TABLE [dbo].[DystrybutoryNaPunkcieDostaw] CHECK CONSTRAINT [FK_DystrybutoryNaPunkcieDostaw_PunktDostaw]
GO
ALTER TABLE [dbo].[OsobaDoKontaktuNaPktDst]  WITH CHECK ADD  CONSTRAINT [FK_OsobaDoKontaktuNaPktDst_OsobaDoKontatku] FOREIGN KEY([ID_OsobaDoKontaktu])
REFERENCES [dbo].[OsobaDoKontatku] ([ID])
GO
ALTER TABLE [dbo].[OsobaDoKontaktuNaPktDst] CHECK CONSTRAINT [FK_OsobaDoKontaktuNaPktDst_OsobaDoKontatku]
GO
ALTER TABLE [dbo].[OsobaDoKontaktuNaPktDst]  WITH CHECK ADD  CONSTRAINT [FK_OsobaDoKontaktuNaPktDst_PunktDostaw] FOREIGN KEY([ID_PunktDostaw])
REFERENCES [dbo].[PunktDostaw] ([ID])
GO
ALTER TABLE [dbo].[OsobaDoKontaktuNaPktDst] CHECK CONSTRAINT [FK_OsobaDoKontaktuNaPktDst_PunktDostaw]
GO
ALTER TABLE [dbo].[PunktyDostawKlienta]  WITH CHECK ADD  CONSTRAINT [FK_PunktyDostawKlienta_Klient] FOREIGN KEY([ID_Klient])
REFERENCES [dbo].[Klient] ([ID])
GO
ALTER TABLE [dbo].[PunktyDostawKlienta] CHECK CONSTRAINT [FK_PunktyDostawKlienta_Klient]
GO
ALTER TABLE [dbo].[PunktyDostawKlienta]  WITH CHECK ADD  CONSTRAINT [FK_PunktyDostawKlienta_PunktDostaw] FOREIGN KEY([ID_PunktDostaw])
REFERENCES [dbo].[PunktDostaw] ([ID])
GO
ALTER TABLE [dbo].[PunktyDostawKlienta] CHECK CONSTRAINT [FK_PunktyDostawKlienta_PunktDostaw]
GO
ALTER TABLE [dbo].[ZamowieniaButli]  WITH CHECK ADD  CONSTRAINT [FK_ZamowieniaButli_PojemnoscButli] FOREIGN KEY([ID_PojemnoscButli])
REFERENCES [dbo].[PojemnoscButli] ([ID])
GO
ALTER TABLE [dbo].[ZamowieniaButli] CHECK CONSTRAINT [FK_ZamowieniaButli_PojemnoscButli]
GO
ALTER TABLE [dbo].[ZamowieniaButli]  WITH CHECK ADD  CONSTRAINT [FK_ZamowieniaButli_TypWody] FOREIGN KEY([ID_TypWody])
REFERENCES [dbo].[TypWody] ([ID])
GO
ALTER TABLE [dbo].[ZamowieniaButli] CHECK CONSTRAINT [FK_ZamowieniaButli_TypWody]
GO
ALTER TABLE [dbo].[ZamowienieNaPunktDostaw]  WITH CHECK ADD  CONSTRAINT [FK_ZamowienieNaPunktDostaw_PunktDostaw] FOREIGN KEY([ID_PunktDostaw])
REFERENCES [dbo].[PunktDostaw] ([ID])
GO
ALTER TABLE [dbo].[ZamowienieNaPunktDostaw] CHECK CONSTRAINT [FK_ZamowienieNaPunktDostaw_PunktDostaw]
GO
ALTER TABLE [dbo].[ZamowienieNaPunktDostaw]  WITH CHECK ADD  CONSTRAINT [FK_ZamowienieNaPunktDostaw_ZamowieniaButli] FOREIGN KEY([ID_ZamowienieButli])
REFERENCES [dbo].[ZamowieniaButli] ([ID])
GO
ALTER TABLE [dbo].[ZamowienieNaPunktDostaw] CHECK CONSTRAINT [FK_ZamowienieNaPunktDostaw_ZamowieniaButli]
GO
USE [master]
GO
ALTER DATABASE [DostawyWody] SET  READ_WRITE 
GO
