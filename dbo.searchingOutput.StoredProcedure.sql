-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[searchingOutput] 
	-- Add the parameters for the stored procedure here
	@kata nvarchar(70)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	--table untuk kata yang sudah dipisah
	declare @tempKataTable table(
	kata nvarchar(50)
	)

	--table untuk mengolah @tempKataTable mengambil id dari kata
	declare @tempIdKataTable table(
	id int
	)
	--table untuk menyimpan ISBN
	declare @tempISBNTable table(
	ISBN nvarchar(50)
	)
	--table untuk mendapatkan detail buku dari table @tempISBNTable
	declare @detailBuku table(
	ISBN nvarchar(50),
	judul nvarchar(50),
	tahunTerbit int,
	deskripsi text
	)
	--tabel untuk menghitung jumlah kata yang ada pada 1 judul yang terouput untuk
	--menentukan prioritas
	declare @counterTable table(
	ISBN nvarchar(50),
	counterKata int
	)

	--table hasil yang dioutput ketika ada 
	declare @resultTable table(
	ISBN nvarchar(50),
	judul nvarchar(70),
	tahunTerbit int,
	deskripsi text,
	counterKata int
	)
	
	--table untuk output jika tidak ada buku
	declare @outputStringTable table(
	string nvarchar(50)
	)

	--insert string
	insert into @outputStringTable
	select 'buku yang anda cari tidak ditemukan'

	--insert @tempKataTable dengan kata-kata yang sudah dipisah dari @kata yang sudah disort dengan join untuk mendapatkan kata yang ada
	insert into @tempKataTable
	select
		hasilPisah.kata from
				pemisahSpasi(@kata) as hasilPisah
						RIGHT OUTER	JOIN
							Perpustakaan.dbo.Kata
									ON
										hasilPisah.kata=Perpustakaan.dbo.Kata.kata
													
										
	--mengecek apakah ada kata yang sama dengan database , jika tidak ada maka akan mengeluarkan output dari @outputStringtable
	IF NOT EXISTS(select * from @tempKataTable WHERE kata is NULL)
	begin
				--insert id ke @tempResultTable
				insert into @tempIdKataTable
				select
					Perpustakaan.dbo.Kata.id
				from	
					@tempKataTable a
							JOIN
								Perpustakaan.dbo.Kata
										ON
											a.kata=Perpustakaan.dbo.kata.kata
				
				--insert ISBN ke @tempISBNTable
				insert into @tempISBNTable
				select
						fkBuku
				from	
						@tempIdKataTable a
									JOIN
										Perpustakaan.dbo.SearchingRelation
													ON
														a.id=Perpustakaan.dbo.SearchingRelation.fkKata
														
				
				--insert ke tabel @resultTable
				insert into @detailBuku
				select
						a.ISBN,judul,tahunTerbit,deskripsi
				from	
						@tempISBNTable a
									JOIN
										Perpustakaan.dbo.Buku
														ON
															a.ISBN=Perpustakaan.dbo.Buku.ISBN
				
				--insert ke table @counterTable
				insert into @counterTable
				select	
					 ISBN,COUNT(ISBN)
				from	
					@tempISBNTable
				group by 
						ISBN
				
				--mengeluarkan output
				select 
					judul,tahunTerbit,deskripsi
				from
					@counterTable a 
							JOIN
					@detailBuku d
							ON
								a.ISBN=d.ISBN
				order by 
					counterKata asc
	end

	ELSE
	begin	
			select * from @outputStringTable
	end




	
END
GO
