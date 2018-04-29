USE [Perpustakaan]
GO
/****** Object:  StoredProcedure [dbo].[kembalikanBuku]    Script Date: 29/04/2018 15:50:40 ******/
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

	

END
