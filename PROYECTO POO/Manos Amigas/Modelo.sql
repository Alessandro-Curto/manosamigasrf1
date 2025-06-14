USE [master]
GO
/****** Object:  Database [ManosAmigas]    Script Date: 27/05/2025 16:36:05 ******/
CREATE DATABASE [ManosAmigas]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ManosAmigas', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ManosAmigas.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ManosAmigas_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ManosAmigas_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ManosAmigas] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ManosAmigas].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ManosAmigas] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ManosAmigas] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ManosAmigas] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ManosAmigas] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ManosAmigas] SET ARITHABORT OFF 
GO
ALTER DATABASE [ManosAmigas] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ManosAmigas] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ManosAmigas] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ManosAmigas] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ManosAmigas] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ManosAmigas] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ManosAmigas] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ManosAmigas] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ManosAmigas] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ManosAmigas] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ManosAmigas] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ManosAmigas] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ManosAmigas] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ManosAmigas] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ManosAmigas] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ManosAmigas] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ManosAmigas] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ManosAmigas] SET RECOVERY FULL 
GO
ALTER DATABASE [ManosAmigas] SET  MULTI_USER 
GO
ALTER DATABASE [ManosAmigas] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ManosAmigas] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ManosAmigas] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ManosAmigas] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ManosAmigas] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ManosAmigas] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ManosAmigas', N'ON'
GO
ALTER DATABASE [ManosAmigas] SET QUERY_STORE = ON
GO
ALTER DATABASE [ManosAmigas] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ManosAmigas]
GO
/****** Object:  Table [dbo].[Voluntarios]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Voluntarios](
	[id_voluntario] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[telefono] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_voluntario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Asignaciones]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Asignaciones](
	[id_asignacion] [int] IDENTITY(1,1) NOT NULL,
	[id_voluntario] [int] NOT NULL,
	[id_evento] [int] NOT NULL,
	[fecha_asignacion] [datetime] NULL,
	[asistio] [bit] NULL,
	[horas_trabajadas] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_asignacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_voluntario_evento] UNIQUE NONCLUSTERED 
(
	[id_voluntario] ASC,
	[id_evento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_horas_voluntarios]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Vista para reporte de horas trabajadas por voluntario
CREATE VIEW [dbo].[vw_horas_voluntarios] AS
SELECT 
    v.id_voluntario,
    v.nombre,
    v.email,
    COUNT(a.id_asignacion) AS eventos_asignados,
    SUM(CASE WHEN a.asistio = 1 THEN 1 ELSE 0 END) AS eventos_asistidos,
    SUM(a.horas_trabajadas) AS total_horas
FROM 
    Voluntarios v
LEFT JOIN 
    Asignaciones a ON v.id_voluntario = a.id_voluntario
GROUP BY 
    v.id_voluntario, v.nombre, v.email;
GO
/****** Object:  Table [dbo].[Eventos]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Eventos](
	[id_evento] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[fecha_inicio] [datetime] NOT NULL,
	[fecha_fin] [datetime] NOT NULL,
	[ubicacion] [nvarchar](100) NOT NULL,
	[cupo_maximo] [int] NOT NULL,
	[id_interes_requerido] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_evento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_cupos_eventos]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Vista para reporte de cupos disponibles por evento
CREATE VIEW [dbo].[vw_cupos_eventos] AS
SELECT 
    e.id_evento,
    e.nombre,
    e.fecha_inicio,
    e.ubicacion,
    e.cupo_maximo,
    e.cupo_maximo - COUNT(a.id_asignacion) AS cupos_disponibles
FROM 
    Eventos e
LEFT JOIN 
    Asignaciones a ON e.id_evento = a.id_evento
GROUP BY 
    e.id_evento, e.nombre, e.fecha_inicio, e.ubicacion, e.cupo_maximo;
GO
/****** Object:  Table [dbo].[VoluntarioIntereses]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VoluntarioIntereses](
	[id_voluntario] [int] NOT NULL,
	[id_interes] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_voluntario] ASC,
	[id_interes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VoluntarioDisponibilidad]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VoluntarioDisponibilidad](
	[id_voluntario] [int] NOT NULL,
	[id_dia] [int] NOT NULL,
	[turno] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_voluntario] ASC,
	[id_dia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_voluntarios_disponibles_evento]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[vw_voluntarios_disponibles_evento] AS
SELECT 
    e.id_evento,
    e.nombre AS evento,
    v.id_voluntario,
    v.nombre AS voluntario,
    v.email,
    v.telefono
FROM 
    Eventos e
CROSS JOIN 
    Voluntarios v
WHERE 
    v.id_voluntario NOT IN (
        SELECT id_voluntario 
        FROM Asignaciones 
        WHERE id_evento = e.id_evento
    )
    AND EXISTS (
        SELECT 1 
        FROM VoluntarioIntereses vi
        WHERE vi.id_voluntario = v.id_voluntario
        AND vi.id_interes = e.id_interes_requerido
    )
    AND EXISTS (
        SELECT 1 
        FROM VoluntarioDisponibilidad vd
        WHERE vd.id_voluntario = v.id_voluntario
        AND vd.id_dia = DATEPART(WEEKDAY, e.fecha_inicio)
    )
    AND e.fecha_inicio > GETDATE();
GO
/****** Object:  Table [dbo].[DiasDisponibilidad]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiasDisponibilidad](
	[id_dia] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_dia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistorialHoras]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistorialHoras](
	[id_historial] [int] IDENTITY(1,1) NOT NULL,
	[id_asignacion] [int] NOT NULL,
	[horas_antes] [int] NOT NULL,
	[horas_despues] [int] NOT NULL,
	[fecha_cambio] [datetime] NULL,
	[usuario_cambio] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_historial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Intereses]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Intereses](
	[id_interes] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_interes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notificaciones]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notificaciones](
	[id_notificacion] [int] IDENTITY(1,1) NOT NULL,
	[id_evento] [int] NOT NULL,
	[asunto] [nvarchar](100) NOT NULL,
	[cuerpo] [nvarchar](max) NOT NULL,
	[fecha_programada] [datetime] NOT NULL,
	[fecha_envio] [datetime] NULL,
	[estado] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_notificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotificacionVoluntarios]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificacionVoluntarios](
	[id_notificacion] [int] NOT NULL,
	[id_voluntario] [int] NOT NULL,
	[enviado] [bit] NULL,
	[fecha_envio] [datetime] NULL,
	[error] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_notificacion] ASC,
	[id_voluntario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[id_rol] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](20) NOT NULL,
	[descripcion] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[id_voluntario] [int] NULL,
	[email] [nvarchar](100) NOT NULL,
	[contrasena_hash] [varbinary](64) NOT NULL,
	[id_rol] [int] NOT NULL,
	[fecha_registro] [datetime] NULL,
	[ultimo_login] [datetime] NULL,
	[activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [idx_asignacion_evento]    Script Date: 27/05/2025 16:36:06 ******/
