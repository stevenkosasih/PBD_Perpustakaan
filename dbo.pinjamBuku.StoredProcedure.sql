USE [Perpustakaan]
GO
/****** Object:  StoredProcedure [dbo].[pinjamBuku]    Script Date: 29/04/2018 18:14:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[pinjamBuku]
	-- Add the parameters for the stored procedure here
	@ISBN nvarchar(50),
	@id nvarchar(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into Perpustakaan.dbo.Peminjaman(fkMember,fkBuku,tanggalPinjam)
	select
		@id, @ISBN, CURRENT_TIMESTAMP

	update Perpustakaan.dbo.Eksemplar
	set statusEksemplar = 1
	where
		fkISBN=@ISBN

END
