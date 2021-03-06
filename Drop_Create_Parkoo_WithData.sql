USE [thePPF]
GO
/****** Object:  StoredProcedure [dbo].[SQLtoJSON]    Script Date: 6/13/2017 8:51:11 AM ******/
DROP PROCEDURE [dbo].[SQLtoJSON]
GO
/****** Object:  StoredProcedure [dbo].[SearchParks]    Script Date: 6/13/2017 8:51:11 AM ******/
DROP PROCEDURE [dbo].[SearchParks]
GO
/****** Object:  StoredProcedure [dbo].[ParkList]    Script Date: 6/13/2017 8:51:11 AM ******/
DROP PROCEDURE [dbo].[ParkList]
GO
/****** Object:  StoredProcedure [dbo].[ParkDetails]    Script Date: 6/13/2017 8:51:11 AM ******/
DROP PROCEDURE [dbo].[ParkDetails]
GO
/****** Object:  StoredProcedure [dbo].[FeatureListBox]    Script Date: 6/13/2017 8:51:11 AM ******/
DROP PROCEDURE [dbo].[FeatureListBox]
GO
ALTER TABLE [dbo].[FeaturesAtPark] DROP CONSTRAINT [FK_FeaturesAtPark_Park]
GO
ALTER TABLE [dbo].[FeaturesAtPark] DROP CONSTRAINT [FK_FeaturesAtPark_Feature]
GO
/****** Object:  Table [dbo].[Park]    Script Date: 6/13/2017 8:51:11 AM ******/
DROP TABLE [dbo].[Park]
GO
/****** Object:  Table [dbo].[FeaturesAtPark]    Script Date: 6/13/2017 8:51:11 AM ******/
DROP TABLE [dbo].[FeaturesAtPark]
GO
/****** Object:  Table [dbo].[Feature]    Script Date: 6/13/2017 8:51:11 AM ******/
DROP TABLE [dbo].[Feature]
GO
USE [master]
GO
/****** Object:  Database [thePPF]    Script Date: 6/13/2017 8:51:11 AM ******/
DROP DATABASE [thePPF]
GO
/****** Object:  Database [thePPF]    Script Date: 6/13/2017 8:51:11 AM ******/
CREATE DATABASE [thePPF] ON  PRIMARY 
( NAME = N'PPF', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\PPF.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PPF_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\PPF_log.ldf' , SIZE = 7616KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [thePPF] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [thePPF].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [thePPF] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [thePPF] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [thePPF] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [thePPF] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [thePPF] SET ARITHABORT OFF 
GO
ALTER DATABASE [thePPF] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [thePPF] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [thePPF] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [thePPF] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [thePPF] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [thePPF] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [thePPF] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [thePPF] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [thePPF] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [thePPF] SET  DISABLE_BROKER 
GO
ALTER DATABASE [thePPF] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [thePPF] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [thePPF] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [thePPF] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [thePPF] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [thePPF] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [thePPF] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [thePPF] SET RECOVERY FULL 
GO
ALTER DATABASE [thePPF] SET  MULTI_USER 
GO
ALTER DATABASE [thePPF] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [thePPF] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'thePPF', N'ON'
GO
USE [thePPF]
GO
/****** Object:  Table [dbo].[Feature]    Script Date: 6/13/2017 8:51:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feature](
	[FeatureId] [int] IDENTITY(1,1) NOT NULL,
	[FeatureName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Feature] PRIMARY KEY CLUSTERED 
(
	[FeatureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FeaturesAtPark]    Script Date: 6/13/2017 8:51:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeaturesAtPark](
	[PFID] [int] IDENTITY(1,1) NOT NULL,
	[PID] [int] NOT NULL,
	[FID] [int] NOT NULL,
 CONSTRAINT [PK_FeaturesAtPark] PRIMARY KEY CLUSTERED 
(
	[PFID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Park]    Script Date: 6/13/2017 8:51:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Park](
	[ParkId] [int] IDENTITY(1,1) NOT NULL,
	[ParkName] [nvarchar](100) NOT NULL,
	[StreetAddress] [nvarchar](100) NOT NULL,
	[City] [nvarchar](100) NOT NULL,
	[County] [nvarchar](100) NULL,
	[ZipCode] [nvarchar](100) NOT NULL,
	[Latitude] [float] NOT NULL CONSTRAINT [DF_Park_Longitude]  DEFAULT ((47.3078759)),
	[Longitude] [float] NOT NULL CONSTRAINT [DF_Park_Latitude]  DEFAULT ((-122.5309605)),
	[State] [char](2) NULL,
 CONSTRAINT [PK_Park] PRIMARY KEY CLUSTERED 
(
	[ParkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Feature] ON 

GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (1, N'Playground')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (2, N'Hiking')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (3, N'Restrooms')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (4, N'Toddler Playground')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (5, N'Spray Park')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (6, N'Baseball Field')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (7, N'Soccer Field')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (8, N'Disabled Access')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (9, N'Access Fee')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (10, N'Boat Launch')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (11, N'Concessions')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (12, N'Lake')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (13, N'Fishing')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (14, N'Walking Trail')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (15, N'Beach')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (16, N'Tennis Court')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (17, N'Disc golf')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (18, N'River')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (19, N'Pond')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (20, N'Basketball Court')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (21, N'Boat Rentals')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (22, N'Picnic Area')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (23, N'Dock Access')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (24, N'Multi-Purpose Room Rental')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (25, N'Excersize Path')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (26, N'Waterfall')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (27, N'Skate Park')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (28, N'Off Leash Dog Park')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (29, N'Lighted Tennis Courts')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (30, N'Stream or Creek')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (31, N'Bocce Courts')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (32, N'Horse Shoe Pits')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (33, N'Volleyball')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (34, N'Ampitheater')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (35, N'Stage')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (36, N'Zoo')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (37, N'Pool')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (38, N'BBQ/Grill')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (39, N'Wading Pool')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (40, N'Community Garden')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (41, N'Covered Picnic Rental')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (42, N'Monument/Memorial')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (43, N'Museum')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (44, N'Community Center')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (45, N'Senior Center')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (46, N'Football Field')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (47, N'Juvenile Fishing')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (48, N'Rock Climbing')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (49, N'Ice Skating')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (50, N'Racquetball')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (51, N'Biking/Bike Trail')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (52, N'Unmotorized Boat Launch')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (53, N'Scuba/Underwater Park')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (54, N'Street Hockey')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (55, N'Pickle Ball')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (56, N'Lacrosse Field')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (57, N'Equestrian Trails')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (58, N'Handball Court')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (59, N'Softball Field')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (60, N'Camping')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (61, N'Salt Water Fishing')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (62, N'Open Grass Area')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (63, N'Seasonal Farmers Market')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (64, N'Golf Course')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (65, N'Tourable Cave')
GO
INSERT [dbo].[Feature] ([FeatureId], [FeatureName]) VALUES (66, N'Winter/Snow Activities')
GO
SET IDENTITY_INSERT [dbo].[Feature] OFF
GO
SET IDENTITY_INSERT [dbo].[FeaturesAtPark] ON 

GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1, 2, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2, 2, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3, 2, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (4, 2, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (5, 2, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (6, 2, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (7, 2, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (8, 2, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (9, 2, 26)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (10, 2, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (11, 2, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (12, 3, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (13, 3, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (14, 3, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (15, 3, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (16, 3, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (17, 3, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (18, 3, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (19, 3, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (20, 3, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (21, 3, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (22, 3, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (23, 3, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (24, 3, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (25, 3, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (26, 3, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (27, 3, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (28, 3, 29)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (29, 3, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (30, 3, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (31, 3, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (32, 3, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (33, 4, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (34, 4, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (35, 4, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (36, 4, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (38, 4, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (39, 4, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (40, 4, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (41, 4, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (42, 4, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (43, 4, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (44, 4, 25)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (45, 4, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (46, 4, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (47, 4, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (48, 21, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (49, 21, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (50, 21, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (51, 21, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (52, 21, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (53, 6, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (54, 6, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (55, 6, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (56, 6, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (57, 6, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (58, 6, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (59, 6, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (60, 6, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (61, 6, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (62, 6, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (63, 7, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (64, 7, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (65, 7, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (66, 7, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (67, 7, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (68, 7, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (69, 7, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (70, 7, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (71, 7, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (72, 7, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (73, 7, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (74, 7, 21)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (75, 7, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (76, 7, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (77, 7, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (78, 9, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (79, 9, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (80, 9, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (81, 9, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (82, 9, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (83, 9, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (84, 9, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (85, 9, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (86, 9, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (87, 9, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (88, 9, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (89, 9, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (90, 9, 29)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (91, 9, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (92, 9, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (93, 9, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (94, 9, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (95, 11, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (96, 11, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (97, 11, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (98, 11, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (99, 11, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (100, 11, 17)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (101, 11, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (102, 13, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (103, 13, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (104, 13, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (105, 13, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (106, 13, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (107, 13, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (108, 13, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (109, 13, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (110, 13, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (111, 14, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (112, 14, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (113, 14, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (114, 14, 5)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (115, 14, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (116, 14, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (117, 14, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (118, 14, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (119, 14, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (120, 14, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (121, 14, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (122, 14, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (123, 14, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (124, 14, 25)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (125, 14, 29)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (126, 14, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (127, 15, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (128, 15, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (129, 15, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (130, 15, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (131, 15, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (132, 15, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (133, 16, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (134, 16, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (135, 16, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (136, 17, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (137, 17, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (138, 17, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (139, 17, 5)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (140, 17, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (141, 17, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (142, 17, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (143, 18, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (144, 18, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (145, 18, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (146, 18, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (147, 18, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (148, 18, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (149, 18, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (150, 18, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (151, 18, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (152, 18, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (153, 20, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (154, 20, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (155, 20, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (156, 20, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (157, 20, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (158, 20, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (159, 20, 25)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (160, 20, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (161, 20, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (162, 48, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (163, 48, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (164, 48, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (165, 48, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (166, 48, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (167, 49, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (168, 49, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (169, 49, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (170, 49, 5)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (172, 49, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (173, 49, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (174, 49, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (175, 49, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (176, 49, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (177, 49, 31)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (178, 49, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (184, 50, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (185, 50, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (186, 50, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (187, 50, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (188, 50, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (189, 51, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (190, 51, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (191, 54, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (192, 54, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (193, 55, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (194, 55, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (195, 55, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (197, 56, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (198, 56, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (199, 56, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (200, 57, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (219, 58, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (220, 58, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (221, 58, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (222, 58, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (223, 58, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (224, 58, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (225, 59, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (226, 59, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (227, 59, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (228, 59, 5)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (229, 59, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (230, 59, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (231, 59, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (232, 59, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (233, 59, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (234, 51, 40)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (235, 50, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (236, 50, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (237, 60, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (238, 60, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (239, 60, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (240, 60, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (241, 60, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (242, 60, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (243, 60, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (244, 60, 39)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (245, 60, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (246, 60, 46)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (247, 61, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (248, 61, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (249, 61, 5)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (251, 61, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (252, 61, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (253, 61, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (269, 63, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (270, 63, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (271, 63, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (272, 64, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (273, 64, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (274, 64, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (275, 64, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (276, 64, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (277, 64, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (278, 64, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (279, 65, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (280, 65, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (281, 65, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (282, 65, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (283, 65, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (284, 65, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (285, 65, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (286, 66, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (287, 66, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (288, 66, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (289, 66, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (290, 67, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (291, 67, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (292, 67, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (293, 67, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (294, 67, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (295, 182, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (296, 182, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (297, 182, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (298, 69, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (299, 69, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (300, 69, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (301, 69, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (302, 69, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (303, 69, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (304, 69, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (305, 69, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (306, 69, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (307, 69, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (308, 70, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (309, 70, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (310, 70, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (311, 70, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (312, 70, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (313, 70, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (314, 70, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (315, 70, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (316, 70, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (317, 70, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (318, 70, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (319, 70, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (320, 71, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (321, 71, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (322, 71, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (323, 71, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (324, 71, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (325, 72, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (326, 72, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (327, 72, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (328, 72, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (329, 72, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (330, 72, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (331, 73, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (332, 73, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (333, 73, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (334, 73, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (335, 73, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (336, 73, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (337, 73, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (338, 73, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (339, 73, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (340, 73, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (341, 73, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (342, 74, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (343, 74, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (344, 74, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (345, 74, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (347, 75, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (348, 75, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (349, 75, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (350, 75, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (351, 75, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (352, 75, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (353, 75, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (354, 75, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (355, 75, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (356, 75, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (357, 76, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (358, 76, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (359, 77, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (360, 77, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (361, 77, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (362, 77, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (363, 78, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (364, 78, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (365, 78, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (366, 78, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (367, 78, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (368, 78, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (369, 78, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (370, 78, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (371, 78, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (372, 78, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (373, 78, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (374, 78, 48)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (375, 78, 49)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (376, 78, 50)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (377, 79, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (378, 79, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (379, 80, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (380, 80, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (381, 80, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (382, 81, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (383, 81, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (384, 81, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (385, 81, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (386, 81, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (387, 81, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (388, 81, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (389, 81, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (390, 81, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (391, 81, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (392, 81, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (393, 81, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (394, 81, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (395, 81, 37)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (396, 82, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (397, 82, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (398, 82, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (399, 82, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (400, 83, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (401, 83, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (402, 83, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (403, 83, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (404, 83, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (405, 83, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (406, 83, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (407, 83, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (408, 83, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (409, 83, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (410, 83, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (411, 84, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (412, 84, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (413, 84, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (414, 84, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (415, 84, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (416, 84, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (417, 85, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (418, 85, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (419, 85, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (420, 85, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (421, 85, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (422, 85, 40)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (423, 21, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (424, 21, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (425, 85, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (426, 86, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (427, 86, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (428, 86, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (429, 86, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (430, 86, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (431, 86, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (432, 86, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (433, 86, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (434, 86, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (435, 86, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (436, 87, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (437, 87, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (438, 87, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (439, 87, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (440, 87, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (441, 88, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (442, 88, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (443, 88, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (444, 88, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (445, 88, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (446, 89, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (447, 89, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (448, 89, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (449, 89, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (450, 89, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (451, 89, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (452, 89, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (453, 89, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (454, 89, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (455, 89, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (456, 89, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (457, 89, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (458, 89, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (459, 89, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (460, 90, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (461, 90, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (462, 90, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (463, 90, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (464, 90, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (465, 92, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (466, 92, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (467, 92, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (468, 92, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (469, 92, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (470, 92, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (471, 92, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (472, 92, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (473, 92, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (474, 92, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (475, 92, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (476, 92, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (477, 94, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (478, 94, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (479, 95, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (480, 95, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (481, 95, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (482, 96, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (483, 96, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (484, 97, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (485, 97, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (486, 97, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (487, 97, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (488, 97, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (489, 97, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (490, 98, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (491, 98, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (492, 98, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (493, 98, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (494, 98, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (495, 98, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (501, 100, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (502, 100, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (503, 100, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (504, 101, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (505, 101, 26)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (506, 102, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (507, 102, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (508, 102, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (509, 102, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (510, 103, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (511, 103, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (512, 103, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (513, 103, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (514, 103, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (515, 103, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (516, 103, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (517, 103, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (518, 183, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (519, 183, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (520, 183, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (521, 183, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (522, 184, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (523, 184, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (524, 184, 31)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (525, 184, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (526, 105, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (527, 106, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (528, 106, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (529, 106, 17)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (530, 106, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (531, 106, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (532, 107, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (533, 107, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (534, 107, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (535, 107, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (536, 107, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (537, 107, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (538, 107, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (539, 107, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (540, 108, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (541, 108, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (542, 108, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (543, 108, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (544, 108, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (545, 108, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (546, 108, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (547, 108, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (548, 108, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (549, 109, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (550, 109, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (551, 110, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (552, 110, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (553, 110, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (554, 110, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (555, 110, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (556, 110, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (557, 110, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (558, 110, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (559, 110, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (560, 110, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (562, 111, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (563, 111, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (564, 111, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (565, 111, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (566, 62, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (567, 62, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (568, 62, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (569, 62, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (570, 62, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (571, 62, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (572, 62, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (573, 62, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (574, 62, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (575, 62, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (576, 62, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (577, 62, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (578, 62, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (579, 62, 47)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (580, 62, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (581, 62, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (582, 99, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (583, 99, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (584, 99, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (585, 99, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (586, 99, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (587, 99, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (588, 113, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (589, 113, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (590, 113, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (591, 113, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (592, 113, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (593, 113, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (594, 113, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (595, 114, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (596, 114, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (597, 114, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (598, 115, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (599, 115, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (600, 115, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (601, 115, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (602, 115, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (603, 116, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (604, 116, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (605, 116, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (606, 118, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (607, 118, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (608, 118, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (609, 119, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (610, 119, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (611, 119, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (612, 119, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (613, 119, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (614, 119, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (615, 119, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (616, 120, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (617, 120, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (618, 120, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (619, 120, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (620, 121, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (621, 121, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (622, 121, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (623, 121, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (624, 121, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (625, 121, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (626, 121, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (627, 121, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (628, 121, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (629, 121, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (630, 122, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (631, 122, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (632, 122, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (633, 122, 48)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (634, 123, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (635, 123, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (636, 123, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (637, 123, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (638, 123, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (639, 123, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (640, 123, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (641, 124, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (642, 124, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (643, 124, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (644, 124, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (645, 124, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (646, 124, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (647, 124, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (648, 124, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (649, 124, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (650, 124, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (651, 124, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (652, 125, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (653, 125, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (654, 125, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (655, 125, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (656, 125, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (657, 125, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (658, 125, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (659, 125, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (660, 125, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (661, 125, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (662, 126, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (663, 126, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (664, 126, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (665, 126, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (666, 127, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (667, 127, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (668, 128, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (669, 128, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (670, 128, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (671, 128, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (672, 128, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (673, 129, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (674, 129, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (675, 129, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (676, 129, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (677, 129, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (678, 129, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (679, 129, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (680, 129, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (681, 129, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (682, 129, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (683, 129, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (684, 129, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (685, 129, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (686, 129, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (687, 129, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (688, 129, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (689, 129, 40)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (690, 129, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (691, 129, 46)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (692, 130, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (693, 130, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (694, 130, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (695, 131, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (696, 131, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (697, 133, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (698, 133, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (699, 133, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (700, 133, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (701, 133, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (702, 134, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (703, 134, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (704, 135, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (705, 135, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (706, 135, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (707, 135, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (708, 136, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (709, 136, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (710, 136, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (711, 136, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (712, 136, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (713, 136, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (714, 136, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (715, 136, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (716, 136, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (717, 137, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (718, 137, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (719, 137, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (720, 137, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (721, 137, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (722, 137, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (723, 137, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (724, 137, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (725, 138, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (726, 138, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (727, 138, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (728, 138, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (729, 138, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (730, 138, 17)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (731, 138, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (732, 139, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (733, 139, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (734, 139, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (735, 139, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (736, 139, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (737, 139, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (738, 139, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (739, 140, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (740, 140, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (742, 141, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (743, 141, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (744, 141, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (745, 141, 31)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (746, 142, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (747, 142, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (748, 142, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (749, 143, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (750, 143, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (751, 143, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (752, 144, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (753, 144, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (754, 144, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (755, 144, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (756, 144, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (757, 144, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (758, 144, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (759, 144, 37)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (760, 144, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (761, 144, 54)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (762, 144, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (763, 145, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (764, 145, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (765, 145, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (766, 145, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (767, 145, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (768, 145, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (769, 145, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (770, 145, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (771, 145, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (772, 146, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (773, 146, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (774, 146, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (775, 146, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (776, 146, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (777, 146, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (778, 146, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (779, 146, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (780, 146, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (781, 146, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (782, 147, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (783, 147, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (784, 147, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (785, 147, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (786, 147, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (787, 147, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (788, 147, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (789, 147, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (790, 147, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (791, 147, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (792, 148, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (793, 148, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (794, 148, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (795, 148, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (796, 148, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (797, 148, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (798, 149, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (799, 149, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (800, 149, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (801, 149, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (802, 149, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (803, 149, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (804, 149, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (805, 149, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (806, 149, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (807, 149, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (808, 150, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (809, 150, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (810, 150, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (811, 150, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (812, 150, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (813, 150, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (814, 150, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (815, 150, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (816, 150, 26)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (817, 150, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (818, 151, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (819, 151, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (820, 151, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (821, 152, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (822, 152, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (823, 152, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (824, 152, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (825, 153, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (826, 153, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (827, 153, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (828, 153, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (829, 153, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (830, 153, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (831, 154, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (832, 154, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (833, 154, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (834, 154, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (835, 154, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (836, 154, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (837, 75, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (838, 128, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (839, 14, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (840, 155, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (841, 155, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (842, 155, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (843, 155, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (844, 155, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (845, 155, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (846, 156, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (847, 156, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (848, 156, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (849, 156, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (850, 156, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (851, 156, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (852, 156, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (853, 156, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (854, 157, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (855, 157, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (856, 157, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (857, 157, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (858, 157, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (859, 157, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (860, 157, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (861, 157, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (862, 157, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (863, 44, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (864, 41, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (865, 158, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (866, 158, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (867, 158, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (868, 158, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (869, 159, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (870, 159, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (871, 159, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (872, 159, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (873, 160, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (874, 160, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (875, 160, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (876, 160, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (877, 161, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (878, 161, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (879, 161, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (880, 161, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (881, 161, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (882, 161, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (883, 162, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (884, 162, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (885, 162, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (886, 162, 5)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (887, 162, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (888, 162, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (889, 162, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (890, 162, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (891, 162, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (892, 162, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (893, 162, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (894, 162, 37)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (895, 162, 40)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (896, 162, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (897, 163, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (898, 164, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (899, 164, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (900, 165, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (901, 165, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (902, 165, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (903, 165, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (904, 165, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (905, 165, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (906, 165, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (907, 165, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (908, 166, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (909, 166, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (910, 166, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (911, 166, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (912, 166, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (913, 166, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (914, 166, 40)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (915, 167, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (916, 167, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (917, 167, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (918, 167, 5)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (919, 167, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (920, 167, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (921, 167, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (922, 167, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (923, 167, 37)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (924, 167, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (925, 168, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (926, 168, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (927, 169, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (928, 169, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (929, 169, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (930, 169, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (931, 169, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (932, 169, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (933, 170, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (934, 170, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (935, 170, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (936, 170, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (937, 170, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (938, 171, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (939, 171, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (940, 171, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (941, 171, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (942, 172, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (943, 172, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (944, 172, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (945, 172, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (946, 172, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (947, 172, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (948, 172, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (949, 172, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (950, 173, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (951, 173, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (952, 173, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (953, 173, 40)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (954, 174, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (955, 174, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (956, 174, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (957, 174, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (958, 174, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (959, 174, 17)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (960, 174, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (961, 174, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (962, 175, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (963, 175, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (964, 175, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (965, 176, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (966, 176, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (967, 176, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (968, 177, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (969, 177, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (970, 178, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (971, 178, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (972, 178, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (973, 178, 5)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (974, 178, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (975, 178, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (976, 178, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (977, 178, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (978, 178, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (979, 178, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (980, 178, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (981, 178, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (982, 178, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (983, 178, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (984, 178, 46)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (985, 179, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (986, 179, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (987, 180, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (988, 180, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (989, 180, 5)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (990, 180, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (991, 180, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (992, 180, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (993, 180, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (994, 180, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (995, 180, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (996, 188, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (997, 188, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (998, 188, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (999, 63, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1000, 63, 17)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1001, 22, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1002, 22, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1003, 22, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1004, 22, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1005, 22, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1006, 22, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1007, 22, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1008, 22, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1009, 22, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1010, 22, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1011, 23, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1012, 23, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1013, 23, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1014, 23, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1015, 23, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1016, 24, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1017, 24, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1018, 24, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1019, 24, 37)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1020, 25, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1021, 25, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1022, 25, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1023, 25, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1024, 25, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1025, 25, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1026, 25, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1027, 26, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1028, 26, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1029, 26, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1040, 27, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1041, 27, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1042, 27, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1043, 27, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1044, 28, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1045, 28, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1046, 28, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1048, 28, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1049, 28, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1050, 28, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1051, 28, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1052, 28, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1053, 28, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1054, 29, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1055, 29, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1056, 29, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1057, 29, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1058, 29, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1059, 29, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1060, 29, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1061, 29, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1062, 29, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1063, 29, 17)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1064, 29, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1065, 29, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1066, 29, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1067, 29, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1068, 29, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1069, 29, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1070, 29, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1071, 29, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1081, 30, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1082, 30, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1083, 30, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1084, 30, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1085, 30, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1086, 30, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1087, 30, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1088, 31, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1089, 31, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1090, 31, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1091, 32, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1092, 32, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1093, 33, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1094, 33, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1095, 33, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1096, 33, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1097, 33, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1098, 33, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1099, 33, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1100, 33, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1101, 33, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1102, 34, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1103, 34, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1104, 34, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1105, 35, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1106, 35, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1107, 35, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1108, 35, 5)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1109, 35, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1110, 35, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1111, 35, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1112, 35, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1113, 35, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1114, 35, 40)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1115, 35, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1116, 36, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1117, 36, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1118, 36, 5)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1119, 36, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1120, 36, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1121, 36, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1122, 36, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1123, 36, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1124, 36, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1125, 37, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1126, 37, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1127, 37, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1128, 38, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1129, 38, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1130, 38, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1131, 38, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1132, 38, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1133, 38, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1134, 38, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1135, 38, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1136, 39, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1137, 39, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1138, 39, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1139, 39, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1140, 39, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1141, 39, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1142, 40, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1143, 40, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1144, 40, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1145, 41, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1146, 41, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1147, 41, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1148, 41, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1149, 41, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1150, 41, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1151, 41, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1152, 41, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1153, 41, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1154, 41, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1155, 41, 21)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1156, 41, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1157, 41, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1158, 41, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1159, 41, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1160, 41, 36)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1161, 41, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1162, 41, 40)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1163, 41, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1164, 41, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1165, 41, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1166, 41, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1167, 42, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1168, 42, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1169, 42, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1170, 42, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1171, 42, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1172, 42, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1173, 42, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1174, 43, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1175, 43, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1176, 42, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1177, 44, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1178, 44, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1179, 44, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1180, 44, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1181, 44, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1182, 44, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1183, 44, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1184, 42, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1185, 45, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1186, 45, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1187, 45, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1188, 45, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1189, 45, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1190, 46, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1191, 46, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1192, 47, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1193, 47, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1194, 47, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1195, 47, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1196, 47, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1197, 47, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1198, 47, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1199, 53, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1200, 53, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1201, 53, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1202, 53, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1203, 52, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1204, 52, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1205, 52, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1206, 52, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1207, 52, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1208, 52, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1209, 189, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1210, 189, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1211, 189, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1212, 189, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1213, 189, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1214, 190, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1215, 191, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1216, 192, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1217, 193, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1218, 193, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1219, 193, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1220, 193, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1221, 193, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1222, 193, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1223, 193, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1224, 193, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1225, 193, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1226, 193, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1227, 194, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1228, 194, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1229, 194, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1230, 194, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1231, 194, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1232, 195, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1233, 195, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1234, 195, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1235, 195, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1236, 196, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1237, 196, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1238, 197, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1239, 197, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1240, 197, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1241, 197, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1242, 197, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1243, 197, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1244, 197, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1245, 197, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1246, 197, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1247, 197, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1248, 198, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1249, 198, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1250, 198, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1251, 198, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1252, 198, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1253, 198, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1254, 199, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1255, 199, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1256, 199, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1257, 199, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1258, 199, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1259, 199, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1260, 199, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1261, 199, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1262, 199, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1263, 199, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1264, 199, 55)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1265, 9, 55)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1266, 200, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1267, 200, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1268, 200, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1269, 200, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1270, 200, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1271, 200, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1272, 200, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1273, 200, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1274, 201, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1275, 201, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1276, 201, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1277, 201, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1278, 201, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1279, 201, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1280, 201, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1281, 201, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1282, 201, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1283, 204, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1284, 204, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1285, 204, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1286, 204, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1287, 204, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1288, 204, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1289, 204, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1290, 204, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1291, 204, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1292, 204, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1293, 204, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1294, 204, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1295, 204, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1296, 204, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1297, 203, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1298, 203, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1299, 203, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1300, 203, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1301, 203, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1302, 203, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1303, 203, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1304, 203, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1305, 203, 17)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1306, 203, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1307, 203, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1308, 203, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1309, 203, 26)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1310, 203, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1311, 203, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1312, 203, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1313, 207, 26)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1314, 207, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1315, 254, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1316, 253, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1317, 252, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1318, 251, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1319, 250, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1320, 249, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1321, 249, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1322, 248, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1323, 247, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1324, 246, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1325, 245, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1326, 244, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1327, 243, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1328, 242, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1329, 241, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1330, 240, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1331, 239, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1332, 238, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1333, 237, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1334, 236, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1335, 235, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1336, 234, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1337, 233, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1338, 232, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1339, 232, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1340, 231, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1341, 231, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1342, 231, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1343, 231, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1344, 230, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1345, 229, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1346, 228, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1347, 227, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1348, 226, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1349, 225, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1350, 224, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1351, 223, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1352, 222, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1353, 221, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1354, 220, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1355, 219, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1356, 218, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1357, 217, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1358, 216, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1359, 215, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1360, 214, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1361, 213, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1362, 212, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1363, 211, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1364, 210, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1365, 209, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1366, 208, 37)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1367, 206, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1368, 205, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1369, 5, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1370, 5, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1371, 5, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1372, 5, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1373, 5, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1374, 5, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1375, 5, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1376, 5, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1377, 5, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1378, 5, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1379, 8, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1380, 8, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1381, 8, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1382, 8, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1383, 8, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1384, 8, 40)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1385, 8, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1386, 10, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1387, 10, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1388, 10, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1389, 10, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1390, 10, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1391, 10, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1399, 12, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1400, 12, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1401, 12, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1402, 12, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1403, 12, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1404, 12, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1405, 12, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1406, 12, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1407, 19, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1408, 19, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1409, 19, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1410, 19, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1411, 19, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1412, 91, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1413, 91, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1414, 91, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1415, 104, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1416, 104, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1417, 104, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1418, 132, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1419, 231, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1420, 231, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1421, 231, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1422, 231, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1423, 231, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1424, 231, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1425, 231, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1426, 231, 21)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1427, 231, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1428, 231, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1429, 231, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1430, 231, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1431, 231, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1432, 255, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1433, 255, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1434, 255, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1435, 255, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1436, 255, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1437, 255, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1438, 255, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1439, 255, 37)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1440, 255, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1441, 255, 48)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1442, 256, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1443, 256, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1444, 256, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1445, 256, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1446, 256, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1447, 256, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1448, 257, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1449, 257, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1450, 257, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1451, 258, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1452, 258, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1453, 258, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1454, 258, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1455, 258, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1456, 259, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1457, 259, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1458, 259, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1459, 259, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1460, 259, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1461, 260, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1462, 260, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1463, 260, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1464, 260, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1465, 261, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1466, 261, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1467, 261, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1468, 261, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1469, 261, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1470, 262, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1471, 262, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1472, 262, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1473, 263, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1474, 263, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1475, 264, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1476, 264, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1477, 265, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1478, 265, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1479, 265, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1480, 266, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1481, 267, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1482, 267, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1483, 267, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1484, 267, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1485, 267, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1486, 267, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1487, 267, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1488, 267, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1489, 267, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1490, 268, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1491, 268, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1492, 268, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1493, 268, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1494, 269, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1495, 269, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1496, 269, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1497, 269, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1498, 270, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1499, 270, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1500, 270, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1501, 270, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1502, 271, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1503, 271, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1504, 271, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1505, 273, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1506, 273, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1507, 273, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1508, 273, 37)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1509, 274, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1510, 274, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1511, 274, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1512, 274, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1513, 274, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1514, 274, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1515, 275, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1516, 275, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1517, 275, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1518, 275, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1519, 275, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1520, 275, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1521, 275, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1522, 275, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1523, 275, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1524, 275, 56)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1525, 276, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1526, 276, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1527, 276, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1528, 276, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1529, 277, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1530, 277, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1531, 277, 57)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1532, 278, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1533, 278, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1534, 278, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1535, 278, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1536, 278, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1537, 278, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1538, 278, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1539, 278, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1540, 278, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1541, 278, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1542, 278, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1543, 278, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1544, 278, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1545, 278, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1546, 278, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1547, 278, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1548, 278, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1549, 278, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1550, 278, 39)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1551, 278, 40)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1552, 278, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1553, 278, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1554, 279, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1555, 279, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1556, 280, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1557, 281, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1558, 281, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1559, 281, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1560, 281, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1561, 282, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1562, 282, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1563, 282, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1564, 282, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1565, 283, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1566, 283, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1567, 283, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1568, 283, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1569, 283, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1570, 284, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1571, 284, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1572, 284, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1573, 284, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1574, 284, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1575, 284, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1576, 284, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1577, 284, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1578, 284, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1579, 284, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1580, 284, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1581, 284, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1582, 284, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1583, 283, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1584, 285, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1585, 285, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1586, 285, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1587, 286, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1588, 286, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1589, 286, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1590, 286, 17)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1591, 286, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1592, 286, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1593, 286, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1594, 287, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1595, 287, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1596, 287, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1597, 287, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1598, 287, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1599, 288, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1600, 288, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1601, 289, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1602, 289, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1603, 289, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1604, 289, 5)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1605, 289, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1606, 289, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1607, 289, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1608, 289, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1609, 289, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1610, 289, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1611, 289, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1612, 289, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1613, 289, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1614, 289, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1615, 289, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1616, 289, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1617, 289, 45)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1618, 289, 48)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1619, 290, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1620, 290, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1621, 290, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1622, 290, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1623, 291, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1624, 291, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1625, 291, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1626, 292, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1627, 293, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1628, 293, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1629, 293, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1630, 294, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1631, 294, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1632, 294, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1633, 295, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1634, 296, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1635, 296, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1636, 297, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1637, 297, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1638, 297, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1639, 297, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1640, 297, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1641, 297, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1642, 298, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1643, 298, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1644, 298, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1645, 298, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1646, 299, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1647, 299, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1648, 299, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1649, 299, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1650, 299, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1651, 299, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1652, 300, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1653, 300, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1654, 300, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1655, 300, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1656, 300, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1657, 300, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1658, 300, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1659, 300, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1660, 300, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1661, 300, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1662, 300, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1663, 301, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1664, 301, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1665, 301, 47)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1666, 302, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1667, 302, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1668, 302, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1669, 303, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1670, 303, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1671, 303, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1672, 303, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1673, 303, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1674, 303, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1675, 303, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1676, 303, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1677, 303, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1678, 303, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1679, 303, 57)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1680, 304, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1681, 304, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1682, 304, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1683, 305, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1684, 305, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1685, 305, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1686, 305, 55)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1687, 306, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1688, 306, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1689, 306, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1690, 306, 55)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1691, 307, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1692, 307, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1693, 307, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1694, 307, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1695, 307, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1696, 307, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1697, 307, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1698, 307, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1699, 307, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1700, 307, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1701, 308, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1702, 308, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1703, 308, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1704, 309, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1705, 309, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1706, 309, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1707, 309, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1708, 310, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1709, 310, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1710, 311, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1711, 312, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1712, 312, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1713, 313, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1714, 313, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1715, 313, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1716, 314, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1717, 314, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1718, 314, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1719, 314, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1720, 314, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1721, 314, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1722, 314, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1723, 314, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1724, 314, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1725, 314, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1726, 315, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1727, 315, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1728, 315, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1729, 316, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1730, 316, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1731, 316, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1732, 316, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1733, 317, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1734, 318, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1735, 318, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1736, 318, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1737, 318, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1738, 318, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1739, 318, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1740, 319, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1741, 319, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1742, 319, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1743, 319, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1744, 320, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1745, 320, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1746, 320, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1747, 321, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1748, 322, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1749, 322, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1750, 322, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1751, 322, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1752, 323, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1753, 323, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1754, 323, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1755, 323, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1756, 323, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1757, 324, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1758, 324, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1759, 324, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1760, 324, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1761, 324, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1762, 325, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1763, 325, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1764, 325, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1765, 326, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1766, 326, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1767, 327, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1768, 328, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1769, 328, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1770, 328, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1771, 328, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1772, 328, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1773, 329, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1774, 329, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1775, 329, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1776, 329, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1777, 329, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1778, 329, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1779, 329, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1780, 329, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1781, 329, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1782, 329, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1783, 329, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1784, 329, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1785, 329, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1786, 329, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1787, 330, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1788, 330, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1789, 330, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1790, 330, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1791, 330, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1792, 330, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1793, 330, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1794, 330, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1795, 330, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1796, 330, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1797, 330, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1798, 330, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1799, 330, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1800, 330, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1801, 330, 57)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1802, 331, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1803, 331, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1804, 331, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1805, 331, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1806, 331, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1807, 332, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1808, 332, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1809, 332, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1810, 332, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1811, 332, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1812, 332, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1813, 332, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1814, 333, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1815, 333, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1816, 333, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1817, 333, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1818, 333, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1819, 333, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1820, 333, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1821, 333, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1822, 333, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1823, 333, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1824, 334, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1825, 334, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1826, 334, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1827, 334, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1828, 334, 49)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1829, 335, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1830, 335, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1831, 335, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1832, 335, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1833, 335, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1834, 335, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1835, 335, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1836, 335, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1837, 335, 29)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1838, 335, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1839, 336, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1840, 336, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1841, 336, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1842, 336, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1843, 336, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1844, 336, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1845, 336, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1846, 336, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1847, 336, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1848, 336, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1849, 336, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1850, 336, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1851, 336, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1852, 337, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1853, 337, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1854, 337, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1855, 337, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1856, 337, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1857, 337, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1858, 337, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1859, 338, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1860, 338, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1861, 338, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1862, 338, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1863, 338, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1864, 338, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1865, 338, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1866, 338, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1867, 337, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1868, 339, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1869, 339, 5)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1870, 340, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1871, 340, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1872, 340, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1873, 340, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1874, 340, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1875, 340, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1876, 340, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1877, 340, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1878, 340, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1879, 341, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1880, 341, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1881, 341, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1882, 341, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1883, 341, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1884, 341, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1885, 341, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1886, 341, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1887, 341, 25)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1888, 341, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1889, 341, 29)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1890, 341, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1891, 341, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1892, 341, 58)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1893, 338, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1894, 3, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1895, 9, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1896, 12, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1897, 18, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1898, 34, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1899, 36, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1900, 70, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1901, 78, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1902, 88, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1903, 91, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1904, 108, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1905, 129, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1906, 138, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1907, 144, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1908, 161, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1909, 178, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1910, 229, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1911, 237, 54)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1912, 237, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1913, 237, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1914, 237, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1915, 248, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1916, 248, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1917, 253, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1918, 270, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1919, 275, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1920, 278, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1921, 284, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1922, 316, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1923, 333, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1924, 335, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1925, 342, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1926, 342, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1927, 342, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1928, 342, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1929, 342, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1930, 342, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1931, 342, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1932, 342, 29)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1933, 342, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1934, 343, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1935, 343, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1936, 343, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1937, 343, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1938, 343, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1939, 343, 37)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1940, 343, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1941, 343, 55)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1942, 344, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1943, 344, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1944, 345, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1945, 345, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1946, 346, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1947, 346, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1948, 346, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1949, 346, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1950, 346, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1951, 346, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1952, 346, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1953, 346, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1954, 346, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1955, 346, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1956, 346, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1957, 346, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1958, 346, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1959, 347, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1960, 347, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1961, 347, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1962, 347, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1963, 347, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1964, 347, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1965, 347, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1966, 347, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1967, 347, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1968, 347, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1969, 347, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1970, 347, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1971, 347, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1972, 347, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1973, 347, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1974, 347, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1975, 347, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1976, 348, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1977, 348, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1978, 348, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1979, 348, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1980, 349, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1981, 349, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1982, 349, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1983, 349, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1984, 349, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1985, 349, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1986, 349, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1987, 350, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1988, 351, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1989, 351, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1990, 351, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1991, 351, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1992, 352, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1993, 352, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1994, 352, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1995, 352, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1996, 352, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1997, 353, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1998, 353, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (1999, 354, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2000, 354, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2001, 354, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2002, 354, 31)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2003, 355, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2004, 355, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2005, 355, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2006, 355, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2007, 355, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2008, 355, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2009, 355, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2010, 355, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2011, 355, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2012, 356, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2013, 356, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2014, 357, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2015, 357, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2016, 357, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2017, 358, 5)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2018, 358, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2019, 359, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2020, 359, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2021, 359, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2022, 359, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2023, 359, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2024, 359, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2025, 359, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2026, 361, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2027, 361, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2028, 361, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2029, 361, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2030, 361, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2031, 361, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2032, 361, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2033, 361, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2034, 361, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2035, 362, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2036, 362, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2037, 362, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2038, 362, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2039, 362, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2040, 362, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2041, 362, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2042, 362, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2043, 362, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2044, 363, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2045, 364, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2046, 364, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2047, 364, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2048, 364, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2049, 365, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2050, 365, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2051, 365, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2052, 366, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2053, 367, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2054, 367, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2055, 367, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2056, 367, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2057, 367, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2058, 367, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2059, 367, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2060, 367, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2061, 368, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2062, 368, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2063, 368, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2064, 368, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2065, 368, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2066, 368, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2067, 368, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2068, 368, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2069, 368, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2070, 368, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2071, 368, 40)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2072, 368, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2073, 368, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2074, 369, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2075, 369, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2076, 369, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2077, 369, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2078, 370, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2079, 370, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2080, 370, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2081, 370, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2082, 370, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2083, 371, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2084, 371, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2085, 371, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2086, 371, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2087, 372, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2088, 372, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2089, 372, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2090, 372, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2091, 372, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2092, 372, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2093, 372, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2094, 372, 40)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2095, 369, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2096, 369, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2097, 3, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2098, 5, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2099, 6, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2100, 9, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2101, 10, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2102, 14, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2103, 15, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2104, 16, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2105, 17, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2106, 17, 63)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2107, 167, 63)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2108, 89, 63)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2109, 167, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2110, 178, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2111, 178, 63)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2112, 114, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2113, 114, 63)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2114, 18, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2115, 19, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2116, 23, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2117, 25, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2118, 28, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2119, 29, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2120, 30, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2121, 35, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2122, 36, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2123, 37, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2124, 38, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2125, 39, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2126, 39, 45)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2127, 40, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2128, 41, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2129, 42, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2130, 42, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2131, 45, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2132, 48, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2133, 49, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2134, 50, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2137, 52, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2138, 56, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2139, 58, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2140, 58, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2141, 59, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2142, 60, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2143, 62, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2144, 67, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2145, 72, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2146, 72, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2147, 79, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2148, 80, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2149, 81, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2150, 83, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2151, 86, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2152, 87, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2153, 88, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2154, 91, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2155, 95, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2156, 97, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2157, 98, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2158, 102, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2159, 103, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2160, 105, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2161, 107, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2162, 108, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2163, 109, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2164, 110, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2165, 111, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2166, 115, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2167, 123, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2168, 124, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2169, 126, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2170, 129, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2171, 136, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2172, 136, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2173, 136, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2174, 137, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2175, 137, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2176, 138, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2177, 139, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2178, 144, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2179, 145, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2180, 146, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2181, 147, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2182, 148, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2183, 152, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2184, 154, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2185, 155, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2186, 156, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2187, 156, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2188, 157, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2189, 159, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2190, 160, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2191, 162, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2192, 163, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2193, 165, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2194, 166, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2195, 169, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2196, 170, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2197, 171, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2198, 173, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2199, 174, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2200, 175, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2201, 180, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2202, 184, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2203, 189, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2204, 190, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2205, 193, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2206, 194, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2207, 199, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2208, 201, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2209, 203, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2210, 203, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2211, 258, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2212, 261, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2213, 265, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2214, 266, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2215, 270, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2216, 271, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2217, 272, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2218, 272, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2219, 272, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2220, 272, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2221, 272, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2222, 272, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2223, 272, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2224, 272, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2225, 272, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2226, 272, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2227, 272, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2228, 272, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2229, 272, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2230, 272, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2231, 274, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2232, 275, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2233, 276, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2234, 278, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2235, 282, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2236, 284, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2237, 285, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2238, 286, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2239, 287, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2240, 289, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2241, 290, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2242, 294, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2243, 300, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2244, 302, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2245, 304, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2246, 306, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2247, 307, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2248, 313, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2249, 315, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2250, 318, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2251, 319, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2252, 320, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2253, 321, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2254, 322, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2255, 323, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2256, 329, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2257, 330, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2258, 332, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2259, 336, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2260, 337, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2261, 340, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2262, 341, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2263, 342, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2264, 349, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2265, 350, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2266, 351, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2267, 355, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2268, 359, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2269, 362, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2270, 363, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2271, 364, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2272, 366, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2273, 367, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2274, 370, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2275, 372, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2276, 373, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2277, 373, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2278, 374, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2279, 374, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2280, 374, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2281, 374, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2282, 374, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2283, 374, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2284, 374, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2285, 374, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2286, 374, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2287, 374, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2288, 374, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2289, 374, 27)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2290, 374, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2291, 374, 40)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2292, 374, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2293, 374, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2294, 375, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2295, 375, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2296, 375, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2297, 375, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2298, 376, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2299, 376, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2300, 376, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2301, 377, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2302, 377, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2303, 377, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2304, 377, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2305, 378, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2306, 379, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2307, 380, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2308, 380, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2309, 380, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2310, 381, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2311, 381, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2312, 381, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2313, 381, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2314, 382, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2315, 382, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2316, 383, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2317, 383, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2318, 383, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2319, 383, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2320, 383, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2321, 383, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2322, 384, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2323, 385, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2324, 385, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2325, 386, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2326, 386, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2327, 386, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2328, 386, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2329, 387, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2330, 387, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2331, 387, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2332, 387, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2333, 387, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2334, 387, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2335, 388, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2336, 388, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2337, 389, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2338, 389, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2339, 389, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2340, 389, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2341, 389, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2342, 389, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2343, 389, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2344, 389, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2345, 389, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2346, 389, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2347, 389, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2348, 390, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2349, 390, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2350, 390, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2351, 390, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2352, 390, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2353, 391, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2354, 391, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2355, 392, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2356, 392, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2357, 392, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2358, 393, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2359, 393, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2360, 393, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2361, 393, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2362, 393, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2363, 393, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2364, 393, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2365, 393, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2366, 393, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2367, 393, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2368, 393, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2369, 393, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2370, 393, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2371, 393, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2372, 393, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2373, 393, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2374, 394, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2375, 394, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2376, 394, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2377, 395, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2378, 395, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2379, 396, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2380, 397, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2381, 397, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2382, 397, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2383, 398, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2384, 398, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2385, 398, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2386, 398, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2387, 398, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2388, 398, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2389, 398, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2390, 398, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2391, 398, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2392, 398, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2393, 398, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2394, 399, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2395, 399, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2396, 399, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2397, 399, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2398, 399, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2399, 399, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2400, 399, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2401, 399, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2402, 399, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2403, 399, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2404, 399, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2405, 400, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2406, 400, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2407, 400, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2408, 400, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2409, 400, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2410, 400, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2411, 400, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2412, 400, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2413, 400, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2414, 400, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2415, 400, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2416, 400, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2417, 401, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2418, 401, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2419, 401, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2420, 401, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2421, 402, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2422, 402, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2423, 402, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2424, 402, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2425, 402, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2426, 402, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2427, 402, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2428, 402, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2429, 403, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2430, 403, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2431, 403, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2432, 403, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2433, 403, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2434, 403, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2435, 404, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2436, 404, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2437, 404, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2438, 404, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2439, 405, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2440, 405, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2441, 405, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2442, 405, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2443, 405, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2444, 405, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2445, 405, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2446, 405, 28)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2447, 405, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2448, 405, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2449, 405, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2450, 405, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2451, 406, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2452, 406, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2453, 406, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2454, 406, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2455, 406, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2456, 406, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2457, 407, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2458, 407, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2459, 407, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2460, 408, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2461, 408, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2462, 408, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2463, 409, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2464, 409, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2465, 409, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2466, 409, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2467, 410, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2468, 410, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2469, 410, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2470, 411, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2471, 411, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2472, 412, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2473, 412, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2474, 412, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2475, 412, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2476, 412, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2477, 412, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2478, 412, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2479, 412, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2480, 412, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2481, 413, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2482, 413, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2483, 413, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2484, 413, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2485, 413, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2486, 413, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2487, 413, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2488, 413, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2489, 413, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2490, 414, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2491, 414, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2492, 414, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2493, 414, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2494, 414, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2495, 414, 17)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2496, 414, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2497, 414, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2498, 414, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2499, 414, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2500, 414, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2501, 414, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2502, 414, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2503, 414, 45)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2504, 414, 47)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2505, 415, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2506, 415, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2507, 415, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2508, 415, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2509, 415, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2510, 415, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2511, 415, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2512, 415, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2513, 415, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2514, 415, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2515, 415, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2516, 416, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2517, 416, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2518, 416, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2519, 417, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2520, 417, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2521, 417, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2522, 417, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2523, 417, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2524, 417, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2525, 417, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2526, 417, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2527, 418, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2528, 418, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2529, 418, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2530, 418, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2531, 418, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2532, 418, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2533, 418, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2534, 418, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2535, 418, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2536, 418, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2537, 418, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2538, 418, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2539, 419, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2540, 419, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2541, 419, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2542, 419, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2543, 419, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2544, 419, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2545, 419, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2546, 419, 57)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2547, 420, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2548, 420, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2549, 420, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2550, 420, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2551, 420, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2552, 420, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2553, 420, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2554, 420, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2555, 420, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2556, 420, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2557, 420, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2558, 420, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2559, 420, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2560, 420, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2561, 420, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2562, 420, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2563, 420, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2564, 420, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2565, 420, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2566, 420, 57)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2567, 420, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2568, 420, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2569, 420, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2570, 421, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2571, 421, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2572, 421, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2573, 421, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2574, 421, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2575, 421, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2576, 421, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2577, 421, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2578, 421, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2579, 421, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2580, 422, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2581, 422, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2582, 422, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2583, 422, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2584, 422, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2585, 422, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2586, 422, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2587, 422, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2588, 422, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2589, 422, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2590, 422, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2591, 422, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2592, 422, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2593, 422, 48)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2594, 422, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2595, 422, 57)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2596, 422, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2597, 423, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2598, 423, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2599, 423, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2600, 423, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2601, 423, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2602, 423, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2603, 423, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2604, 423, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2605, 423, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2606, 423, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2607, 423, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2608, 423, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2609, 423, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2610, 423, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2611, 423, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2612, 423, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2613, 423, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2614, 424, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2615, 424, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2616, 424, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2617, 424, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2618, 424, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2619, 424, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2620, 424, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2621, 424, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2622, 424, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2623, 424, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2624, 424, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2625, 424, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2626, 424, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2627, 424, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2628, 424, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2629, 425, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2630, 425, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2631, 425, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2632, 425, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2633, 425, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2634, 425, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2635, 425, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2636, 425, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2637, 425, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2638, 425, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2639, 425, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2640, 425, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2641, 425, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2642, 425, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2643, 425, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2644, 425, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2645, 425, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2646, 425, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2647, 425, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2648, 426, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2649, 426, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2650, 426, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2651, 426, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2652, 426, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2653, 426, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2654, 427, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2655, 427, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2656, 427, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2657, 427, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2658, 427, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2659, 427, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2660, 427, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2661, 427, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2662, 428, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2663, 428, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2664, 428, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2665, 428, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2666, 428, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2667, 428, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2668, 429, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2669, 429, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2670, 429, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2671, 429, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2672, 429, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2673, 429, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2674, 429, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2675, 429, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2676, 429, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2677, 429, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2678, 429, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2679, 429, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2680, 429, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2681, 429, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2682, 429, 64)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2683, 430, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2684, 430, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2685, 430, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2686, 430, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2687, 430, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2688, 430, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2689, 430, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2690, 430, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2691, 430, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2692, 430, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2693, 430, 57)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2694, 430, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2695, 430, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2696, 431, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2697, 431, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2698, 431, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2699, 431, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2700, 431, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2701, 431, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2702, 431, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2703, 431, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2704, 431, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2705, 431, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2706, 431, 21)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2707, 431, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2708, 431, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2709, 431, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2710, 431, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2711, 431, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2712, 431, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2713, 431, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2714, 431, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2715, 431, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2716, 432, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2717, 432, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2718, 432, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2719, 432, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2720, 432, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2721, 432, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2722, 432, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2723, 432, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2724, 432, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2725, 432, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2726, 432, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2727, 432, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2728, 432, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2729, 432, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2730, 432, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2731, 432, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2732, 432, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2733, 432, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2734, 433, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2735, 433, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2736, 433, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2737, 433, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2738, 433, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2739, 433, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2740, 433, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2741, 433, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2742, 433, 21)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2743, 433, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2744, 433, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2745, 433, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2746, 433, 37)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2747, 433, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2748, 433, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2749, 433, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2750, 433, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2751, 433, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2752, 434, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2753, 434, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2754, 434, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2755, 434, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2756, 434, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2757, 434, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2758, 434, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2759, 434, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2760, 434, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2761, 434, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2762, 434, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2763, 434, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2764, 434, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2765, 434, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2766, 434, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2767, 434, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2768, 434, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2769, 434, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2770, 434, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2771, 434, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2772, 434, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2773, 434, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2774, 434, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2775, 435, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2776, 435, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2777, 435, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2778, 435, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2779, 435, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2780, 435, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2781, 435, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2782, 435, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2783, 436, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2784, 436, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2785, 436, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2786, 436, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2787, 436, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2788, 436, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2789, 436, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2790, 436, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2791, 436, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2792, 436, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2793, 436, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2794, 436, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2795, 436, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2796, 436, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2797, 436, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2798, 436, 48)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2799, 436, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2800, 436, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2801, 436, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2802, 436, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2803, 437, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2804, 437, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2805, 437, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2806, 437, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2807, 437, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2808, 437, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2809, 437, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2810, 437, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2811, 437, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2812, 437, 57)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2813, 438, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2814, 438, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2815, 438, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2816, 438, 4)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2817, 438, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2818, 438, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2819, 438, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2820, 438, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2821, 438, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2822, 438, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2823, 438, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2824, 438, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2825, 438, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2826, 438, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2827, 438, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2828, 438, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2829, 438, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2830, 438, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2831, 438, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2832, 438, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2833, 439, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2834, 439, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2835, 439, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2836, 439, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2837, 439, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2838, 439, 65)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2839, 437, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2840, 437, 66)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2841, 440, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2842, 440, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2843, 440, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2844, 440, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2845, 440, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2846, 440, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2847, 440, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2848, 440, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2849, 440, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2850, 440, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2851, 440, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2852, 440, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2853, 440, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2854, 440, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2855, 440, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2856, 440, 57)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2857, 440, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2858, 440, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2859, 440, 66)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2860, 441, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2861, 441, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2862, 441, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2863, 441, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2864, 441, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2865, 441, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2866, 441, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2867, 441, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2868, 441, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2869, 441, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2870, 441, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2871, 441, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2872, 441, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2873, 441, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2874, 441, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2875, 441, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2876, 441, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2877, 441, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2878, 441, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2879, 441, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2880, 441, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2881, 441, 64)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2882, 442, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2883, 442, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2884, 442, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2885, 442, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2886, 442, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2887, 442, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2888, 442, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2889, 442, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2890, 442, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2891, 442, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2892, 442, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2893, 442, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2894, 442, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2895, 442, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2896, 442, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2897, 442, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2898, 442, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2899, 442, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2900, 442, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2901, 442, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2902, 442, 57)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2903, 442, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2904, 442, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2905, 443, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2906, 443, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2907, 443, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2908, 443, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2909, 443, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2910, 443, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2911, 444, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2912, 444, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2913, 444, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2914, 444, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2915, 444, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2916, 444, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2917, 444, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2918, 444, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2919, 444, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2920, 444, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2921, 444, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2922, 444, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2923, 444, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2924, 444, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2925, 444, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2926, 445, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2927, 445, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2928, 445, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2929, 445, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2930, 446, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2931, 446, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2932, 446, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2933, 446, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2934, 446, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2935, 446, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2936, 446, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2937, 446, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2938, 446, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2939, 446, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2940, 446, 66)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2941, 447, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2942, 447, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2943, 447, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2944, 447, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2945, 447, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2946, 447, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2947, 447, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2948, 447, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2949, 447, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2950, 447, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2951, 447, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2952, 447, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2953, 447, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2954, 447, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2955, 447, 66)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2956, 448, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2957, 448, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2958, 448, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2959, 448, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2960, 448, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2961, 448, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2962, 448, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2963, 448, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2964, 448, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2965, 448, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2966, 448, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2967, 448, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2968, 448, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2969, 448, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2970, 448, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2971, 448, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2972, 449, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2973, 449, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2974, 449, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2975, 449, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2976, 449, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2977, 449, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2978, 449, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2979, 449, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2980, 449, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2981, 449, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2982, 449, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2983, 449, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2984, 449, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2985, 449, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2986, 449, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2987, 449, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2988, 449, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2989, 450, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2990, 450, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2991, 450, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2992, 450, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2993, 450, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2994, 450, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2995, 450, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2996, 450, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2997, 450, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2998, 450, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (2999, 450, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3000, 450, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3001, 450, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3002, 450, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3003, 450, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3004, 450, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3005, 450, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3006, 451, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3007, 451, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3008, 451, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3009, 451, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3010, 451, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3011, 451, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3012, 451, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3013, 451, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3014, 451, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3015, 452, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3016, 452, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3017, 452, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3018, 452, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3019, 452, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3020, 452, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3021, 452, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3022, 452, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3023, 453, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3024, 453, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3025, 453, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3026, 453, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3027, 453, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3028, 453, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3029, 453, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3030, 453, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3031, 453, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3032, 453, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3033, 453, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3034, 453, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3035, 453, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3036, 453, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3037, 453, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3038, 454, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3039, 454, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3040, 454, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3041, 454, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3042, 454, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3043, 454, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3044, 454, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3045, 454, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3046, 454, 16)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3047, 454, 21)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3048, 454, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3049, 454, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3050, 454, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3051, 454, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3052, 454, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3053, 454, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3054, 454, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3055, 454, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3056, 454, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3057, 454, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3058, 454, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3059, 454, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3060, 454, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3061, 455, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3062, 455, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3063, 455, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3064, 455, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3065, 455, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3066, 455, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3067, 455, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3068, 455, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3069, 455, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3070, 455, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3071, 455, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3072, 455, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3073, 455, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3074, 456, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3075, 456, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3076, 456, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3077, 456, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3078, 456, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3079, 456, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3080, 457, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3081, 457, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3082, 457, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3083, 457, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3084, 457, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3085, 457, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3086, 457, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3087, 457, 19)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3088, 457, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3089, 457, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3090, 458, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3091, 458, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3092, 458, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3093, 458, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3094, 458, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3095, 458, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3096, 459, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3097, 459, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3098, 459, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3099, 459, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3100, 459, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3101, 459, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3102, 459, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3103, 459, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3104, 459, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3105, 460, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3106, 460, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3107, 460, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3108, 460, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3109, 460, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3110, 460, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3111, 460, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3112, 460, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3113, 461, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3114, 461, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3115, 461, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3116, 461, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3117, 461, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3118, 461, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3119, 461, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3120, 461, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3121, 461, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3122, 461, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3123, 461, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3124, 461, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3125, 461, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3126, 461, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3127, 461, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3128, 461, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3129, 461, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3130, 461, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3131, 461, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3132, 462, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3133, 462, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3134, 462, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3135, 462, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3136, 462, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3137, 462, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3138, 462, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3139, 462, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3140, 462, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3141, 462, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3142, 462, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3143, 462, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3144, 462, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3145, 462, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3146, 462, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3147, 462, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3148, 462, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3149, 462, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3150, 462, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3151, 462, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3152, 463, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3153, 463, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3154, 463, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3155, 463, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3156, 463, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3157, 463, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3158, 463, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3159, 463, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3160, 463, 26)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3161, 463, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3162, 463, 48)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3163, 463, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3164, 463, 57)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3165, 463, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3166, 463, 66)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3167, 464, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3168, 464, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3169, 464, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3170, 464, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3171, 464, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3172, 464, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3173, 464, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3174, 464, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3175, 464, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3176, 464, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3177, 465, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3178, 465, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3179, 465, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3180, 465, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3181, 465, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3182, 465, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3183, 465, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3184, 465, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3185, 465, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3186, 465, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3187, 465, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3188, 465, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3189, 465, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3190, 465, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3191, 465, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3192, 465, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3193, 465, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3194, 466, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3195, 466, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3196, 466, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3197, 466, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3198, 466, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3199, 466, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3200, 466, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3201, 466, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3202, 466, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3203, 466, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3204, 466, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3205, 466, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3206, 466, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3207, 466, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3208, 467, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3209, 467, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3210, 467, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3211, 467, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3212, 467, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3213, 467, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3214, 467, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3215, 468, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3216, 468, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3217, 468, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3218, 468, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3219, 468, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3220, 468, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3221, 468, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3222, 468, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3223, 468, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3224, 468, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3225, 469, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3226, 469, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3227, 469, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3228, 469, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3229, 469, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3230, 469, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3231, 469, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3232, 469, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3233, 469, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3234, 469, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3235, 469, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3236, 469, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3237, 469, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3238, 469, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3239, 469, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3240, 470, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3241, 470, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3242, 470, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3243, 470, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3244, 470, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3245, 470, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3246, 471, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3247, 471, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3248, 471, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3249, 471, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3250, 471, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3251, 471, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3252, 471, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3253, 471, 24)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3254, 471, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3255, 471, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3256, 471, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3257, 471, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3258, 471, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3259, 472, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3260, 472, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3261, 472, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3262, 472, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3263, 472, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3264, 472, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3265, 472, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3266, 472, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3267, 472, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3268, 472, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3269, 472, 21)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3270, 472, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3271, 472, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3272, 472, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3273, 472, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3274, 472, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3275, 472, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3276, 472, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3277, 472, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3278, 472, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3279, 472, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3280, 472, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3281, 472, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3282, 474, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3283, 474, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3284, 474, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3285, 474, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3286, 474, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3287, 474, 20)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3288, 474, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3289, 474, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3290, 474, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3291, 474, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3292, 475, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3293, 475, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3294, 475, 6)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3295, 475, 7)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3296, 475, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3297, 475, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3298, 475, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3299, 475, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3300, 475, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3301, 475, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3302, 475, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3303, 475, 21)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3304, 475, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3305, 475, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3306, 475, 32)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3307, 475, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3308, 475, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3309, 475, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3310, 475, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3311, 475, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3312, 475, 59)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3313, 475, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3314, 476, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3315, 476, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3316, 476, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3317, 476, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3318, 476, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3319, 476, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3320, 476, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3321, 476, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3322, 476, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3323, 476, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3324, 476, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3325, 476, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3326, 476, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3327, 476, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3328, 476, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3329, 476, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3330, 476, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3331, 476, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3332, 477, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3333, 477, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3334, 477, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3335, 477, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3336, 477, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3337, 477, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3338, 477, 11)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3339, 477, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3340, 477, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3341, 477, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3342, 477, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3343, 477, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3344, 477, 21)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3345, 477, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3346, 477, 23)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3347, 477, 33)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3348, 477, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3349, 477, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3350, 477, 48)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3351, 477, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3352, 477, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3353, 477, 57)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3354, 477, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3355, 477, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3356, 477, 64)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3357, 477, 66)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3358, 478, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3359, 478, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3360, 478, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3361, 478, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3362, 478, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3363, 478, 10)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3364, 478, 12)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3365, 478, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3366, 478, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3367, 478, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3368, 478, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3369, 478, 30)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3370, 478, 34)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3371, 478, 35)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3372, 478, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3373, 478, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3374, 478, 51)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3375, 478, 52)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3376, 478, 53)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3377, 478, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3378, 478, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3379, 478, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3380, 479, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3381, 479, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3382, 479, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3383, 479, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3384, 479, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3385, 479, 15)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3386, 479, 61)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3387, 480, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3388, 480, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3389, 480, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3390, 480, 14)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3391, 480, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3392, 480, 38)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3393, 480, 41)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3394, 480, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3395, 480, 43)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3396, 480, 44)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3397, 480, 57)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3398, 480, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3399, 480, 62)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3400, 481, 1)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3401, 481, 2)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3402, 481, 3)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3403, 481, 8)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3404, 481, 9)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3405, 481, 13)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3406, 481, 18)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3407, 481, 22)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3408, 481, 42)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3409, 481, 60)
GO
INSERT [dbo].[FeaturesAtPark] ([PFID], [PID], [FID]) VALUES (3410, 481, 62)
GO
SET IDENTITY_INSERT [dbo].[FeaturesAtPark] OFF
GO
SET IDENTITY_INSERT [dbo].[Park] ON 

GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (2, N'Wildwood Park', N'1101 23rd Ave SE', N'Puyallup', N'Pierce', N'98374', 47.171212, -122.2781745, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (3, N'Allan Yorke Park', N'7203 West Tapps Hwy E', N'Bonney Lake', N'Pierce', N'98391', 47.1897496, -122.1654507, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (4, N'DeCoursey Park', N'1998 7th Ave SW', N'Puyallup', N'Pierce', N'98371', 47.186785, -122.3197859, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (5, N'McFarland Park', N'1391 Chinook Ave', N'Enumclaw', N'King', N'98022', 47.212209, -121.98630262, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (6, N'Bradley Lake Park', N'2791 7th St SE', N'Puyallup', N'Pierce', N'98374', 47.1610869, -122.2841332, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (7, N'Spanaway Park', N'14905 Bresemann Blvd S', N'Spanaway', N'Pierce', N'98387', 47.1164915, -122.4441807, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (8, N'Veterans Memorial Park', N'411 E Street NE', N'Auburn', N'King', N'98002', 47.3132602, -122.2213775, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (9, N'Auburn Game Farm Park', N'3030 R St SE', N'Auburn', N'King', N'98002', 47.280441, -122.2054517, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (10, N'Mill Creek Earthworks Park', N'1000 Reiten Road', N'Kent', N'King', N'98030', 47.3822848, -122.2226734, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (11, N'Lake Fenwick Park', N'25828 Lake Fenwick Rd S', N'Kent', N'King', N'98032', 47.3682825, -122.2721941, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (12, N'Celebration Park', N'1095 S. 324th St', N'Federal Way', N'King', N'98003', 47.3083286, -122.3202592, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (13, N'Lake Tapps Park', N'198th Ave E', N'Bonney Lake', N'Pierce', N'98391', 47.2420453, -122.1678951, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (14, N'Titlow Park', N'8425 6th Avenue', N'Tacoma', N'Pierce', N'98456', 47.2531536, -122.5495709, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (15, N'Sam Peach Park', N'1621 10th Ave NW', N'Puyallup', N'Pierce', N'98371', 47.199963, -122.315297, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (16, N'Grayland Park', N'601 N. Meridian', N'Puyallup', N'Pierce', N'98371', 47.1953972, -122.2926226, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (17, N'Pioneer Park', N'Elm Pl & S. Meridian', N'Puyallup', N'Pierce', N'98371', 47.1893184, -122.2948858, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (18, N'Puyallup Valley Sports Center', N'820 Valley Ave NW', N'Puyallup', N'Pierce', N'98371', 47.2093331, -122.3041438, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (19, N'Rainier Woods Park', N'2310 Cherokee Blvd.', N'Puyallup', N'Pierce', N'98371', 47.1661639, -122.3229222, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (20, N'Clark''s Creek', N'~1901 7th Ave SW', N'Puyallup', N'Pierce', N'98371', 47.1820015, -122.3197859, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (21, N'Puyallup Skatepark', N'1299 4th St NW', N'Puyallup', N'Pierce', N'98371', 47.2021308, -122.2976782, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (22, N'Dacca Park Athletic Fields', N'2785 5th Ave E', N'Fife', N'Pierce', N'98424', 47.2310942, -122.3582427, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (23, N'Wedge Park', N'5920 Valley Ave E', N'Fife', N'Pierce', N'98424', 47.232003, -122.350013, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (24, N'Colburn Park', N'5506 20th St E', N'Fife', N'Pierce', N'98424', 47.2383371, -122.3554069, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (25, N'Five Acre Park', N'6335 Radiance Blvd E', N'Fife', N'Pierce', N'98424', 47.22581, -122.343951, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (26, N'Hylebos Nature Area', N'6125 8th St E', N'Fife', N'Pierce', N'98424', 47.250104, -122.346852, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (27, N'Glacier View Park', N'Fir Ave N', N'Eatonville', N'Pierce', N'98328', 46.8699979, -122.2724811, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (28, N'Ashford County Park', N'29801 State Route 706', N'Ashford', N'Pierce', N'98304', 46.7614465, -122.0397065, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (29, N'Fort Steilacoom Park', N'8714 87th Ave S', N'Lakewood', N'Pierce', N'98498', 47.1705893, -122.5648762, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (30, N'Sunset Terrace Park', N'Seaview Ave W', N'University Place', N'Pierce', N'98466', 47.2419648, -122.1906568, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (31, N'China Lake Park', N'1811 S Shirley St', N'Tacoma', N'Pierce', N'98465', 47.2457803, -122.5092807, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (32, N'Delong Park', N'4702 S 12th Place', N'Tacoma', N'Pierce', N'98405', 47.2473677, -122.4989232, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (33, N'Snake Lake Park/Tacoma Nature Center', N'1919 S Tyler St', N'Tacoma', N'Pierce', N'98405', 47.2409061, -122.49363, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (34, N'Heidelberg-Davis Park', N'South 19th St', N'Tacoma', N'Pierce', N'98405', 47.2419434, -122.496709, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (35, N'Franklin Park', N'S Puget Sound Ave', N'Tacoma', N'Pierce', N'98405', 47.2480979, -122.4814218, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (36, N'Jefferson Park', N'North Monroe St', N'Tacoma', N'Pierce', N'98406', 47.2582352, -122.4909363, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (37, N'War Memorial Park', N'7100 6th Ave', N'Tacoma', N'Pierce', N'98406', 47.2572094, -122.5359984, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (38, N'Vassault Playfield', N'6298 N 37th St', N'Tacoma', N'Pierce', N'98407', 47.2809054, -122.5187874, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (39, N'Baltimore Park', N'4716 N Baltimore St', N'Tacoma', N'Pierce', N'98407', 47.2922447, -122.5093725, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (40, N'Rust Park', N'5405 N Commercial St', N'Tacoma', N'Pierce', N'98407', 47.2970177, -122.5115069, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (41, N'Point Defiance Park', N'5400 N Pearl St', N'Tacoma', N'Pierce', N'98407', 47.3078759, -122.5309605, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (42, N'Marine Park', N'Ruston Way', N'Tacoma', N'Pierce', N'98407', 47.2864226, -122.4907891, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (43, N'Puget Creek Natural Area', N'3100 N Proctor St', N'Tacoma', N'Pierce', N'98407', 47.2766082, -122.4818975, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (44, N'Dickman Mill Park', N'2423 Ruston Way', N'Tacoma', N'Pierce', N'98402', 47.2762193, -122.4751853, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (45, N'Old Town Park', N'2350 N 30th St', N'Tacoma', N'Pierce', N'98403', 47.2736529, -122.4748798, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (46, N'Gateway Park', N'North 30th St', N'Tacoma', N'Pierce', N'98403', 47.2749288, -122.4657046, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (47, N'Tacoma Chinese Garden and Reconciliation Park', N'1741 N Schuster Parkway', N'Tacoma', N'Pierce', N'98402', 47.2749093, -122.4609299, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (48, N'Garfield Park', N'N Burough Rd', N'Tacoma', N'Pierce', N'98403', 47.2687942, -122.4575825, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (49, N'Wright Park', N'501 S I St', N'Tacoma', N'Pierce', N'98405', 47.2559401, -122.4500033, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (50, N'Thea''s Park', N'405 Dock St', N'Tacoma', N'Pierce', N'98402', 47.2610656, -122.4395577, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (51, N'Neighbors'' Park', N'722 S I St', N'Tacoma', N'Pierce', N'98405', 47.2554285, -122.4487604, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (52, N'People''s Park', N'900 Martin Luther King Jr Way', N'Tacoma', N'Pierce', N'98405', 47.2540524, -122.4543926, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (53, N'Fireman''s Park', N'801 A St', N'Tacoma', N'Pierce', N'98402', 47.2536126, -122.4529508, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (54, N'Frost Park', N'S 9th St', N'Tacoma', N'Pierce', N'98402', 47.2551594, -122.4394471, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (55, N'Peck Athletic Field', N'1425 S State St', N'Tacoma', N'Pierce', N'98405', 47.2468925, -122.4655159, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (56, N'Ferry Park', N'1410 14th St', N'Tacoma', N'Pierce', N'98405', 47.2483271, -122.4551495, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (57, N'Don Pugnetti Park', N'2085 Pacific Ave', N'Tacoma', N'Pierce', N'98402', 47.243387, -122.4355513, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (58, N'Lincoln Park', N'747 Market St', N'Tacoma', N'Pierce', N'98402', 47.2269677, -122.443672, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (59, N'Verlo Playfield', N'907 Upper Park St', N'Tacoma', N'Pierce', N'98404', 47.2173822, -122.4195714, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (60, N'Portland Avenue Park', N'3513 Portland Ave', N'Tacoma', N'Pierce', N'98404', 47.2319195, -122.4057142, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (61, N'South Park', N'4851 S Tacoma Way', N'Tacoma', N'Pierce', N'98409', 47.2104732, -122.4800813, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (62, N'Wapato Park', N'6500 S Sheridan Ave', N'Tacoma', N'Pierce', N'98408', 47.1962011, -122.4553889, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (63, N'Seeley Lake Park', N'9112 Lakewood Dr SW', N'Tacoma', N'Pierce', N'98499', 47.1725491, -122.5081472, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (64, N'Wards Lake Park', N'84th St Ct S', N'Tacoma', N'Pierce', N'98499', 47.1800726, -122.4725427, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (65, N'Skate Park', N'Fairlawn Rd SW', N'Tacoma', N'Pierce', N'98499', 47.1753283, -122.517029, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (66, N'Kobayashi Park', N'Kobayashi Park Dr', N'University Place', N'Pierce', N'98467', 47.1984391, -122.5269932, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (67, N'Lakewood Active Park', N'10506 Russell Rd SW', N'Lakewood', N'Pierce', N'98499', 47.1461544, -122.5369351, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (69, N'American Lake North Park', N'Vernon St and Veteran''s Dr SW', N'Lakewood', N'Pierce', N'98498', 47.1417587, -122.5585342, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (70, N'Harry Todd Park', N'N Throne Lane SW', N'Lakewood', N'Pierce', N'98498', 47.1283926, -122.5542268, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (71, N'Washington Park', N'11603 Farwest Dr SW', N'Lakewood', N'Pierce', N'98498', 47.14998, -122.5726818, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (72, N'Summer Cove', N'San Antonio Place', N'Fort Lewis', N'Pierce', N'98433', 47.1260018, -122.5792035, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (73, N'Shoreline Park', N'Shoreline Beach Rd', N'Fort Lewis', N'Pierce', N'98433', 47.1158996, -122.5830758, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (74, N'Pioneer Orchard Park', N'1700 Commercial St', N'Steilacoom', N'Pierce', N'98388', 47.1737945, -122.598803, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (75, N'Sunnyside Beach Park', N'Chambers Creek Rd W', N'Steilacoom', N'Pierce', N'98388', 47.1803633, -122.5889269, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (76, N'Chamber''s Creek Properties Dog Park', N'Chamber''s Creek Properties', N'University Place', N'Pierce', N'98467', 47.197994, -122.576859, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (77, N'Bresemann Forest', N'8th Ave Ct S', N'Parkland', N'Pierce', N'98444', 47.1248569, -122.4600799, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (78, N'Sprinker Recreation Center', N'14824 C St S', N'Tacoma', N'Pierce', N'98444', 47.1226312, -122.4405726, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (79, N'Mayfair County Park', N'13th Ave Ct E', N'Parkland', N'Pierce', N'98445', 47.1324841, -122.4112039, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (80, N'Fernhill Park', N'502 S 88th St', N'Tacoma', N'Pierce', N'98444', 47.1773518, -122.4404146, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (81, N'Stewart Heights Park', N'402 E 56th St', N'Tacoma', N'Pierce', N'98404', 47.2048171, -122.4266203, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (82, N'Gas Station Park', N'4802 S Park Ave', N'Tacoma', N'Pierce', N'98408', 47.2134035, -122.44216780000001, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (83, N'Dawson Playfield', N'9000 Portland Ave E', N'Tacoma', N'Pierce', N'98445', 47.1765212, -122.4063316, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (84, N'Cloverdale Park', N'1635 E 59th St', N'Tacoma', N'Pierce', N'98404', 47.2040939, -122.4085157, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (85, N'Swan Creek County Park', N'2820 Pioneer Way', N'Tacoma', N'Pierce', N'98404', 47.2277486, -122.3916051, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (86, N'South Hill Park', N'144th St E', N'South Hill', N'Pierce', N'98373', 47.1261922, -122.3149975, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (87, N'Orting Dog Park/Callistoga Park', N'Levee Rd SW', N'Orting', N'Pierce', N'98360', 47.0900734, -122.212067, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (88, N'Whitehawk Park/Gratzer Sports Park', N'Orting Ave NW', N'Orting', N'Pierce', N'98360', 47.098612, -122.21508, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (89, N'Orting Park - North, Central and South', N'Van Scoyoc Ave SW', N'Orting', N'Pierce', N'98360', 47.0942258, -122.2052302, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (90, N'Orting Skate Park', N'Olive St SE', N'Orting', N'Pierce', N'98360', 47.0942258, -122.1988864, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (91, N'Orting Lions Club', N'19725 Orville Rd E', N'Orting', N'Pierce', N'98360', 47.0764271, -122.1864036, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (92, N'VanderHoof Park', N'SR 410', N'Buckley', N'Pierce', N'98321', 47.165147, -122.0276793, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (94, N'A Street Park', N'Jefferson Ave and A St S', N'Buckley', N'Pierce', N'98321', 47.1597229, -122.0271627, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (95, N'Elk Heights Park', N'Davis St', N'Buckley', N'Pierce', N'98321', 47.155756, -122.0128184, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (96, N'Mountain View Ave Park', N'600 Mountain View Ave', N'Orting', N'Pierce', N'98321', 47.1553909, -122.0294166, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (97, N'Third Street Park', N'206 3rd St SW', N'South Prairie', N'Pierce', N'98321', 47.1367489, -122.0994578, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (98, N'Cedarview Park', N'9301 208th Ave E', N'Bonney Lake', N'Pierce', N'98391', 47.1729079, -122.1547399, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (99, N'Ken Simmons Park', N'18200 74th St E', N'Bonney Lake', N'Pierce', N'98391', 47.1900042, -122.188452, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (100, N'Madrona Park', N'7730 182nd Ave E', N'Bonney Lake', N'Pierce', N'98391', 47.1847756, -122.1888177, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (101, N'Victor Falls Park', N'18212 Rhodes Lake Rd E', N'Bonney Lake', N'Pierce', N'98391', 47.1500199, -122.1871221, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (102, N'Viking Park', N'18902 82nd St E', N'Bonney Lake', N'Pierce', N'98391', 47.1831751, -122.1775823, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (103, N'Sprout Holler', N'Village Parkway E', N'Bonney Lake', N'Pierce', N'98391', 47.1329409, -122.176988, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (104, N'The Edge', N'Canyon View Blvd', N'Bonney Lake', N'Pierce', N'98391', 47.131905, -122.173302, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (105, N'Manorwood Park', N'2310 Manorwood Dr', N'Puyallup', N'Pierce', N'98374', 47.1581698, -122.2636744, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (106, N'Riverside County Park', N'78th St E', N'Sumner', N'Pierce', N'98390', 47.1855481, -122.2159751, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (107, N'Loyalty Park', N'1300 Park St', N'Sumner', N'Pierce', N'98390', 47.199651, -122.237364, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (108, N'Daffodil Valley Sports Complex', N'15225 Washington St E', N'Sumner', N'Pierce', N'98390', 47.2065158, -122.225725, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (109, N'Reuben A. Knoblauch Heritage Park', N'914 Kincaid Ave', N'Sumner', N'Pierce', N'98391', 47.2027928, -122.241658, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (110, N'Rainier View Park', N'15603 Meade McCumber Rd', N'Sumner', N'Pierce', N'98390', 47.1976964, -122.2233369, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (111, N'Seibenthaller Park', N'1602 Bonney Ave', N'Sumner', N'Pierce', N'98390', 47.2092589, -122.2363075, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (113, N'Tacoma Narrows Park', N'1502 Lucille Parkway NW', N'Gig Harbor', N'Pierce', N'98335', 47.2672371, -122.5658436, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (114, N'Skansie Brothers Park', N'3211 Harborview Dr', N'Gig Harbor', N'Pierce', N'98335', 47.3305781, -122.5819951, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (115, N'Civic Center Green', N'3510 Grandview St', N'Gig Harbor', N'Pierce', N'98335', 47.322054, -122.5866452, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (116, N'Adam Tallman Park', N'6626 Wagner Way NW', N'Gig Harbor', N'Pierce', N'98335', 47.319031, -122.5967125, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (118, N'Fox Island Sand Spit', N'Bella Bella Drive FI', N'Fox Island', N'Pierce', N'98333', 47.2770061, -122.6646525, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (119, N'Fox Island Fishing Pier', N'1453 Ozette Dr FI', N'Fox Island', N'Pierce', N'98333', 47.2285321, -122.5911128, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (120, N'Hales Pass Park', N'3607 Ray Nash Dr NW', N'Gig Harbor', N'Pierce', N'98335', 47.289968, -122.6668726, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (121, N'Kopachuk State Park', N'10712 56th St NW', N'Gig Harbor', N'Pierce', N'98335', 47.3087474, -122.6781362, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (122, N'Cutts Island State Park', N'Cutts Island', N'Gig Harbor', N'Pierce', N'98335', 47.320923, -122.687159, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (123, N'Kenneth Leo Marvin Veterans Memorial Park', N'3580 50th St Ct NW', N'Gig Harbor', N'Pierce', N'98335', 47.3030299, -122.5860585, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (124, N'City Park at Crescent Creek', N'3303 Vernhardson St', N'Gig Harbor', N'Pierce', N'98332', 47.3454129, -122.5797483, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (125, N'Eddon Boat Park', N'3805 Harborview Dr', N'Gig Harbor', N'Pierce', N'98335', 47.3337809, -122.5889258, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (126, N'Donkey Creek Park', N'8714 Harborview Dr', N'Gig Harbor', N'Pierce', N'98332', 47.3377195, -122.5946682, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (127, N'Rosedale Park', N'86th Ave NW and Rosedale St NW', N'Gig Harbor', N'Pierce', N'98335', 47.3308522, -122.6541196, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (128, N'Sunrise Beach Park', N'10015 Sunrise Beach Dr NW', N'Gig Harbor', N'Pierce', N'98332', 47.3498877, -122.5570929, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (129, N'Sehmel Homestead Park', N'10123 78th Ave NW', N'Gig Harbor', N'Pierce', N'98332', 47.3512234, -122.6303802, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (130, N'McCormick Forest Park', N'10301 Bujacich Rd NW', N'Gig Harbor', N'Pierce', N'98332', 47.3523177, -122.6186672, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (131, N'Rotary Bark Park', N'10100 Bujacich Rd NW', N'Gig Harbor', N'Pierce', N'98332', 47.350872, -122.621564, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (132, N'Tubby''s Trail Dog Park ', N'1701 14th Ave NW', N'Gig Harbor', N'Pierce', N'98335', 47.2777775, -122.5603065, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (133, N'Crescent Lake County Park', N'3510 Grandview St', N'Gig Harbor', N'Pierce', N'98335', 47.39468844, -122.567507, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (134, N'Maplewood Park', N'14600 14th Ave NW', N'Gig Harbor', N'Pierce', N'98332', 47.3903724, -122.5562399, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (135, N'Purdy Sand Spit', N'Washington SR 302', N'Gig Harbor', N'Pierce', N'98329', 47.3808995, -122.6391228, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (136, N'Penrose Point State Park', N'321 158th Ave KP South', N'Lakebay', N'Pierce', N'98349', 47.2576685, -122.7433775, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (137, N'Joemma Beach State Park', N'20001 Bay Road KP South', N'Longbranch', N'Pierce', N'98351', 47.2254708, -122.8091532, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (138, N'Key Peninsula Metro Parks', N'5514 Key Peninsula Highway', N'Lakebay', N'Pierce', N'98349', 47.3082779, -122.7556183, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (139, N'Springbrook Park', N'12601th St SW', N'Lakewood', N'Pierce', N'98499', 47.1429056, -122.5013869, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (140, N'Edgewater Park', N'9102 Edgewater Dr SW', N'Lakewood', N'Pierce', N'98499', 47.1741372, -122.5354221, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (141, N'Christopher Columbus Bocce Courts', N'Forrest Park Dr', N'Fircrest', N'Pierce', N'98466', 47.2299532, -122.5113925, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (142, N'George Masko Park', N'134 Ramsdell St', N'Fircrest', N'Pierce', N'98466', 47.232393, -122.507044, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (143, N'Homestead Park', N'3715 Bridgeport Way W', N'University Place', N'Pierce', N'98466', 47.2231439, -122.5382532, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (144, N'Fircrest Park', N'555 Contra Costa Ave', N'Fircrest', N'Pierce', N'98466', 47.23437, -122.511378, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (145, N'Cirque Bridgeport Park', N'7250 Cirque Dr W', N'University Place', N'Pierce', N'98466', 47.2119938, -122.5342154, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (146, N'Millpond Park', N'Alder St E', N'Eatonville', N'Pierce', N'98328', 47.862357, -122.264856, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (147, N'Pacific City Park', N'600 3rd Ave SE', N'Pacific', N'King', N'98047', 47.264111, -122.2368896, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (148, N'Frontier Park', N'21718 Meridian Ave E', N'Graham', N'Pierce', N'98338', 47.0591971, -122.2969316, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (149, N'Sunrise Visitor Center', N'Sunrise Park Rd', N'Ashford', N'Pierce', N'98304', 47.9140844, -122.6441602, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (150, N'Henry M Jackson Visitor Center', N'39000 WA-706', N'Ashford', N'Pierce', N'98304', 47.7864549, -122.7382209, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (151, N'Alderwood Park', N'208 Browns Point Blvd', N'Tacoma', N'Pierce', N'98422', 47.2869923, -122.3889551, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (152, N'Alling Park', N'1134 S. 60th St.', N'Tacoma', N'Pierce', N'98408', 47.2028644, -122.4524257, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (153, N'Browns Point Athletic Complex', N'1526 51st St NE', N'Tacoma', N'Pierce', N'98422', 47.301781, -122.42376, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (154, N'Brown''s Point Lighthouse Park', N'201 Tulalip St NE', N'Tacoma', N'Pierce', N'98422', 47.3053722, -122.4438329, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (155, N'Browns Point Playfield', N'4915 La Hal Da Lane NE', N'Tacoma', N'Pierce', N'98422', 47.3018319, -122.4401733, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (156, N'Cumming''s Park', N'3939 Ruston Way', N'Tacoma', N'Pierce', N'98402', 47.287103, -122.488931, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (157, N'Dash Point Park', N'1500 Beach Dr NE', N'Tacoma', N'Pierce', N'98422', 47.3191803, -122.4268471, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (158, N'Hamilton Park', N'321 Ruston Way', N'Tacoma', N'Pierce', N'98402', 47.2765499, -122.4687572, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (159, N'Irving Park', N'2502 Hosmer St', N'Tacoma', N'Pierce', N'98405', 47.236316, -122.462122, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (160, N'Jack Hyde Park', N'2201 Ruston Way', N'Tacoma', N'Pierce', N'98402', 47.2752638, -122.4644025, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (161, N'Jane Clark Park', N'4825 N 39th St', N'Tacoma', N'Pierce', N'98407', 47.2851304, -122.5035159, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (162, N'Kandle Park', N'2323 N Shirley St', N'Tacoma', N'Pierce', N'98406', 47.2700411, -122.5085643, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (163, N'Lincoln Heights Park', N'3690 S. Steele St', N'Tacoma', N'Pierce', N'98409', 47.227116, -122.469322, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (164, N'Lots for Tots', N'1216 South I St', N'Tacoma', N'Pierce', N'98405', 47.250543, -122.448928, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (165, N'Manitou Park', N'4408 American Lake Blvd', N'Tacoma', N'Pierce', N'98409', 47.1960869, -122.4984261, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (166, N'McCarver Park', N'2301 South J St', N'Tacoma', N'Pierce', N'98405', 47.239643, -122.44734, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (167, N'Norpoint', N'4818 Nassau Ave NE', N'Tacoma', N'Pierce', N'98422', 47.299032, -122.404466, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (168, N'North Slope Historic District Park', N'1015 N 85th St', N'Tacoma', N'Pierce', N'98403', 47.2631762, -122.4606136, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (169, N'Northeast Tacoma Playground', N'5520 29th St NE', N'Tacoma', N'Pierce', N'98422', 47.281955, -122.373589, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (170, N'Oakland Madrona Park', N'3114 S Madison St', N'Tacoma', N'Pierce', N'98409', 47.2320262, -122.4932897, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (171, N'Optimist Park', N'1330 N James St', N'Tacoma', N'Pierce', N'98406', 47.263216, -122.534826, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (172, N'Puget Park', N'3111 N. Proctor St', N'Tacoma', N'Pierce', N'98407', 47.2759012, -122.4896494, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (173, N'Rogers Park', N'3151 East L St', N'Tacoma', N'Pierce', N'98404', 47.2331721, -122.41541, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (174, N'Roosevelt Park', N'3601 E Roosevelt Ave', N'Tacoma', N'Pierce', N'98404', 47.225973, -122.398586, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (175, N'Ryan''s Park', N'429 S. 80th St', N'Tacoma', N'Pierce', N'98408', 47.184615, -122.437007, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (176, N'Sawyer Tot Lot', N'3315 S. Sawyer St', N'Tacoma', N'Pierce', N'98418', 47.229212, -122.453977, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (177, N'Sheridan Park', N'2347 S. Sheridan Ave', N'Tacoma', N'Pierce', N'98405', 47.2376327, -122.4528505, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (178, N'South End Recreation and Adventure (SERA)', N'6002 S. Adam St', N'Tacoma', N'Pierce', N'98409', 47.2006646, -122.4902047, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (179, N'Ursich Park', N'2412 N. 29th St', N'Tacoma', N'Pierce', N'98403', 47.2734521, -122.4700414, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (180, N'Wapato Hills Park', N'6231 S. Wapato St', N'Tacoma', N'Pierce', N'98409', 47.199501, -122.467767, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (182, N'Lakewold Garden''s', N'12317 Gravelly Lake Dr SW', N'Lakewood', N'Pierce', N'98499', 47.1461544, -122.5369351, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (183, N'Sticks n Stones', N'Parkview Ct E', N'Bonney Lake', N'Pierce', N'98391', 47.124666, -122.166873, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (184, N'Big Sky Park', N'Village Parkway E', N'Bonney Lake', N'Pierce', N'98391', 47.1277194, -122.1859127, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (188, N'Charlottes Blueberry Park', N'7402 East D St', N'Tacoma', N'Pierce', N'98404', 47.199501, -122.467767, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (189, N'Avonlea Park', N'4112 Inglewood Loop SE', N'Lacey', N'Thurston', N'98503', 47.009799, -122.8345218, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (190, N'Brooks Park', N'1313 College St E', N'Lacey', N'Thurston', N'98503', 47.0347773, -122.8260496, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (191, N'Civic Plaza', N'521 Sleater Kinney Rd SE', N'Lacey', N'Thurston', N'98503', 47.0446703, -122.834312, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (192, N'West Plaza Park', N'780 Sleater Kinney Rd SE', N'Lacey', N'Thurston', N'98503', 47.0408159, -122.8334999, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (193, N'Homann Park', N'1301 Carpenter Rd SE', N'Lacey', N'Thurston', N'98503', 47.0346147, -122.8035045, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (194, N'Horizon Pointe Park', N'5700 Ruddell Rd SE', N'Lacey', N'Thurston', N'98503', 46.9865408, -122.8109954, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (195, N'Thomas W. Huntamer Park', N'618 Woodland Square Loop SE', N'Lacey', N'Thurston', N'98503', 47.0405481, -122.8275796, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (196, N'I-5 Park', N'4251 3rd Ave SE', N'Lacey', N'Thurston', N'98503', 47.0452812, -122.8327049, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (197, N'Wonderwood Park', N'5304 Sunset Dr SE', N'Lacey', N'Thurston', N'98503', 47.0193214, -122.8156586, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (198, N'Lake Lois Park', N'6020 7th Ave SE', N'Lacey', N'Thurston', N'98503', 47.0411973, -122.8010238, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (199, N'Lakepointe Park', N'6400 Compton Blvd SE', N'Lacey', N'Thurston', N'98503', 46.9926681, -122.7969559, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (200, N'Long Lake Park', N'2790 Carpenter Road', N'Lavcey', N'Thurston', N'98503', 47.0217466, -122.7893784, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (201, N'Meridian Neighborhood Park', N'8855 Campus Glen Drive NE', N'Lacey', N'Thurston', N'98503', 47.0829096, -122.7531358, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (203, N'Rooster Rock State Park', N'Exit 25 and Highway 84', N'Corbett', N'Multnomah ', N'97019', 45.5468365, -122.2386571, N'OR')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (204, N'East City Park', N'900 East Third Street', N'Moscow', N'Latah', N'83843', 46.7330899, -116.9910006, N'ID')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (205, N'Mission Dolores Park', N'19th and Dolores St', N'San Francisco', N'San Francisco', N'94114', 37.7585526, -122.4264221, N'CA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (206, N'Alamo Square Playground', N'Steiner Street', N'San Francisco', N'San Francisco', N'94117', 37.776406, -122.43436, N'CA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (207, N'Mills Park', N'1111 E Williams St', N'Carson City', N'Washoe', N'89701', 39.1699453, -119.7589311, N'NV')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (208, N'Himmel Park', N'1000 N Tucson Blvd', N'Tucson', N'Pima', N'85716', 32.2328585, -110.933352, N'AZ')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (209, N'Cahoon Park', N'1101 W 4th St', N'Roswell', N'Chaves', N'88201', 33.3980093, -104.5376023, N'NM')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (210, N'Trinity Park', N'2401 University Dr', N'Fort Worth', N'Tarrant', N'79107', 32.7402637, -97.3526952, N'TX')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (211, N'Murray Park', N'296 E Murray Park Ave', N'Murray', N'Salt Lake', N'84107', 40.6609683, -111.8792361, N'UT')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (212, N'Tom Bertagnolli Park', N'500 E Cedar St', N'Three Forks', N'Gallatin', N'59752', 45.8927081, -111.5457776, N'MT')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (213, N'Jaycee Park', N'1600 W Sunset Drive', N'Riverton', N'Fremont ', N'82501', 43.0346414, -108.4126315, N'WY')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (214, N'Waneka Lake Park', N'1600 Caria Dr', N'Lafayette', N'Boulder', N'80026', 39.9924599, -105.1247671, N'CO')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (215, N'Tom Tenorio Park', N'2900 Arenal Rd SW', N'Albuquerque', N'Bernalillo', N'87121', 35.0495611, -106.7199847, N'NM')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (216, N'Cross Ranch State Park', N'1403 River Road', N'Center', N'Oliver ', N'58530', 47.2189669, -101.0047187, N'ND')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (217, N'Ravine Lake Park', N'Easy Street', N'Huron', N'Beadle ', N'57350', 44.3675045, -98.2159095, N'SD')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (218, N'Riverside Park', N'1600 S Beltline Hwy W', N'Scottsbluff', N'Scotts Bluff', N'69361', 41.8541096, -103.6879414, N'NE')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (219, N'Elmdale Park', N'400 East Avenue E', N'Hutchinson', N'Reno', N'67501', 38.0471047, -97.9300584, N'KS')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (220, N'Dolese Youth Park', N'5105 NW 50th St', N'Oklahoma City', N'Oklahoma', N'73122', 35.0585836, -100.5332416, N'OK')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (221, N'Peavey Park', N'730 E 22nd St', N'Minneapolis', N'Hennepin', N'55404', 44.9624136, -93.2671142, N'MN')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (222, N'Dexter County Park', N'8200 WI-54', N'Pittsville', N'Wood', N'54466', 44.3850792, -90.1671303, N'WI')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (223, N'Manistique Central Park', N'Lake St', N'Manistique', N'Schoolcraft', N'49854', 45.959996, -86.2445831, N'MI')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (224, N'Little Bridge Park', N'101 Adair St', N'De Soto', N'Dallas', N'50069', 41.5285407, -94.0110448, N'IA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (225, N'Castlewood State Park', N'1401 Kiefer Creek Rd', N'Ballwin', N'St. Louis', N'63021', 38.5454803, -90.6006668, N'MO')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (226, N'William Zimmer Memorial Park', N'730 Rogers St', N'Waterloo', N'Monroe', N'62298', 38.3510906, -90.1456897, N'IL')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (227, N'Lake Cherrywood Park', N'300 Summitt St', N'Sherwood', N'Pulaski', N'72120', 34.8294418, -92.2038794, N'AR')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (228, N'North Bossier Park', N'4307 Old Brownlee Rd', N'Bossier City', N'Bossier', N'71111', 32.5821031, -93.7392537, N'LA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (229, N'Robertson Park', N'Blackwell Street', N'Collins', N'Covington', N'39428', 31.6337468, -89.5521126, N'MS')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (230, N'Bladon Springs State Park', N'3921 Bladon Rd', N'Silas', N'Choctaw', N'36919', 31.7350292, -88.2805199, N'AL')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (231, N'Wekiwa Springs State Park', N'1800 Wekiwa Cir', N'Apopka', N'Orange', N'32712', 28.7113508, -81.4672561, N'FL')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (232, N'Apple Valley Park', N'1719 Marvin Griffin Rd', N'Augusta', N'Richmond', N'30906', 33.3937125, -81.9991167, N'GA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (233, N'Montgomery Bell State Park', N'1020 Jackson Hill Rd', N'Burns', N'Dickson', N'37029', 36.0859392, -87.3494275, N'TN')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (234, N'Mammoth Cave National Park', N'1 Mammoth Cave Pkwy', N'Mammoth Cave', N'Edmonson', N'42259', 37.1753149, -86.4413841, N'KY')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (235, N'Future Park', N'400 S Apperson Way', N'Kokomo', N'Howard', N'46901', 40.4840047, -86.1369645, N'IN')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (236, N'Stephens Drive Park', N'915 W Stephen Dr', N'Columbus', N'Franklin', N'43204', 39.9363898, -83.0898131, N'OH')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (237, N'Green Tree Park', N'905 Greentree Rd', N'Pittsburgh', N'Allegheny', N'15220', 40.4234248, -80.0467443, N'PA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (238, N'Audra State Park', N'Audra Park Rd', N'Buckhannon', N'Upshur', N'26201', 39.0401775, -80.069777, N'WV')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (239, N'Mount Blue State Park', N'299 Center Hill Rd', N'Weld', N'Franklin', N'04285', 44.7968484, -70.5456874, N'ME')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (240, N'Umbagog State Park', N'NH-26', N'Errol', N'Coös', N'03579', 44.7267717, -71.0779252, N'NH')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (241, N'Mount Philo State Park', N'5425 Mt Philo Rd', N'Charlotte', N'Chittenden', N'05445', 44.2651697, -73.2386503, N'VT')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (242, N'Westmoreland Park', N'130 Westmoreland Avenue', N'Syracuse', N'Onondaga', N'13210', 43.0499064, -76.1162402, N'NY')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (243, N'Doolittle Park', N'78 S Elm St', N'Wallingford', N'New Haven', N'06492', 41.449089, -72.8173356, N'CT')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (244, N'War Memorial Park', N'65 N Main St', N'West Bridgewater', N'Plymouth', N'02379', 42.0153108, -71.0101561, N'MA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (245, N'Snake Den State Park', N'2321 Hartford Ave', N'Johnston', N'Providence', N'02919', 41.8282504, -71.5851131, N'RI')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (246, N'Piney Run Park', N'30 Martz Rd', N'Sykesville', N'Carroll', N'21784', 39.3947827, -77.0148439, N'MD')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (247, N'Edward R. Murrow Park', N'H Street NW and 18th Street NW', N'Washington', N'District of Columbia', N'20006', 38.9009455, -77.0414565, N'DC')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (248, N'Behrman Park', N'2200 Margerum Ave', N'Lake Como', N'Monmouth', N'07719', 40.1664778, -74.0314326, N'NJ')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (249, N'Mayfair', N'154 Blue Beach Dr', N'Dover', N'Kent', N'19904', 39.1396793, -75.5397816, N'DE')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (250, N'Dorey Park', N'2999 Darbytown Rd', N'Henrico', N'Henrico', N'23231', 37.4634313, -77.3350925, N'VA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (251, N'Woodlawn Park', N'100 N Woodlawn Ave', N'Greenville', N'Pitt', N'27858', 35.6137351, -77.3643213, N'NC')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (252, N'Myrtle Beach State Park', N'4401 S Kings Hwy', N'Myrtle Beach', N'Horry', N'29575', 33.6470537, -78.9432732, N'SC')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (253, N'Growden Park', N'1100 Wilbur Street', N'Fairbanks', N'Fairbanks North Star Borough', N'99701', 64.840154, -147.7622065, N'AK')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (254, N'Patsy T. Mink Central Oahu Regional Park', N'94-801 Kamehameha Hwy', N'Waipahu', N'Honolulu ', N'96797', 21.4159478, -158.0218106, N'HI')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (255, N'Federal Way Community Center', N'876 S 333rd St', N'Federal Way', N'King', N'98003', 47.3055081, -122.3228106, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (256, N'Dumas Bay Centre', N'3200 SW Dash Point Rd', N'Federal Way', N'King', N'98023', 47.3284999, -122.3772079, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (257, N'Alderwood Park', N'1393 SE 325th Pl', N'Federal Way', N'King', N'98023', 47.3096007, -122.3548113, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (258, N'Alderdale Park', N'2700 SE 340th Pl', N'Federal Way', N'King', N'98023', 47.2971639, -122.3679222, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (259, N'Cedar Grove Park', N'2200 S 333rd St', N'Federal Way', N'King', N'98003', 47.3032432, -122.3043372, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (260, N'Coronado Park', N'2500 SW 349th Pl', N'Federal Way', N'King', N'98023', 47.288503, -122.3660075, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (261, N'Dash Point Highlands Park', N'5300 SW 324th Pl', N'Federal Way', N'King', N'98003', 47.3107342, -122.4014201, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (262, N'Adalaide Park', N'30619 16th Ave SW', N'Federal Way', N'King', N'98023', 47.3271801, -122.3569127, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (263, N'English Gardens Park', N'1210 SW 333rd St', N'Federal Way', N'King', N'98003', 47.3027943, -122.3530398, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (264, N'French Lake Dog Park', N'31377 1st Ave S', N'Federal Way', N'King', N'98023', 47.3204685, -122.3400891, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (265, N'Heritage Woods Park', N'28400 23rd Ave S', N'Federal Way', N'King', N'98003', 47.3486507, -122.3038666, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (266, N'Hylebos Blueberry Farm', N'600 S 356th St', N'Federal Way', N'King', N'98003', 47.2838853, -122.327284, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (267, N'West Hylebos Wetlands Park', N'411 S 348th St', N'Federal Way', N'King', N'98003', 47.2876287, -122.3285227, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (268, N'Lake Grove Park', N'833 SW 308th St', N'Federal Way', N'King', N'98003', 47.3254165, -122.3473539, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (269, N'Lake Kilarney Park', N'34902 Weyerhaeuser Way S', N'Federal Way', N'King', N'98003', 47.2877908, -122.2921162, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (270, N'Lakota Park', N'1415 S\W 314th St', N'Federal Way', N'King', N'98023', 47.3206223, -122.3591787, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (271, N'Laurelwood Park', N'2301 S 292nd St.', N'Federal Way', N'King', N'98003', 47.3394161, -122.3044414, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (272, N'Alta Lake State Park', N'1B Otto Road', N'Pateros', N'Okanogan', N'98846', 48.031084, -119.934726, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (273, N'Weyerhaeuser King County Aquatic Center', N'650 SW Campus Drive', N'Federal Way', N'King', N'98023', 47.2952634, -122.3437376, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (274, N'Whitney Bridge Park', N'SE Green Valley Rd and 218th Ave SE Auburn WA 98092', N'Auburn', N'King', N'98092', 47.2817513, -122.0564347, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (275, N'Big Finn Hill Park', N'8106 NE 138th St', N'Kirkland', N'King', N'98034', 47.7244915, -122.2395113, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (276, N'Boulevard Lane Park', N'127th Pl SE and SE 188th Place', N'Kent', N'King', N'98058', 47.4329196, -122.1740409, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (277, N'Bridle Trails State Park', N'5300 116th Ave NE', N'Kirkland', N'King', N'98033', 47.6518205, -122.1797561, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (278, N'Warren G. Magnuson Park', N'7400 Sand Point Way NE', N'Seattle', N'King', N'98115', 47.6664039, -122.2906094, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (279, N'Duthie Hill Park', N'26198 SE Issaquah Fall City Rd', N'Issaquah', N'King', N'98029', 47.5785105, -121.9784505, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (280, N'21st Street Playground', N'405 21st St SE', N'Auburn', N'King', N'98002', 47.2900105, -122.2238516, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (281, N'Auburn Environmental Park', N'413 Western Ave NW', N'Auburn', N'King', N'98001', 47.3107474, -122.2455601, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (282, N'Auburndale Park', N'31802 108th Ave. SE', N'Auburn', N'King', N'98092', 47.317309, -122.197597, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (283, N'Ballard Park', N'1612 37th Way SE', N'Auburn', N'King', N'98002', 47.2754235, -122.2088838, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (284, N'Brannan Park', N'1019 28th St. NE', N'Auburn', N'King', N'98002', 47.3318886, -122.2173103, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (285, N'Cameron Park', N'3727 Lemon Tree Lane', N'Auburn', N'King', N'98092', 47.2765736, -122.1539969, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (286, N'Game Farm Wilderness Park', N'2401 Stuck River Dr. SE', N'Auburn', N'King', N'98002', 47.276002, -122.198837, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (287, N'Cedar Lanes Park', N'1002 25th St SE', N'Auburn', N'King', N'98002', 47.2825863, -122.2202521, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (288, N'Centennial Viewpoint', N'1750 Mountain View Dr SW', N'Auburn', N'King', N'98001', 47.304657, -122.2603838, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (289, N'Les Gove Park', N'910 9th Ave SE', N'Auburn', N'King', N'98002', 47.2983546, -122.218549, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (290, N'Dorothy Bothell Park', N'5701 Lakeland Hills Way', N'Auburn', N'King', N'98092', 47.2547084, -122.2186104, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (291, N'Dykstra Park', N'1487 22nd St. NE', N'Auburn', N'King', N'98002', 47.3263868, -122.2101648, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (292, N'Forest Villa Mini Park', N'1647 Fir St  SE', N'Auburn', N'King', N'98092', 47.2937404, -122.1896451, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (293, N'Frank Fulmer Park', N'1101 5th St. NE', N'Auburn', N'King', N'98002', 47.3136192, -122.2168658, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (294, N'Gaines Park', N'1008 Pike St. NW', N'Auburn', N'King', N'98001', 47.3176436, -122.2510739, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (295, N'GSA Park', N'413 15th St. SW', N'Auburn', N'King', N'98001', 47.295967, -122.2348746, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (296, N'Indian Tom Park', N'1316 6th St NE', N'Auburn', N'King', N'98002', 47.3135382, -122.2115241, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (297, N'Isaac Evans Park', N'29827 Green River Road SE', N'Auburn', N'King', N'98092', 47.3340366, -122.212106, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (298, N'Jornada Park', N'1433 U Ct NW', N'Auburn', N'King', N'98001', 47.3221729, -122.2594719, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (299, N'Lakeland Hills Park', N'1401 Evergreen Way SE', N'Auburn', N'King', N'98001', 47.2596916, -122.2126649, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (300, N'Lea Hill Park', N'124th AVE SE and 316th ST SE', N'Auburn', N'King', N'98092', 47.3185041, -122.1786499, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (301, N'Mill Pond Park', N'4582 Mill Pond Dr. SE', N'Auburn', N'King', N'98002', 47.2677736, -122.2233286, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (302, N'Riverpoint Park', N'1450 32nd St NE', N'Auburn', N'King', N'98002', 47.3356036, -122.2116899, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (303, N'Roegner Park', N'601 Oravetz Road SE', N'Auburn', N'King', N'98092', 47.2690238, -122.221864, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (304, N'Auburn Rotary Park', N'2500 26th St SE', N'Auburn', N'King', N'98002', 47.2867263, -122.1987403, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (305, N'Scootie Brown Park', N'1403 Henry Rd E', N'Auburn', N'King', N'98002', 47.3146972, -122.2122532, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (306, N'Shaughnessy Park', N'3302 21st St. SE', N'Auburn', N'King', N'98092', 47.2904183, -122.1851423, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (307, N'Sunset Park', N'1420 69th St. SE', N'Auburn', N'King', N'98092', 47.2467854, -122.2126553, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (308, N'Terminal Park ', N'1292 C St SE', N'Auburn', N'King', N'98002', 47.2980268, -122.2275047, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (309, N'Rhubarb Park', N'215 Rhubarb Ave SW', N'Pacific', N'King', N'98047', 47.264029, -122.245302, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (310, N'Blueberry Park', N'117 5th Avenue SW', N'Pacific', N'King', N'98047', 47.264029, -122.245302, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (311, N'Otter Park', N'215 Otter Dr SW', N'Pacific', N'King', N'98047', 47.2597444, -122.2567089, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (312, N'Beaver Park', N'550 Beaver Blvd', N'Pacific', N'King', N'98047', 47.2597078, -122.2589941, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (313, N'Volunteer Park', N'126 3rd Ave SE', N'Pacific', N'King', N'98047', 47.2640635, -122.2505981, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (314, N'Algona Park', N'400 Warde St', N'Algona', N'King', N'98001', 47.264029, -122.245302, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (315, N'Interurban Trailhead Park', N'1st Ave and Milwaukee Blvd ', N'Algona', N'King', N'98001', 47.2790899, -122.2504762, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (316, N'Boise Creek Park', N'1300 SE 469th St', N'Enumclaw', N'King', N'98022', 47.1822036, -122.0167969, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (317, N'Bruce Guenther Park', N'911 Battersby Ave.', N'Enumclaw', N'King', N'98022', 47.2069573, -121.9835803, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (318, N'Dwight Garrett Park', N'2222 Porter St', N'Enumclaw', N'King', N'98022', 47.2093436, -121.991792, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (319, N'Ellenson Park', N'2550 Farman St', N'Enumclaw', N'King', N'98022', 47.2060481, -121.9645649, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (320, N'Enumclaw Trailhead', N'Enumclaw Buckley Road and 456th st', N'Enumclaw', N'King', N'98022', 47.1921595, -122.0008391, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (321, N'Farmer''s Park', N'Hiway 164 and Farmers Park', N'Enumclaw', N'King', N'98022', 47.2100952, -122.0383808, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (322, N'Flensted Park', N'750 Farrelly St.', N'Enumclaw', N'King', N'98022', 47.197052, -122.0110168, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (323, N'Martin Johnson Park', N'3050 Harding St', N'Enumclaw', N'King', N'98022', 47.2116956, -122.0010934, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (324, N'Montgomery Park', N'1350 Harding St', N'Enumclaw', N'King', N'98022', 47.2034417, -122.0010568, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (325, N'Veteran''s Memorial Park', N'Monroe Ave and Railroad St', N'Enumclaw', N'King', N'98022', 47.2000388, -121.9921861, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (326, N'Mahler Park', N'24100 SE 436th St', N'Enumclaw', N'King', N'98022', 47.2166624, -122.0197918, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (327, N'Rotary Centennial Park', N'1070 Griffin Ave', N'Enumclaw', N'King', N'98022', 47.2029149, -121.9892079, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (328, N'Rainier Trails Park', N'3450 Hamilton Place', N'Enumclaw', N'King', N'98022', 47.196012, -122.0141026, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (329, N'Nolte State Park', N'36921 Veazie Cumberland Rd SE', N'Enumclaw', N'King', N'98022', 47.2699712, -121.9415244, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (330, N'Flaming Geyser State Park', N'23700 SE Flaming Geyser Road', N'Auburn', N'King', N'98092', 47.288582, -122.0242764, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (331, N'Clark Lake Park', N'12538 SE 240th St', N'Kent', N'King', N'98031', 47.3859401, -122.1764646, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (332, N'Glenn Nelson Park', N'3216 S. 268th St ', N'Kent', N'King', N'98032', 47.3620655, -122.2912833, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (333, N'Hogan Park at Russell Road', N'24400 Russell Road', N'Kent', N'King', N'98032', 47.3839324, -122.2621947, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (334, N'Kent Valley Ice Centre', N'6015 S 240th St', N'Kent', N'King', N'98032', 47.3859838, -122.258295, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (335, N'Kent Memorial Park', N'850 Central Ave N', N'Kent', N'King', N'9802', 47.390109, -122.2310516, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (336, N'Lake Meridian Park', N'14800 SE 272nd St', N'Kent', N'King', N'98030', 47.3637592, -122.1532327, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (337, N'Morrill Meadows Park', N'10600 SE 248th St', N'Kent', N'King', N'98030', 47.3797316, -122.1997679, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (338, N'Service Club Community Park and Ballfields', N'14608 SE 288th St', N'Kent', N'King', N'98042', 47.3452287, -122.1480541, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (339, N'Town Square Plaza', N'2nd Avenue S and W Smith Street', N'Kent', N'King', N'980', 47.3828633, -122.2347973, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (340, N'Van Doren''s Landing Park', N'21901 Russell Road', N'Kent', N'King', N'98042', 47.4053147, -122.2724613, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (341, N'West Fenwick Park', N'3808 Reith Road', N'Kent', N'King', N'98032', 47.3708918, -122.2841743, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (342, N'Sacajawea Park', N'1401 S Dash Point Rd', N'Federal Way', N'King', N'98003', 47.3400917, -122.323654, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (343, N'Marine Hills Pool', N'600 S 302nd St', N'Federal Way', N'King', N'98003', 47.3323962, -122.3273309, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (344, N'Barnes Creek Trail', N'Des Moines Rd. and 16th Ave. S.', N'Des Moines', N'King', N'98198', 47.3961182, -122.3169153, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (345, N'Big Catch Plaza', N'S. 216th Ave. and Marine View Dr. S.', N'Des Moines', N'King', N'98198', 47.4072227, -122.3258406, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (346, N'Redondo Park', N'Redondo Beach Dr. and Redondo Way', N'Des Moines', N'King', N'98198', 47.3486059, -122.3264607, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (347, N'Saltwater State Park', N'25205 8th Pl S', N'Des Moines', N'Kinf', N'98198', 47.3742388, -122.3239654, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (348, N'Artesian Well and Commons', N'415 4th Ave SE', N'Olympia ', N'Thurston', N'98501', 47.044977, -122.8993717, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (349, N'Bigelow Park', N'1220 Bigelow Avenue NE', N'Olympia', N'Thurston', N'98506', 47.0502675, -122.8888228, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (350, N'Bigelow Springs Park', N'930 Bigelow Avenue NE', N'Olympia', N'Thurston', N'98506', 47.050447, -122.8924707, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (351, N'Burri Park', N'2415 Burbank Avenue NW', N'Olympia', N'Thurston', N'98502', 47.0645296, -122.9308002, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (352, N'Decatur Woods Park', N'1015 Decatur Street SW', N'Olympia', N'Thurston', N'98502', 47.038606, -122.9262137, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (353, N'East Bay Waterfront Park', N'313 East Bay Drive NE', N'Olympia', N'Thurston', N'98506', 47.0476953, -122.8931709, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (354, N'Evergreen Park', N'1445 Evergreen Park Drive SW', N'Olympia', N'Thurston', N'98502', 47.0290034, -122.9208803, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (355, N'Friendly Grove Park', N'2316 Friendly Grove Rd NE', N'Olympia', N'Thurston', N'98506', 47.0659136, -122.8720864, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (356, N'Grass Lake Nature Park', N'814 Kaiser Road NW', N'Olympia', N'Thurston', N'98502', 47.0529191, -122.9615479, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (357, N'Harry Fain''s Legion Park', N'1115 20th Avenue SE', N'Olympia', N'Thurston', N'98501', 47.0312243, -122.8862642, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (358, N'Heritage Park Fountain', N'330 5th Avenue SW', N'Olympia', N'Thurston', N'98501', 47.0441604, -122.9051661, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (359, N'Kettle View Park', N'1250 Eagle Bend Drive SE', N'Olympia', N'Thurston', N'98501', 47.0064679, -122.8878621, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (361, N'LBA Park', N'3333 Morse-Merryman Rd SE', N'Olympia', N'Thurston', N'98501', 47.0162828, -122.8596454, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (362, N'Lions Park', N'800 Wilson Street SE', N'Olympia', N'Thurston', N'98501', 47.0427706, -122.8723235, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (363, N'Madison Scenic Park', N'1600 10th Avenue SE', N'Olympia', N'Thurston', N'98501', 47.0413773, -122.8803694, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (364, N'Margaret McKenny Park', N'3111 21st Ave SE', N'Olympia', N'Thurston', N'98501', 47.0294996, -122.8574275, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (365, N'McGrath Woods Park', N'2300 Cain Rd SE', N'Olympia', N'Thurston', N'98501', 47.0280264, -122.8741296, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (366, N'Mission Creek Park', N'1700 San Francisco Ave NE', N'Olympia', N'Thurston', N'98506', 47.0565971, -122.8804159, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (367, N'Percival Landing', N'217 Thurston Ave NW', N'Olympia', N'Thurston', N'98501', 47.0467409, -122.9036893, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (368, N'Priest Point Park', N'2600 East Bay Drive NE', N'Olympia', N'Thurston', N'98506', 47.0716033, -122.9007069, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (369, N'Heritage Park', N'5th Ave SW and Simmons Street', N'Olympia', N'Thurston', N'98501', 47.0457185, -122.9071847, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (370, N'Marathon Park', N'1500 Jefferson St SE', N'Olympia', N'Thurston', N'98501', 47.0377644, -122.9125971, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (371, N'Stevens Field', N'300 24th Avenue SE', N'Olympia', N'Thurston', N'98501', 47.0275554, -122.900519, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (372, N'Sunrise Park', N'505 Bing Street NW', N'Olympia', N'Thurston', N'98502', 47.0496372, -122.9312027, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (373, N'Trillium Park', N'900 Governor Stevens Ave SE', N'Olympia', N'Thurston', N'98501', 47.0221302, -122.8904511, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (374, N'Yauger Park', N'3100 Capital Mall Dr SW', N'Olympia', N'Thurston', N'98502', 47.043608, -122.9452087, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (375, N'Watershed Park', N'2500 Henderson Boulevard SE', N'Olympia', N'Thurston', N'98501', 47.0286062, -122.8887, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (376, N'West Bay Park', N'700 W Bay Dr NW', N'Olympia', N'Thurston', N'98502', 47.0521757, -122.912915, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (377, N'Woodruff Park', N'250 Thomas St NW', N'Olympia', N'Thurston', N'98502', 47.0466605, -122.9212859, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (378, N'Yashiro Japanese Garden', N'1010 Plum Street SE', N'Olympia', N'Thurston', N'98501', 47.0403483, -122.8917461, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (379, N'Centennial Park', N'Franklin St SE and Union Ave SE', N'Olympia', N'Thurston', N'98501', 47.0388381, -122.8989127, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (380, N'Tivoli Fountain', N'Capital Way S and N Diagonal ', N'Olympia', N'Thurston', N'98501', 47.036987, -122.9023082, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (381, N'Sylvester Park', N'615 Washington St SE', N'Olympia', N'Thurston', N'98501', 47.0428708, -122.9010472, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (382, N'East Bay Public Plaza', N'Olympia Ave NE and Jefferson St NE', N'Olympia', N'Thurston', N'98501', 47.0476526, -122.8966863, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (383, N'Port Plaza Park', N'701 Columbia St NW', N'Olympia', N'Thurston', N'98501', 47.0503539, -122.9047109, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (384, N'Garfield Nature Trail Park', N'620 Rogers St NW', N'Olympia', N'Thurston', N'98502', 47.0548784, -122.9178372, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (385, N'Park of the Seven Oars', N'Olumpic Way and Harrison Ave NW', N'Olympia', N'Thurston', N'98502', 47.0456405, -122.9126132, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (386, N'5th and Grant Pocket Park', N'515 Hayes Street SW', N'Tumwater', N'Thurston', N'98512', 47.0213342, -122.9110709, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (387, N'Barclift Park', N'690 Barclift Lane', N'Tumwater', N'Thurston', N'98501', 47.0117762, -122.8936871, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (388, N'Deschutes Valley Park', N'635 T St SE', N'Tumwater', N'Thurston', N'98501', 46.9962712, -122.8993078, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (389, N'Tumwater Historical Park', N'802 Deschutes Way SW', N'Tumwater', N'Thurston', N'98501', 47.0212628, -122.902933, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (390, N'Jim Brown Park', N'535 Bates St SW', N'Tumwater', N'Thurston', N'98512', 47.0159045, -122.9117394, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (391, N'Overlook Point Park', N'1205 Barnes Blvd SW', N'Tumwater', N'Thurston', N'98512', 47.015933, -122.9178519, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (392, N'Palermo Pocket Park', N'303 O Street SE', N'Tumwater', N'Thurston', N'98501', 47.0017247, -122.9052003, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (393, N'Pioneer Park', N'5801 Henderson Blvd SE', N'Tumwater', N'Thurston', N'98501', 46.9969766, -122.8857561, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (394, N'Tumwater Hill Park', N'3115 Ridgeview Court SW', N'Tumwater', N'Thurston', N'98512', 47.014891, -122.9250977, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (395, N'V Street Park', N'415 V Street SW', N'Tumwater', N'Thurston', N'98501', 46.9940671, -122.9132757, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (396, N'Angle Park', N'3199 Sunset Way SE', N'Tumwater', N'Thurston', N'98501', 47.0195444, -122.8957152, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (397, N'Capital Little League Baseball Fields', N'76th Ave SW and Terminal St SW', N'Tumwater', N'Thurston', N'98501', 46.9756151, -122.9130315, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (398, N'Burfoot Park', N'6927 Boston Harbor Rd NE', N'Olympia', N'Thurston', N'98506', 47.132007, -122.9013381, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (399, N'Fry Cove County Park', N'4000 67st Ave NE', N'Olympia', N'Thurston', N'98502', 47.1191306, -122.9710666, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (400, N'Kennydell County Park', N'6745 SW Fairview Rd', N'Olympia', N'Thurston', N'98512', 46.9879211, -122.971812, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (401, N'Thurston County Off-leash Dog Area', N'2420 Hogum Bay Road NE', N'Olympia', N'Thurston', N'98516', 47.0661163, -122.7628714, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (402, N'Gonyea Playfields', N'13422 10th Ave S', N'Tacoma', N'Pierce', N'98444', 47.135293, -122.44864, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (403, N'Chief Leschi Park', N'1755 Brown', N'DuPont', N'Pierce', N'98327', 47.095794, -122.677503, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (404, N'Clock Tower Park', N'1401 Palisade Boulevard', N'DuPont', N'Pierce', N'98327', 47.0945555, -122.6386985, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (405, N'DuPont PowderWorks Park', N'1775 Bobs Hollow Ln', N'DuPont', N'Pierce', N'98327', 47.098844, -122.6514317, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (406, N'Edmond Village Park', N'Griggs St and Hudson St', N'DuPont', N'Pierce', N'98327', 47.10715, -122.642338, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (407, N'Ethel Lumsdon Park', N'601 Louviers Avenue', N'DuPont', N'Pierce', N'98327', 47.0982651, -122.6332962, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (408, N'Garry Oaks Park', N'Garry Oaks Ave and McNeil St', N'DuPont', N'Pierce', N'98237', 47.095961, -122.65327, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (409, N'Iafrati Park', N'120 Barksdale Ave', N'DuPont', N'Pierce', N'98327', 47.094409, -122.627141, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (410, N'Robinson Park', N'205 Barksdale Ave', N'DuPont', N'Pierce', N'98327', 47.09536, -122.628269, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (411, N'Ross Plaza Park', N'1500 Ross Loop', N'DuPont', N'Pierce', N'98327', 47.0915158, -122.643282, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (412, N'Sellers Park', N'600 Barksdale Ave', N'DuPont', N'Pierce', N'98327', 47.0967028, -122.6331627, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (413, N'Billy Frank Jr. Nisqually National Wildlife Refuge', N'100 Brown Farm Rd NE', N'Olympia', N'Thurston', N'98516', 47.0776898, -122.7142211, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (414, N'Woodland Creek Community Park', N'6729 Pacific Ave SE', N'Lacey', N'Thurston', N'98503', 47.0380858, -122.7963871, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (415, N'Lacey Athletic Centre', N'8345 Steilacoom Rd SE', N'Olympia', N'Thurston', N'98513', 47.0445294, -122.7623315, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (416, N'LOTT Hawks Prairie Satelite', N'Hogum Bay Rd NE and 30th Ave NE', N'Lacey', N'Thurston', N'98516', 47.0749764, -122.7685237, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (417, N'Edgewater Park', N'Cashmere Dr NE and Rushmore Ave NE', N'Lacey', N'Thurston', N'98516', 47.0949539, -122.7744883, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (418, N'Tolmie State Park', N'7730 61st Ave NE', N'Olympia', N'Thurston', N'98506', 47.1192033, -122.7794394, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (419, N'Anderson Lake State Park', N'1061 Anderson Lake Road', N'Chimacum', N'Jefferson', N'98325', 48.013994, -122.81573, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (420, N'Battle Ground Lake State Park', N'18002 N.E. 249th St.', N'Battle Ground', N'Clark', N'98604', 45.8049549, -122.4975397, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (421, N'Bay View State Park', N'10901 Bay View-Edison Road', N'Mount Vernon', N'Skagit', N'98273', 48.4879616, -122.4809166, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (422, N'Beacon Rock State Park', N'34841 SR 14', N'Skamania', N'Skamania', N'98648', 45.6350049, -122.0230897, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (423, N'Belfair State Park', N'3151 N.E. SR 300', N'Belfair', N'Mason', N'98528', 47.4300107, -122.8808248, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (424, N'Birch Bay State Park', N'5105 Helweg Road ', N'Blaine', N'Whatcom', N'98230', 48.9034055, -122.7678723, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (425, N'Blake Island State Marine Park', N'Accessible by boat only', N'Port Orchard', N'Kitsap', N'98366', 47.5385582, -122.5021563, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (426, N'Blind Island State Park', N'Accessible by boat only', N'Eastsound', N'San Juan', N'98245', 48.5851911, -122.9390353, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (427, N'Bogachiel State Park', N'185983 U.S. 101', N'Forks', N'Clallam ', N'98331', 47.8941444, -124.3665756, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (428, N'Bottle Beach State Park', N'33 Ocosta 3rd St', N'Aberdeen', N'Grays Harbor', N'98520', 46.892247, -124.041869, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (429, N'Bridgeport State Park', N'235A Half Sun Way', N'Bridgeport', N'Okanogan ', N'98813', 48.0160144, -119.6102588, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (430, N'Brooks Memorial State Park', N'2465 U.S. 97', N'Goldendale', N'Klickitat', N'98620', 45.9480951, -120.6751908, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (431, N'Cama Beach State Park', N'1880 SW Camano Dr', N'Camano Island', N'Island', N'98282', 48.1455727, -122.513916, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (432, N'Camano Island State Park', N'2269 S. Lowell Point Road', N'Camano Island', N'Island', N'98282', 48.1221217, -122.4909755, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (433, N'Camp Wooten State Park', N'2711 Tucannon Road', N'Pomeroy', N'Columbia ', N'99347', 46.2397529, -117.7009053, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (434, N'Cape Disappointment State Park', N'244 Robert Gray Dr.', N'Ilwaco', N'Pacific', N'98624', 46.287339, -124.0699128, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (435, N'Clark Island State Park', N'Accessible by boat only', N'Olga', N'San Juan', N'98279', 48.7020008, -122.7722674, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (436, N'Columbia Hills Historical State Park', N'85 Highway 14', N'Lyle', N'Klickitat', N'98635', 45.6436048, -121.1093921, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (437, N'Columbia Plateau State Park Trail', N'100 S.W. Main St.', N'Washtucna', N'Adams', N'99371', 46.7536993, -118.302688, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (438, N'Conconully State Park', N'119 Broadway St.', N'Conconully', N'Okanogan ', N'98819', 48.556637, -119.753241, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (439, N'Crawford State Park', N'10381 Boundary Rd', N'Metaline Falls', N'Pend Oreille', N'99152', 48.997575, -117.3903515, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (440, N'Curlew Lake State Park', N'62 State Park Road', N'Republic', N'Ferry', N'99166', 48.7205112, -118.6639367, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (441, N'Daroga State Park', N'1 S. Daroga Park Road', N'Orondo', N'Douglas', N'98843', 47.7048462, -120.2058477, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (442, N'Deception Pass State Park', N'41020 SR 20', N'Oak Harbor', N'Island', N'98277', 48.3925524, -122.6655216, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (443, N'Doe Island Marine State Park', N'Accessible by boat only', N'Olga', N'San Juan', N'98279', 48.6329248, -122.787957, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (444, N'Dosewallips State Park', N'306996 Highway 101', N'Brinnon', N'Jefferson', N'98320', 47.6885127, -122.907335, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (445, N'Eagle Island State Park', N'Accessible by boat only', N'Anderson Island', N'Pierce', N'98303', 47.1872423, -122.6968871, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (446, N'Federation Forest State Park', N'49201 WA-410', N'Enumclaw', N'King', N'98022', 47.1545852, -121.7120171, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (447, N'Fields Spring State Park', N'992 Park Road', N'Anatone', N'Asotin', N'99401', 46.0800772, -117.1689184, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (448, N'Fort Casey State Park', N'1280 Engle Road', N'Coupeville', N'Island', N'98239', 48.1597261, -122.6808109, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (449, N'Fort Ebey State Park', N'400 Hill Valley Dr', N'Coupeville', N'Island', N'98239', 48.2183131, -122.7629104, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (450, N'Fort Flagler State Park', N'10541 Flagler Rd', N'Nordland', N'Jefferson', N'98358', 48.0974386, -122.6946922, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (451, N'Fort Columbia State Park', N'Columbia Lane', N'Chinook', N'Pacific', N'98614', 46.2576723, -123.9199967, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (452, N'Fort Simcoe State Park', N'5150 Fort Simcoe Road', N'White Swan', N'Yakima ', N'98952', 46.3439282, -120.8517888, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (453, N'Fort Townsend State Park', N'1370 Old Fort Townsend Road', N'Port Townsend', N'Jefferson', N'98368', 48.0741028, -122.8017744, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (454, N'Fort Worden State Park', N'200 Battery Way', N'Port Townsend', N'Jefferson', N'98368', 48.1316287, -122.8060592, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (455, N'Ginkgo Petrified Forest / Wanapum Recreational Area', N'4511 Huntzinger Road', N'Vantage', N'Kittitas', N'98950', 46.9289465, -120.0218407, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (456, N'Goldendale Observatory State Park', N'1602 Observatory Dr.', N'Goldendale', N'Klickitat', N'98620', 45.8389837, -120.8177017, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (457, N'Grayland Beach State Park', N'925 Cranberry Beach Road', N'Grayland', N'Grays Harbor', N'98547', 46.8421699, -124.1022091, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (458, N'Griffith-Priday Ocean State Park', N'7 Benner Road', N'Ocean Shores', N'Grays Harbor', N'98569', 47.1164447, -124.1776093, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (459, N'Hope Island Marine State Park', N'Accessible by boat only', N'Mason', N'Mason', N'98502', 47.1849021, -122.9313545, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (460, N'Hope Island Marine State Park - Skagit', N'Accessible by boat only', N'La Conner', N'Skagit', N'98257', 48.399141, -122.5701067, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (461, N'Ike Kinswa State Park', N'873 Highway 122', N'Silver Creek', N'Lewis', N'98585', 46.5503574, -122.5461738, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (462, N'Illahee State Park', N'3540 N.E. Sylvan Way', N'Bremerton', N'Kitsap', N'98310', 47.596031, -122.5991214, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (463, N'Iron Horse State Park', N'150 Lake Easton State Park Road', N'Easton', N'King', N'98045', 47.4327908, -121.7515345, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (464, N'James Island Marine State Park', N'Accessible by boat only', N'Blakely Island', N'San Juan', N'98222', 48.511156, -122.773971, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (465, N'Jarrell Cove State Park', N'E. 391 Wingert Road', N'Shelton', N'Mason', N'98584', 47.2841775, -122.8853781, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (466, N'Joemma Beach State Park', N'20001 Bay Road KPS', N'Lakebay', N'Pierce', N'98459', 47.226101, -122.8109175, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (467, N'Jones Island State Park', N'Accessible by boat only', N'Eastsound', N'San Juan', N'98245', 48.614454, -123.046076, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (468, N'Joseph Whidbey State Park', N'Crosby Rd and Swantown Rd', N'Oak Harbor', N'Island', N'98277', 48.3095556, -122.7132375, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (469, N'Kanaskat-Palmer State Park', N'32101 Cumberland-Kanaskat Road', N'Ravensdale', N'King', N'98051', 47.317242, -121.899461, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (470, N'Kinney Point State Park', N'Accessible by boat only', N'Marrowstone', N'Jefferson', N'98358', 48.0087558, -122.6901832, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (471, N'Kitsap Memorial State Park', N'202 N.E. Park St.', N'Poulsbo', N'Kitsap', N'98370', 47.815553, -122.647931, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (472, N'Lake Chelan State Park', N'7544 S. Lakeshore Road', N'Chelan', N'Chelan', N'98816', 47.872665, -120.194106, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (473, N'Lake Easton State Park', N'150 Lake Easton State Park Road', N'Easton', N'Kittitas', N'98925', 47.2471955, -121.2007044, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (474, N'South County Ballfields', N'Military Rd S and S 354th St', N'Auburn', N'King', N'98001', 47.285301, -122.2728699, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (475, N'Lake Sammamish State Park', N'2000 NW Sammamish Rd', N'Issaquah', N'King', N'98027', 47.555169, -122.064183, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (476, N'Lake Sylvia State Park', N'1812 N. Lake Sylvia Road', N'Montesano', N'Grays Harbor', N'98563', 46.9975832, 123.600355, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (477, N'Lake Wenatchee State Park', N'21588 SR 207', N'Leavenworth', N'King', N'98826', 47.8129553, -120.7296233, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (478, N'Larrabee State Park', N'245 Chuckanut Dr.', N'Bellingham', N'Whatcom', N'98229', 48.6551214, -122.4796158, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (479, N'Leadbetter Point State Park', N'Stackpole Road and I St', N'Ocean Park', N'Pacific', N'98640', 46.6089649, -124.0608639, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (480, N'Lewis & Clark State Park', N'4583 Jackson Highway', N'Toledo', N'Lewis', N'98591', 46.5227427, -122.8202974, N'WA')
GO
INSERT [dbo].[Park] ([ParkId], [ParkName], [StreetAddress], [City], [County], [ZipCode], [Latitude], [Longitude], [State]) VALUES (481, N'Lewis & Clark Trail State Park', N'36149 US-12,', N'Dayton', N'Columbia', N'99328', 46.2867255, -118.0720582, N'WA')
GO
SET IDENTITY_INSERT [dbo].[Park] OFF
GO
ALTER TABLE [dbo].[FeaturesAtPark]  WITH CHECK ADD  CONSTRAINT [FK_FeaturesAtPark_Feature] FOREIGN KEY([FID])
REFERENCES [dbo].[Feature] ([FeatureId])
GO
ALTER TABLE [dbo].[FeaturesAtPark] CHECK CONSTRAINT [FK_FeaturesAtPark_Feature]
GO
ALTER TABLE [dbo].[FeaturesAtPark]  WITH CHECK ADD  CONSTRAINT [FK_FeaturesAtPark_Park] FOREIGN KEY([PID])
REFERENCES [dbo].[Park] ([ParkId])
GO
ALTER TABLE [dbo].[FeaturesAtPark] CHECK CONSTRAINT [FK_FeaturesAtPark_Park]
GO
/****** Object:  StoredProcedure [dbo].[FeatureListBox]    Script Date: 6/13/2017 8:51:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[FeatureListBox] 

AS
SELECT *
FROM feature 


GO
/****** Object:  StoredProcedure [dbo].[ParkDetails]    Script Date: 6/13/2017 8:51:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ParkDetails]
@parkId INT = null
AS
SELECT DISTINCT ParkId
,ParkName
,StreetAddress
,City
,County
,ZipCode
,STUFF((
			SELECT ', ' + T.A
			FROM (
				SELECT DISTINCT FeatureName
				FROM Feature f
				INNER JOIN FeaturesAtPark fp ON fp.FId = f.FeatureId
				WHERE Park.ParkId = fp.PID
				AND f.FeatureID IS NOT NULL
				) T(A)
			ORDER BY T.A
			FOR XML PATH(''), TYPE).value('.','VARCHAR(1000)'), 1, 1, '') AS [ParkFeatures]
FROM Park 
WHERE ParkID = @ParkId and @ParkID IS NOT NULL

/*

[ParkDetails] '13'

*/ 
GO
/****** Object:  StoredProcedure [dbo].[ParkList]    Script Date: 6/13/2017 8:51:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ParkList] @ParkId INT = NULL
AS
SELECT DISTINCT ParkId
	,ParkName
	,StreetAddress
	,City
	,ZipCode
	,County
	,Latitude
	,Longitude
	,[State]
FROM Park




/*
[ParkList] ''
*/







GO
/****** Object:  StoredProcedure [dbo].[SearchParks]    Script Date: 6/13/2017 8:51:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SearchParks]

@ParkName NVARCHAR(1000)= NULL,
@City NVARCHAR(500) = NULL,
@FeatureName NVARCHAR(1000) = NULL

AS

SET @ParkName = '%' + ISNULL(@ParkName, '%') + '%'
SET @City = '%' + ISNULL(@City, '%') + '%'
SET @FeatureName = '%' + ISNULL(@FeatureName, '%') + '%'

SELECT DISTINCT 
	 ParkId
	,ParkName
	,StreetAddress
	,City
	,ZipCode
	,County
	,STUFF((
			SELECT ', ' + T.A
			FROM (
				SELECT FeatureName
				FROM Feature f JOIN FeaturesAtPark fp ON fp.FId = f.FeatureId
				WHERE Park.ParkId = fp.PID
				) T(A)
			ORDER BY T.A
			FOR XML PATH('')
			), 1, 1, '') AS [ParkFeatures]
	,Latitude
	,Longitude
	
FROM Park JOIN FeaturesAtPark on Park.ParkId = FeaturesAtPark.PID JOIN Feature on FeaturesAtPark.FID = Feature.FeatureId
WHERE ParkName LIKE @ParkName AND City LIKE @City AND FeatureName LIKE @FeatureName

/*
[searchparks] '', '', ''
*/ 
GO
/****** Object:  StoredProcedure [dbo].[SQLtoJSON]    Script Date: 6/13/2017 8:51:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SQLtoJSON] @ParkId INT = NULL
AS
SELECT DISTINCT parkId
	,parkName
	,streetAddress
	,city
	,zipCode
	,county
	,CONVERT(numeric(16, 8), CAST(latitude AS FLOAT)) as latitude
	,CONVERT(numeric(16, 8), CAST(longitude AS FLOAT)) as longitude
	,State
	,STUFF((
			SELECT ', ' + T.A
			FROM (
				SELECT DISTINCT FeatureName
				FROM Feature f
				INNER JOIN FeaturesAtPark fp ON fp.FId = f.FeatureId
				WHERE P.ParkId = fp.PID
				AND f.FeatureID IS NOT NULL
				) T(A)
			ORDER BY T.A
			FOR XML PATH(''), TYPE).value('.','VARCHAR(1000)'), 1, 1, '') AS [feature]
FROM Park p join FeaturesAtPark f on p.parkId = f.pid join feature fa on fa.featureId = f.fid  
FOR XML path, root;

/*
[ParkList] ''

select * from FeaturesAtPark 
*/

/* This is our transfer into JSON. */

DECLARE @ParkJSON xml;
set @ParkJSON = '<?xml version="1.0" encoding="UTF-8"?>
<root>
  
</root>';



SELECT STUFF((
			SELECT * FROM
			 (SELECT ',
			  {' + 
			   STUFF((SELECT ',"' + coalesce(b.c.value('local-name(.)', 'NVARCHAR(MAX)'), '') + '":"' +
			    b.c.value('text()[1]', 'NVARCHAR(MAX)') + '"'
		FROM x.a.nodes('*') b(c)
		FOR XML path(''),TYPE).value('(./text())[1]', 'NVARCHAR(MAX)')
		, 1, 1, '') + '}'
	FROM @ParkJSON.nodes('/root/*') x(a)
	) JSON(theline)
   FOR XML path(''),TYPE).value('.', 'NVARCHAR(MAX)')
, 1, 1, '')
GO
USE [master]
GO
ALTER DATABASE [thePPF] SET  READ_WRITE 
GO