CREATE NONCLUSTERED INDEX [idx_asignacion_evento] ON [dbo].[Asignaciones]
(
	[id_evento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_asignacion_voluntario]    Script Date: 27/05/2025 16:36:06 ******/
CREATE NONCLUSTERED INDEX [idx_asignacion_voluntario] ON [dbo].[Asignaciones]
(
	[id_voluntario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_evento_fechas]    Script Date: 27/05/2025 16:36:06 ******/
CREATE NONCLUSTERED INDEX [idx_evento_fechas] ON [dbo].[Eventos]
(
	[fecha_inicio] ASC,
	[fecha_fin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_usuario_rol]    Script Date: 27/05/2025 16:36:06 ******/
CREATE NONCLUSTERED INDEX [idx_usuario_rol] ON [dbo].[Usuarios]
(
	[id_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_voluntario_email]    Script Date: 27/05/2025 16:36:06 ******/
CREATE NONCLUSTERED INDEX [idx_voluntario_email] ON [dbo].[Voluntarios]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Asignaciones] ADD  DEFAULT (getdate()) FOR [fecha_asignacion]
GO
ALTER TABLE [dbo].[Asignaciones] ADD  DEFAULT ((0)) FOR [asistio]
GO
ALTER TABLE [dbo].[Asignaciones] ADD  DEFAULT ((0)) FOR [horas_trabajadas]
GO
ALTER TABLE [dbo].[HistorialHoras] ADD  DEFAULT (getdate()) FOR [fecha_cambio]
GO
ALTER TABLE [dbo].[Notificaciones] ADD  DEFAULT ('Pendiente') FOR [estado]
GO
ALTER TABLE [dbo].[NotificacionVoluntarios] ADD  DEFAULT ((0)) FOR [enviado]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT (getdate()) FOR [fecha_registro]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [dbo].[Asignaciones]  WITH CHECK ADD FOREIGN KEY([id_evento])
REFERENCES [dbo].[Eventos] ([id_evento])
GO
ALTER TABLE [dbo].[Asignaciones]  WITH CHECK ADD FOREIGN KEY([id_voluntario])
REFERENCES [dbo].[Voluntarios] ([id_voluntario])
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD FOREIGN KEY([id_interes_requerido])
REFERENCES [dbo].[Intereses] ([id_interes])
GO
ALTER TABLE [dbo].[HistorialHoras]  WITH CHECK ADD FOREIGN KEY([id_asignacion])
REFERENCES [dbo].[Asignaciones] ([id_asignacion])
GO
ALTER TABLE [dbo].[Notificaciones]  WITH CHECK ADD FOREIGN KEY([id_evento])
REFERENCES [dbo].[Eventos] ([id_evento])
GO
ALTER TABLE [dbo].[NotificacionVoluntarios]  WITH CHECK ADD FOREIGN KEY([id_notificacion])
REFERENCES [dbo].[Notificaciones] ([id_notificacion])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NotificacionVoluntarios]  WITH CHECK ADD FOREIGN KEY([id_voluntario])
REFERENCES [dbo].[Voluntarios] ([id_voluntario])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([id_rol])
REFERENCES [dbo].[Roles] ([id_rol])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([id_voluntario])
REFERENCES [dbo].[Voluntarios] ([id_voluntario])
GO
ALTER TABLE [dbo].[VoluntarioDisponibilidad]  WITH CHECK ADD FOREIGN KEY([id_dia])
REFERENCES [dbo].[DiasDisponibilidad] ([id_dia])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VoluntarioDisponibilidad]  WITH CHECK ADD FOREIGN KEY([id_voluntario])
REFERENCES [dbo].[Voluntarios] ([id_voluntario])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VoluntarioIntereses]  WITH CHECK ADD FOREIGN KEY([id_interes])
REFERENCES [dbo].[Intereses] ([id_interes])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VoluntarioIntereses]  WITH CHECK ADD FOREIGN KEY([id_voluntario])
REFERENCES [dbo].[Voluntarios] ([id_voluntario])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Asignaciones]  WITH CHECK ADD CHECK  (([horas_trabajadas]>=(0)))
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD  CONSTRAINT [chk_fechas] CHECK  (([fecha_fin]>[fecha_inicio]))
GO
ALTER TABLE [dbo].[Eventos] CHECK CONSTRAINT [chk_fechas]
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD CHECK  (([cupo_maximo]>(0)))
GO
ALTER TABLE [dbo].[Notificaciones]  WITH CHECK ADD CHECK  (([estado]='Error' OR [estado]='Enviado' OR [estado]='Pendiente'))
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [chk_email_usuario] CHECK  (([email] like '%@%.%'))
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [chk_email_usuario]
GO
ALTER TABLE [dbo].[VoluntarioDisponibilidad]  WITH CHECK ADD CHECK  (([turno]='Completo' OR [turno]='Tarde' OR [turno]='Mañana'))
GO
ALTER TABLE [dbo].[Voluntarios]  WITH CHECK ADD  CONSTRAINT [chk_email] CHECK  (([email] like '%@%.%'))
GO
ALTER TABLE [dbo].[Voluntarios] CHECK CONSTRAINT [chk_email]
GO
ALTER TABLE [dbo].[Voluntarios]  WITH CHECK ADD  CONSTRAINT [chk_telefono] CHECK  (([telefono] like '+[0-9]%' OR [telefono] IS NULL))
GO
ALTER TABLE [dbo].[Voluntarios] CHECK CONSTRAINT [chk_telefono]
GO
/****** Object:  StoredProcedure [dbo].[sp_asignar_voluntario_evento]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- PROCEDIMIENTOS ALMACENADOS ÚTILES
-- =============================================

-- Procedimiento para asignar voluntario a evento con validaciones
CREATE PROCEDURE [dbo].[sp_asignar_voluntario_evento]
    @id_voluntario INT,
    @id_evento INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Verificar si el voluntario existe
        IF NOT EXISTS (SELECT 1 FROM Voluntarios WHERE id_voluntario = @id_voluntario)
            RAISERROR('El voluntario especificado no existe', 16, 1);
            
        -- Verificar si el evento existe
        IF NOT EXISTS (SELECT 1 FROM Eventos WHERE id_evento = @id_evento)
            RAISERROR('El evento especificado no existe', 16, 1);
            
        -- Verificar si ya está asignado
        IF EXISTS (SELECT 1 FROM Asignaciones WHERE id_voluntario = @id_voluntario AND id_evento = @id_evento)
            RAISERROR('El voluntario ya está asignado a este evento', 16, 1);
            
        -- Verificar cupos disponibles (el trigger también lo hace, pero es buena práctica verificarlo aquí)
        DECLARE @cupo_disponible INT;
        SELECT @cupo_disponible = e.cupo_maximo - COUNT(a.id_asignacion)
        FROM Eventos e
        LEFT JOIN Asignaciones a ON e.id_evento = a.id_evento
        WHERE e.id_evento = @id_evento
        GROUP BY e.cupo_maximo;
        
        IF @cupo_disponible <= 0
            RAISERROR('No hay cupos disponibles para este evento', 16, 1);
            
        -- Verificar interés del voluntario
        DECLARE @id_interes_evento INT;
        SELECT @id_interes_evento = id_interes_requerido FROM Eventos WHERE id_evento = @id_evento;
        
        IF @id_interes_evento IS NOT NULL 
            AND NOT EXISTS (
                SELECT 1 
                FROM VoluntarioIntereses 
                WHERE id_voluntario = @id_voluntario 
                AND id_interes = @id_interes_evento)
            RAISERROR('El voluntario no tiene el interés requerido para este evento', 16, 1);
            
        -- Verificar disponibilidad
        DECLARE @dia_evento INT;
        SELECT @dia_evento = DATEPART(WEEKDAY, fecha_inicio) FROM Eventos WHERE id_evento = @id_evento;
        
        IF NOT EXISTS (
            SELECT 1 
            FROM VoluntarioDisponibilidad 
            WHERE id_voluntario = @id_voluntario 
            AND id_dia = @dia_evento)
            RAISERROR('El voluntario no está disponible en la fecha del evento', 16, 1);
            
        -- Asignar voluntario
        INSERT INTO Asignaciones (id_voluntario, id_evento)
        VALUES (@id_voluntario, @id_evento);
        
        COMMIT TRANSACTION;
        SELECT 'Asignación realizada con éxito' AS resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SELECT 
            ERROR_MESSAGE() AS error,
            ERROR_NUMBER() AS error_number,
            ERROR_SEVERITY() AS severity;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_eventos_proximos]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Procedimiento para generar reporte de eventos próximos
CREATE   PROCEDURE [dbo].[sp_eventos_proximos]
    @dias INT = 7
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        e.id_evento,
        e.nombre,
        e.descripcion,
        e.fecha_inicio,
        e.fecha_fin,
        e.ubicacion,
        e.cupo_maximo,
        e.cupo_maximo - COUNT(a.id_asignacion) AS cupos_disponibles,
        i.nombre AS interes_requerido
    FROM 
        Eventos e
    LEFT JOIN 
        Asignaciones a ON e.id_evento = a.id_evento
    LEFT JOIN
        Intereses i ON e.id_interes_requerido = i.id_interes
    WHERE 
        e.fecha_inicio BETWEEN GETDATE() AND DATEADD(DAY, @dias, GETDATE())
    GROUP BY 
        e.id_evento, e.nombre, e.descripcion, e.fecha_inicio, e.fecha_fin, 
        e.ubicacion, e.cupo_maximo, i.nombre
    ORDER BY 
        e.fecha_inicio;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_asistencia]    Script Date: 27/05/2025 16:36:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Procedimiento para registrar asistencia
CREATE PROCEDURE [dbo].[sp_registrar_asistencia]
    @id_asignacion INT,
    @asistio BIT,
    @horas_trabajadas INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Verificar si la asignación existe
        IF NOT EXISTS (SELECT 1 FROM Asignaciones WHERE id_asignacion = @id_asignacion)
            RAISERROR('La asignación especificada no existe', 16, 1);
            
        -- Verificar horas trabajadas
        IF @asistio = 1 AND @horas_trabajadas <= 0
            RAISERROR('Debe especificar horas trabajadas si el voluntario asistió', 16, 1);
            
        -- Actualizar asistencia
        UPDATE Asignaciones
        SET 
            asistio = @asistio,
            horas_trabajadas = CASE WHEN @asistio = 1 THEN @horas_trabajadas ELSE 0 END
        WHERE id_asignacion = @id_asignacion;
        
        COMMIT TRANSACTION;
        SELECT 'Asistencia registrada con éxito' AS resultado;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SELECT 
            ERROR_MESSAGE() AS error,
            ERROR_NUMBER() AS error_number,
            ERROR_SEVERITY() AS severity;
    END CATCH
END;
GO
USE [master]
GO
ALTER DATABASE [ManosAmigas] SET  READ_WRITE 
GO
USE ManosAmigas;
GO

-- Insertar días de disponibilidad
INSERT INTO DiasDisponibilidad (id_dia, nombre) VALUES (1, 'Lunes');
INSERT INTO DiasDisponibilidad (id_dia, nombre) VALUES (2, 'Martes');
INSERT INTO DiasDisponibilidad (id_dia, nombre) VALUES (3, 'Miércoles');
INSERT INTO DiasDisponibilidad (id_dia, nombre) VALUES (4, 'Jueves');
INSERT INTO DiasDisponibilidad (id_dia, nombre) VALUES (5, 'Viernes');
INSERT INTO DiasDisponibilidad (id_dia, nombre) VALUES (6, 'Sábado');
INSERT INTO DiasDisponibilidad (id_dia, nombre) VALUES (7, 'Domingo');

-- Insertar intereses
INSERT INTO Intereses (id_interes, nombre) VALUES (1, 'Salud');
INSERT INTO Intereses (id_interes, nombre) VALUES (2, 'Educación');
INSERT INTO Intereses (id_interes, nombre) VALUES (3, 'Medio Ambiente');
INSERT INTO Intereses (id_interes, nombre) VALUES (4, 'Comedores');
INSERT INTO Intereses (id_interes, nombre) VALUES (5, 'Recolección');

-- Insertar voluntarios
INSERT INTO Voluntarios (nombre, email, telefono) VALUES ('Purificación Rivero', 'nicolas49@yahoo.com', '+34 609 36 63 73');
INSERT INTO Voluntarios (nombre, email, telefono) VALUES ('Carolina Moya', 'noelia77@hotmail.com', '+34 683 39 63 90');
INSERT INTO Voluntarios (nombre, email, telefono) VALUES ('Rodolfo Iglesias', 'teresa10@gmail.com', '+34 652 98 10 20');
INSERT INTO Voluntarios (nombre, email, telefono) VALUES ('Cristina Lozano', 'elena51@gmail.com', '+34 692 15 23 17');
INSERT INTO Voluntarios (nombre, email, telefono) VALUES ('Gaspar Mora', 'pablojimenez@jose.es', '+34 673 54 85 10');
INSERT INTO Voluntarios (nombre, email, telefono) VALUES ('Valentín Ortega', 'angel83@yahoo.com', '+34 643 92 88 36');
INSERT INTO Voluntarios (nombre, email, telefono) VALUES ('Mariana Sánchez', 'francomoreno@yahoo.com', '+34 622 75 22 64');
INSERT INTO Voluntarios (nombre, email, telefono) VALUES ('Jesús Martín', 'laramartin@gmail.com', '+34 687 35 15 91');
INSERT INTO Voluntarios (nombre, email, telefono) VALUES ('Ana Delgado', 'raquel17@gmail.com', '+34 634 68 97 70');
INSERT INTO Voluntarios (nombre, email, telefono) VALUES ('Benjamín Peña', 'isabel09@lopez.com', '+34 600 14 21 81');

-- Insertar disponibilidad de voluntarios
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (1, 1, 'Mañana');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (1, 6, 'Tarde');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (2, 2, 'Mañana');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (2, 1, 'Tarde');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (3, 6, 'Mañana');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (3, 2, 'Tarde');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (4, 3, 'Completo');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (4, 5, 'Tarde');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (5, 1, 'Completo');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (5, 7, 'Mañana');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (6, 2, 'Tarde');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (6, 3, 'Mañana');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (7, 4, 'Tarde');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (7, 1, 'Mañana');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (8, 2, 'Mañana');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (8, 5, 'Tarde');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (9, 3, 'Mañana');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (9, 7, 'Tarde');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (10, 2, 'Completo');
INSERT INTO VoluntarioDisponibilidad (id_voluntario, id_dia, turno) VALUES (10, 5, 'Mañana');

-- Insertar intereses de voluntarios
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (1, 1);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (1, 5);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (2, 3);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (2, 4);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (3, 4);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (3, 5);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (4, 2);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (4, 5);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (5, 1);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (5, 3);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (6, 2);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (6, 3);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (7, 2);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (7, 4);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (8, 1);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (8, 4);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (9, 1);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (9, 2);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (10, 1);
INSERT INTO VoluntarioIntereses (id_voluntario, id_interes) VALUES (10, 5);

-- Insertar eventos
INSERT INTO Eventos (nombre, descripcion, fecha_inicio, fecha_fin, ubicacion, cupo_maximo, id_interes_requerido)
VALUES 
('Evento 1', 'Apoyo en recolección de alimentos', '2025-06-15 10:00:00', '2025-06-15 14:00:00', 'Madrid', 5, 5),
('Evento 2', 'Taller de salud preventiva', '2025-06-16 09:00:00', '2025-06-16 13:00:00', 'Sevilla', 4, 1),
('Evento 3', 'Campaña educativa ambiental', '2025-06-17 08:00:00', '2025-06-17 12:00:00', 'Valencia', 6, 3),
('Evento 4', 'Jornada en comedor social', '2025-06-20 12:00:00', '2025-06-20 16:00:00', 'Barcelona', 5, 4),
('Evento 5', 'Recolección de ropa y útiles', '2025-06-22 09:00:00', '2025-06-22 13:00:00', 'Bilbao', 5, 5);

-- Insertar asignaciones
INSERT INTO Asignaciones (id_voluntario, id_evento, asistio, horas_trabajadas) VALUES (1, 1, 1, 3);
INSERT INTO Asignaciones (id_voluntario, id_evento, asistio, horas_trabajadas) VALUES (2, 1, 0, 0);
INSERT INTO Asignaciones (id_voluntario, id_evento, asistio, horas_trabajadas) VALUES (3, 2, 1, 4);
INSERT INTO Asignaciones (id_voluntario, id_evento, asistio, horas_trabajadas) VALUES (4, 2, 1, 2);
INSERT INTO Asignaciones (id_voluntario, id_evento, asistio, horas_trabajadas) VALUES (5, 3, 1, 4);
INSERT INTO Asignaciones (id_voluntario, id_evento, asistio, horas_trabajadas) VALUES (6, 3, 0, 0);
INSERT INTO Asignaciones (id_voluntario, id_evento, asistio, horas_trabajadas) VALUES (7, 4, 1, 3);
INSERT INTO Asignaciones (id_voluntario, id_evento, asistio, horas_trabajadas) VALUES (8, 4, 1, 4);
INSERT INTO Asignaciones (id_voluntario, id_evento, asistio, horas_trabajadas) VALUES (9, 5, 1, 2);
INSERT INTO Asignaciones (id_voluntario, id_evento, asistio, horas_trabajadas) VALUES (10, 5, 1, 3);

SELECT*FROM DBO.Asignaciones
SELECT*FROM DBO.DiasDisponibilidad

ALTER TABLE Asignaciones
ADD estado_asignacion NVARCHAR(20) NOT NULL
CONSTRAINT DF_Asignaciones_Estado DEFAULT 'Confirmado'

SELECT*FROM DBO.Voluntarios
USE ManosAmigas
GO
SELECT*FROM DBO.VoluntarioIntereses
SELECT name FROM sys.tables WHERE name LIKE '%Disponibilidad%'
SELECT * FROM DiasDisponibilidad
INSERT INTO DiasDisponibilidad (nombre) VALUES
('Lunes'), ('Martes'), ('Miércoles'), ('Jueves'),
('Viernes'), ('Sábado'), ('Domingo');
SELECT name FROM sys.tables WHERE name = 'DiasDisponibilidad';
SELECT * FROM DiasDisponibilidad;
SELECT*FROM VoluntarioDisponibilidad
USE ManosAmigas;
SELECT * FROM Intereses;
USE ManosAmigas;

INSERT INTO Intereses (nombre) VALUES ('Salud');
INSERT INTO Intereses (nombre) VALUES ('Educación');
INSERT INTO Intereses (nombre) VALUES ('Medio Ambiente');
INSERT INTO Intereses (nombre) VALUES ('Comedores');
INSERT INTO Intereses (nombre) VALUES ('Recolección');
USE ManosAmigas;

-- =================================================================
-- SCRIPT PARA REEMPLAZAR LOS INTERESES DE PRUEBA
-- =================================================================

BEGIN TRANSACTION;

-- Paso 1: Eliminar las asociaciones existentes en la tabla intermedia.
-- Esto es crucial para evitar errores de clave foránea al borrar los intereses.
DELETE FROM VoluntarioIntereses;
PRINT 'Asociaciones de intereses eliminadas.';

-- Paso 2: Eliminar todos los registros actuales de la tabla de intereses.
DELETE FROM Intereses;
PRINT 'Registros de intereses antiguos eliminados.';

-- Paso 3 (Recomendado): Reiniciar el contador del ID para que los nuevos intereses empiecen en 1.
DBCC CHECKIDENT ('Intereses', RESEED, 0);
PRINT 'Contador de ID de Intereses reiniciado.';

-- Paso 4: Insertar los nuevos intereses, más acordes al proyecto de la ONG.
INSERT INTO Intereses (nombre) VALUES ('Apoyo en Comedores Sociales');
INSERT INTO Intereses (nombre) VALUES ('Campañas de Recolección');
INSERT INTO Intereses (nombre) VALUES ('Logística y Organización de Eventos');
INSERT INTO Intereses (nombre) VALUES ('Apoyo Educativo');
INSERT INTO Intereses (nombre) VALUES ('Acompañamiento a Personas');
INSERT INTO Intereses (nombre) VALUES ('Comunicación y Difusión');
PRINT 'Nuevos intereses insertados correctamente.';

COMMIT TRANSACTION;

-- Paso 5: Verificar que los nuevos datos se insertaron correctamente.
SELECT * FROM Intereses;
SELECT*FROM Voluntarios