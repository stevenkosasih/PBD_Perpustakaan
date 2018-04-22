USE [Perpustakaan]
GO
/****** Object:  StoredProcedure [dbo].[insertBuku]    Script Date: 22/04/2018 17:07:42 ******/
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
insert into Perpustakaan.dbo.Eksemplar(fkISBN, statusEksemplar)
	select
		@ISBN, 0

--check ISBN kosong atau tidak
if not EXISTS(select judul from Perpustakaan.dbo.Buku where Perpustakaan.dbo.Buku.ISBN =@ISBN)
begin
	--insert buku yang tidak ada/new ke dalam database perpustakaan.dbo.buku
	insert into Perpustakaan.dbo.Buku
	select
		@ISBN, @judul, @tahunTerbit, @deskripsi, @tempPengarangId, @tempPenerbitId
	
	--insert judul yang sudah dipecah ke dalam table sementara tempkataTable
	insert into @tempKataTable
	select distinct
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
