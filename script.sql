USE [master]
GO
/****** Object:  Database [TSI]    Script Date: 11/21/2018 6:56:58 PM ******/
CREATE DATABASE [TSI]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TSI', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\TSI.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TSI_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\TSI_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TSI] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TSI].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TSI] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TSI] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TSI] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TSI] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TSI] SET ARITHABORT OFF 
GO
ALTER DATABASE [TSI] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TSI] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TSI] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TSI] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TSI] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TSI] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TSI] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TSI] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TSI] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TSI] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TSI] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TSI] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TSI] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TSI] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TSI] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TSI] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TSI] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TSI] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TSI] SET  MULTI_USER 
GO
ALTER DATABASE [TSI] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TSI] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TSI] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TSI] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TSI] SET DELAYED_DURABILITY = DISABLED 
GO
USE [TSI]
GO
/****** Object:  Table [dbo].[Device]    Script Date: 11/21/2018 6:56:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Device](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[TypeID] [int] NULL,
	[Code] [varchar](50) NULL,
 CONSTRAINT [PK_Device] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employee](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[First_Name] [varchar](50) NULL,
	[Last_Name] [varchar](50) NULL,
	[Contact_No] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[Date_Hired] [date] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employee_Devices]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_Devices](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[DeviceID] [int] NULL,
 CONSTRAINT [PK_Employee_Devices] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Type]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Type](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Employee]    Script Date: 11/21/2018 6:56:59 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Employee] ON [dbo].[Employee]
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Device]  WITH CHECK ADD  CONSTRAINT [FK_Device_Device] FOREIGN KEY([ID])
REFERENCES [dbo].[Device] ([ID])
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [FK_Device_Device]
GO
ALTER TABLE [dbo].[Employee_Devices]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Devices_Device] FOREIGN KEY([DeviceID])
REFERENCES [dbo].[Device] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Employee_Devices] CHECK CONSTRAINT [FK_Employee_Devices_Device]
GO
ALTER TABLE [dbo].[Employee_Devices]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Devices_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Employee_Devices] CHECK CONSTRAINT [FK_Employee_Devices_Employee]
GO
/****** Object:  StoredProcedure [dbo].[spDeleteDevice]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteDevice]
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE Device WHERE ID = @id
END

GO
/****** Object:  StoredProcedure [dbo].[spDeleteEmployee]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteEmployee]
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE Employee WHERE ID = @id
END

GO
/****** Object:  StoredProcedure [dbo].[spDeleteEmployeeDevicesByEmployeeID]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteEmployeeDevicesByEmployeeID]
	-- Add the parameters for the stored procedure here
	@employeeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE Employee_Devices WHERE EmployeeID = @employeeID
END

GO
/****** Object:  StoredProcedure [dbo].[spEditDevice]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spEditDevice]
	-- Add the parameters for the stored procedure here
	@id int,
	@devicename varchar(255),
	@devicecode varchar(255),
	@devicetype int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Device SET Name = @devicename, Code = @devicecode, TypeID = @devicetype WHERE ID = @id
END

GO
/****** Object:  StoredProcedure [dbo].[spEditEmployee]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spEditEmployee]
	-- Add the parameters for the stored procedure here
	@Id int,
	@Code varchar(255),
	@First_Name varchar(255),
	@Last_Name varchar(255),
	@Contact_No varchar(255),
	@Address varchar(255),
	@Date_Hired date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Employee SET Code = @Code, First_Name = @First_Name, Last_Name = @Last_Name, Contact_No = @Contact_No, Address = @Address, Date_Hired = @Date_Hired WHERE ID = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[spFindDevice]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFindDevice] 
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Device.*, Type.Name AS 'DeviceQualification', Type.ID AS 'DeviceID' FROM Device
	INNER JOIN Type
	ON Device.TypeID = Type.ID
	WHERE Device.ID = @id
END

GO
/****** Object:  StoredProcedure [dbo].[spGetDevices]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetDevices]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Device.*, Type.Name AS 'DeviceQualification', Type.ID AS 'DeviceID' FROM Device INNER JOIN Type ON Device.TypeID = Type.ID
END

GO
/****** Object:  StoredProcedure [dbo].[spGetDevicesByEmployeeID]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetDevicesByEmployeeID]
	-- Add the parameters for the stored procedure here
	@employeeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Device.*, Type.Name AS 'TypeName' FROM Employee_Devices 
	INNER JOIN Device 
	ON Employee_Devices.DeviceID = Device.ID 
	INNER JOIN Type
	ON Device.TypeID = Type.ID
	WHERE EmployeeID = @employeeID
END

GO
/****** Object:  StoredProcedure [dbo].[spGetDeviceTypes]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetDeviceTypes] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Type
END

GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeById]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeById]
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Employee WHERE ID = @id
END

GO
/****** Object:  StoredProcedure [dbo].[spGetEmployees]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployees]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM Employee
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertDevice]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertDevice]
	-- Add the parameters for the stored procedure here
	@DeviceCode varchar(255),
	@DeviceName varchar(255),
	@DeviceType int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

    -- Insert statements for procedure here
	INSERT INTO Device (Name, TypeID, Code) VALUES (@DeviceName, @DeviceType, @DeviceCode)
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertEmployee]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertEmployee] 
	-- Add the parameters for the stored procedure here
	@code varchar(255),
	@First_Name varchar(255),
	@Last_Name varchar(255),
	@Contact_No varchar(255),
	@Address varchar(255),
	@Date_Hired date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Employee (Code, First_Name, Last_Name, Contact_No, Address, Date_Hired) 
	VALUES 
	(@code, @First_Name, @Last_Name, @Contact_No, @Address, @Date_Hired)
	SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertEmployeeDevices]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertEmployeeDevices]
	-- Add the parameters for the stored procedure here
	@employee_id int,
	@device_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Employee_Devices (EmployeeID, DeviceID) 
	VALUES
	(@employee_id, @device_id)
END

GO
/****** Object:  StoredProcedure [dbo].[spLogin]    Script Date: 11/21/2018 6:56:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spLogin]
	@username varchar(50),
	@password varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Users WHERE Username = @username AND Password = @password
END

GO
USE [master]
GO
ALTER DATABASE [TSI] SET  READ_WRITE 
GO
