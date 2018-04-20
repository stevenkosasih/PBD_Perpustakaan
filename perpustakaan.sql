USE [master]
GO
/****** Object:  Database [Perpustakaan]    Script Date: 4/20/2018 10:37:13 PM ******/
CREATE DATABASE [Perpustakaan]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Perpustakaan', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Perpustakaan.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Perpustakaan_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Perpustakaan_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Perpustakaan] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Perpustakaan].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Perpustakaan] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Perpustakaan] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Perpustakaan] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Perpustakaan] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Perpustakaan] SET ARITHABORT OFF 
GO
ALTER DATABASE [Perpustakaan] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Perpustakaan] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Perpustakaan] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Perpustakaan] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Perpustakaan] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Perpustakaan] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Perpustakaan] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Perpustakaan] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Perpustakaan] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Perpustakaan] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Perpustakaan] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Perpustakaan] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Perpustakaan] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Perpustakaan] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Perpustakaan] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Perpustakaan] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Perpustakaan] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Perpustakaan] SET RECOVERY FULL 
GO
ALTER DATABASE [Perpustakaan] SET  MULTI_USER 
GO
ALTER DATABASE [Perpustakaan] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Perpustakaan] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Perpustakaan] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Perpustakaan] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Perpustakaan] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Perpustakaan', N'ON'
GO
ALTER DATABASE [Perpustakaan] SET QUERY_STORE = OFF
GO
USE [Perpustakaan]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Perpustakaan]
GO
/****** Object:  UserDefinedFunction [dbo].[pemisahKoma]    Script Date: 4/20/2018 10:37:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[pemisahKoma]
(
	@kata varchar(50)
)
RETURNS @result table(

kata varchar(50)
)
BEGIN
	declare @start int=1, @koma varchar(1)=',',@end int=1,@length int, @tempKata varchar(50)

	select @length=LEN(@kata)
	
	while(@end<=@length)
	begin
		 if(CHARINDEX(@koma,@kata,@start)!=@end )
		 begin
			
				set @tempKata=CONCAT(@tempKata,SUBSTRING(@kata,@start,1))
			
				set @end=@end+1
			
			set @start=@start+1
		 end
		
		else
		begin
		
				insert into @result
				select
					@tempKata
			set @tempKata=''
				set @start=@start+1
				set @end=@end+1
		end
		
	end
	insert into @result
	select @tempKata


RETURN
END

GO
/****** Object:  UserDefinedFunction [dbo].[pemisahSpasi]    Script Date: 4/20/2018 10:37:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[pemisahSpasi]
(
	@kata varchar(50)
)
RETURNS @result table(

kata varchar(50)
)
BEGIN
	declare @start int=1, @space varchar(1)=' ',@end int=1,@length int, @tempKata varchar(50)

	select @length=LEN(@kata)
	
	while(@end<=@length)
	begin
		 if(CHARINDEX(@space,@kata,@start)!=@end )
		 begin
			
				set @tempKata=CONCAT(@tempKata,SUBSTRING(@kata,@start,1))
			
				set @end=@end+1
			
			set @start=@start+1
		 end
		
		else
		begin
		
				insert into @result
				select
					@tempKata
			set @tempKata=''
				set @start=@start+1
				set @end=@end+1
		end
		
	end
	insert into @result
	select @tempKata


RETURN
END

GO
/****** Object:  Table [dbo].[Genre]    Script Date: 4/20/2018 10:37:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[genre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Genre] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GenreRelation]    Script Date: 4/20/2018 10:37:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenreRelation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkBuku] [nvarchar](50) NOT NULL,
	[fkGenre] [int] NOT NULL,
 CONSTRAINT [PK_GenreRelation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Buku]    Script Date: 4/20/2018 10:37:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Buku](
	[ISBN] [nvarchar](50) NOT NULL,
	[Judul] [nvarchar](70) NOT NULL,
	[TahunTerbit] [int] NOT NULL,
	[deskripsi] [text] NULL,
	[fkPengarang] [int] NOT NULL,
	[fkPenerbit] [int] NOT NULL,
 CONSTRAINT [PK_Buku] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Genre_Buku_View]    Script Date: 4/20/2018 10:37:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Genre_Buku_View]
AS
SELECT dbo.Genre.genre, dbo.Buku.Judul
FROM     dbo.Genre INNER JOIN
                  dbo.GenreRelation ON dbo.Genre.id = dbo.GenreRelation.fkGenre INNER JOIN
                  dbo.Buku ON dbo.GenreRelation.fkBuku = dbo.Buku.ISBN
GO
/****** Object:  Table [dbo].[Eksemplar]    Script Date: 4/20/2018 10:37:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Eksemplar](
	[Id] [int] NOT NULL,
	[fkISBN] [nvarchar](50) NOT NULL,
	[statusEksemplar] [bit] NOT NULL,
 CONSTRAINT [PK_Eksemplar] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Buku_Eksemplar_View]    Script Date: 4/20/2018 10:37:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Buku_Eksemplar_View]
AS
SELECT dbo.Eksemplar.statusEksemplar, dbo.Buku.Judul
FROM     dbo.Eksemplar INNER JOIN
                  dbo.Buku ON dbo.Eksemplar.fkISBN = dbo.Buku.ISBN
GO
/****** Object:  Table [dbo].[Denda]    Script Date: 4/20/2018 10:37:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Denda](
	[Id] [int] NOT NULL,
	[Harga] [int] NOT NULL,
	[TanggalMulai] [date] NULL,
	[TanggalBerakhir] [date] NULL,
	[PerBerapaHari] [int] NOT NULL,
 CONSTRAINT [PK_Denda] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kata]    Script Date: 4/20/2018 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kata](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[kata] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Kata] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pemesanan]    Script Date: 4/20/2018 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pemesanan](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkUsers] [int] NOT NULL,
	[fkBuku] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Pemesanan] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peminjaman]    Script Date: 4/20/2018 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peminjaman](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkMember] [int] NOT NULL,
	[fkBuku] [nvarchar](50) NOT NULL,
	[tanggalPinjam] [date] NOT NULL,
	[tanggalPengembalian] [date] NULL,
 CONSTRAINT [PK_Peminjaman] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Penerbit]    Script Date: 4/20/2018 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Penerbit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nama] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Penerbit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pengarang]    Script Date: 4/20/2018 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pengarang](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nama] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Pengarang] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SearchingRelation]    Script Date: 4/20/2018 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchingRelation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkKata] [int] NOT NULL,
	[fkBuku] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SearchingRelation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/20/2018 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nama] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Eksemplar] ADD  CONSTRAINT [DF_Eksemplar_statusEksemplar]  DEFAULT ((0)) FOR [statusEksemplar]
GO
ALTER TABLE [dbo].[Eksemplar]  WITH CHECK ADD  CONSTRAINT [Fk_eksemplar_buku] FOREIGN KEY([fkISBN])
REFERENCES [dbo].[Buku] ([ISBN])
GO
ALTER TABLE [dbo].[Eksemplar] CHECK CONSTRAINT [Fk_eksemplar_buku]
GO
ALTER TABLE [dbo].[GenreRelation]  WITH CHECK ADD  CONSTRAINT [FK_GenreRelation_Buku] FOREIGN KEY([fkBuku])
REFERENCES [dbo].[Buku] ([ISBN])
GO
ALTER TABLE [dbo].[GenreRelation] CHECK CONSTRAINT [FK_GenreRelation_Buku]
GO
ALTER TABLE [dbo].[GenreRelation]  WITH CHECK ADD  CONSTRAINT [FK_GenreRelation_Genre] FOREIGN KEY([fkGenre])
REFERENCES [dbo].[Genre] ([id])
GO
ALTER TABLE [dbo].[GenreRelation] CHECK CONSTRAINT [FK_GenreRelation_Genre]
GO
ALTER TABLE [dbo].[Pemesanan]  WITH CHECK ADD  CONSTRAINT [FK_Pemesanan_Buku] FOREIGN KEY([fkBuku])
REFERENCES [dbo].[Buku] ([ISBN])
GO
ALTER TABLE [dbo].[Pemesanan] CHECK CONSTRAINT [FK_Pemesanan_Buku]
GO
ALTER TABLE [dbo].[Pemesanan]  WITH CHECK ADD  CONSTRAINT [FK_Pemesanan_Users] FOREIGN KEY([fkUsers])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Pemesanan] CHECK CONSTRAINT [FK_Pemesanan_Users]
GO
ALTER TABLE [dbo].[Peminjaman]  WITH CHECK ADD  CONSTRAINT [FK_Peminjaman_Buku] FOREIGN KEY([fkBuku])
REFERENCES [dbo].[Buku] ([ISBN])
GO
ALTER TABLE [dbo].[Peminjaman] CHECK CONSTRAINT [FK_Peminjaman_Buku]
GO
ALTER TABLE [dbo].[Peminjaman]  WITH CHECK ADD  CONSTRAINT [FK_Peminjaman_Users] FOREIGN KEY([fkMember])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Peminjaman] CHECK CONSTRAINT [FK_Peminjaman_Users]
GO
ALTER TABLE [dbo].[SearchingRelation]  WITH CHECK ADD  CONSTRAINT [FK_SearchingRelation_Buku] FOREIGN KEY([fkBuku])
REFERENCES [dbo].[Buku] ([ISBN])
GO
ALTER TABLE [dbo].[SearchingRelation] CHECK CONSTRAINT [FK_SearchingRelation_Buku]
GO
ALTER TABLE [dbo].[SearchingRelation]  WITH CHECK ADD  CONSTRAINT [FK_SearchingRelation_Kata] FOREIGN KEY([fkKata])
REFERENCES [dbo].[Kata] ([id])
GO
ALTER TABLE [dbo].[SearchingRelation] CHECK CONSTRAINT [FK_SearchingRelation_Kata]
GO
/****** Object:  StoredProcedure [dbo].[findByGenre]    Script Date: 4/20/2018 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[findByGenre]
	-- Add the parameters for the stored procedure here
	@genre nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
			Judul
				from
					Genre_Buku_View
								where
									genre=@genre
								
END
GO
/****** Object:  StoredProcedure [dbo].[insertBuku]    Script Date: 4/20/2018 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[insertBuku]
@ISBN nvarchar(50),
@judul nvarchar(70),
@tahunTerbit int,
@deskripsi text,
@pengarang nvarchar(50),
@penerbit nvarchar(50),
@genre nvarchar(100)

as

declare @tempISBN nvarchar(50),
@tempPengarangId int,
@tempPenerbitId int,
@stringOutput nvarchar(50),
@tempGenreId nvarchar(50)

declare @tempKataTable table(
kata nvarchar(50)
)

declare @tempGenreTable table(
genre nvarchar(50)
)

--check pengarang
if EXISTS (select id from Pengarang where @Pengarang=nama)
begin
	select @tempPengarangId=id
	from	
		Pengarang
	where @Pengarang=nama
	
end
else
begin	
		
		insert into Pengarang(nama)
		select 
			@pengarang
		
		select @tempPengarangId=id
		from
			Pengarang
		where 
			@pengarang=nama
end

--check penerbit
if EXISTS (select id from Perpustakaan.dbo.Penerbit where @Penerbit=nama)
begin
	select @tempPenerbitId=id
	from	
		Perpustakaan.dbo.Penerbit
	where @Penerbit=nama
	
end
else
begin	
		
		insert into Perpustakaan.dbo.Penerbit(nama)
		select 
			@penerbit
		
		select @tempPenerbitId=id
		from
			Perpustakaan.dbo.Penerbit
		where 
			@penerbit=nama
end

--declare variable buat cursor kata
declare @cursorKataVariable nvarchar(50),
		@idTableKataTemp int

--insert ke eksemplar
insert into Perpustakaan.dbo.Eksemplar(fkISBN)
	select
		@ISBN

--check ISBN kosong atau tidak
if not EXISTS(select judul from Perpustakaan.dbo.Buku where Perpustakaan.dbo.Buku.ISBN =@ISBN)
begin
	--insert buku yang tidak ada/new ke dalam database perpustakaan.dbo.buku
	insert into Perpustakaan.dbo.Buku
	select
		@ISBN, @judul, @tahunTerbit, @deskripsi, @tempPengarangId, @tempPenerbitId
	
	--insert judul yang sudah dipecah ke dalam table sementara tempkataTable
	insert into @tempKataTable
	select
		* 
		from
			Perpustakaan.dbo.pemisahSpasi(@judul)
	
	

	--variable buat cursorGenre
	declare @cursorGenreVariable nvarchar(50),
			@idTableGenreTemp int

	--insert genre yang sudah dipecah ke dalam table sementara tempGenreTable
	insert into @tempGenreTable
	select
		* from
			Perpustakaan.dbo.pemisahKoma(@genre)
	
	--cursor buat loop genre dari table tempGenreTable untuk indexing
	declare cursorGenre cursor
	for
		select	
				genre
					from
						@tempGenreTable
	--open cursorGenre
	open cursorGenre

	fetch next from cursorGenre
	into
		@cursorGenreVariable

	while(@@FETCH_STATUS=0)
	begin

		--jika genre tidak ada maka akan dimasukkan ke dalam table genre
		if NOT EXISTS(select id from Perpustakaan.dbo.Genre where genre=@cursorGenreVariable)
		begin
			insert into Perpustakaan.dbo.Genre(genre)
			select
				@cursorGenreVariable
		end

		--mengambil id cursorGenreVariable
		select 
			@tempGenreId=id 
						from 
							Perpustakaan.dbo.Genre 
												where 
													genre=@cursorGenreVariable

		--memasukkan ISBN dan idGenre ke genreRelation
		insert into Perpustakaan.dbo.GenreRelation(fkBuku,fkGenre)
		select
			@ISBN,@tempGenreId
					

		--fetch next from cursorGenre
		fetch next from cursorGenre
		into
			@cursorGenreVariable
					

		
	end
	

	
	--cursor untuk mengecek apakah sebuah kata sudah ada di dalam table dbo.Kata
	declare cursorKata cursor
	for
		select
			kata
				from
					@tempKataTable
--open cursorKata
	open cursorKata
	fetch next from cursorKata
	into 
		@cursorKataVariable
	
	while(@@FETCH_STATUS=0)
	begin
			--check apakah kata tidak ada di table dbo.Kata
			if NOT EXISTS (select id from Perpustakaan.dbo.Kata where @cursorKataVariable=kata)
			begin
					--memasukkan kata ke dalam tabel Kata
					insert into Perpustakaan.dbo.Kata(kata)
					select
						@cursorKataVariable
					
			end
			
			--mengambil id dari sebuah kata
					select
						@idTableKataTemp=id
					from
						Perpustakaan.dbo.Kata
					where
						kata=@cursorKataVariable

			--insert relation kata terhadap iSBN buku ke tabel Searching relation
					insert into Perpustakaan.dbo.SearchingRelation(fkKata,fkBuku)
					select
						@idTableKataTemp,@ISBN

					fetch next from cursorKata
					into
						@cursorKataVariable
		
		set @stringOutput='Buku berhasil ditambahkan'
		select @stringOutput
					
	end
	close cursorGenre
	deallocate cursorGenre
	close cursorKata
	deallocate cursorKata

end
	

GO
/****** Object:  StoredProcedure [dbo].[insertUser]    Script Date: 4/20/2018 10:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertUser]
	-- Add the parameters for the stored procedure here
	@nama nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    insert into Users(nama)
	select
		@nama

	select CONCAT('User dengan nama ',@nama, ' berhasil ditambahkan')
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 berarti belum dipinjam/tersedia , 1 vice versa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Eksemplar', @level2type=N'COLUMN',@level2name=N'statusEksemplar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Eksemplar"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Buku"
            Begin Extent = 
               Top = 7
               Left = 297
               Bottom = 170
               Right = 491
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Buku_Eksemplar_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Buku_Eksemplar_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[29] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Genre"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 126
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GenreRelation"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 148
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Buku"
            Begin Extent = 
               Top = 7
               Left = 532
               Bottom = 170
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Genre_Buku_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Genre_Buku_View'
GO
USE [master]
GO
ALTER DATABASE [Perpustakaan] SET  READ_WRITE 
GO
