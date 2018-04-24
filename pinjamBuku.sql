USE [Perpustakaan]
GO
/****** Object:  StoredProcedure [dbo].[pinjamBuku]    Script Date: 24/04/2018 20:15:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[pinjamBuku]
	-- Add the parameters for the stored procedure here
	@ISBN nvarchar(50),
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into Perpustakaan.dbo.Peminjaman(fkMember,fkBuku,tanggalPinjam)
	select
		@id, @ISBN, CURRENT_TIMESTAMP

	alter table Perpustakaan.dbo.Eksemplar
	alter column statusEksemplar bit
	select
		1
	from
		Perpustakaan.dbo.Eksemplar
	where
		fkISBN=@ISBN



END
GO
