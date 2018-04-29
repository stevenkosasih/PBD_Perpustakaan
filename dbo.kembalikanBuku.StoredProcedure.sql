USE [Perpustakaan]
GO
/****** Object:  StoredProcedure [dbo].[kembalikanBuku]    Script Date: 29/04/2018 16:31:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[kembalikanBuku]
	-- Add the parameters for the stored procedure here
	@ISBN varchar(50),
	@id int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	update Perpustakaan.dbo.Eksemplar
	set statusEksemplar = 0
	where
		fkISBN=@ISBN

	update Perpustakaan.dbo.Peminjaman
	set tanggalPengembalian = CURRENT_TIMESTAMP
	where
		fkBuku=@ISBN and fkMember=@id

	declare @tempUsers int
	declare @tempBuku varchar(50)

	declare cursorPemesanan cursor
	for
	select fkUsers,fkBuku from Pemesanan

	
	--cek apakah ada yang pesan buku ini
	IF EXISTS(select fkUsers,fkBuku from Pemesanan where fkBuku=@ISBN)
	begin

		open cursorPemesanan

			fetch next from cursorPemesanan
			into
				@tempUsers,@tempBuku

			while(@@FETCH_STATUS=0)
			begin
				if(@tempBuku=@ISBN)
				begin

					--langsung memasukan yang pesan ke dalam peminjaman
					exec pinjamBuku @ISBN,@tempUsers

					delete from Perpustakaan.dbo.Pemesanan
					where fkBuku=@ISBN and fkUsers=@tempUsers
					break
				end
				else
				fetch next from cursorPemesanan
				into
					@tempUsers,@tempBuku
		
			end

		close cursorPemesanan
		deallocate cursorPemesanan

		
		
		
	end


END
