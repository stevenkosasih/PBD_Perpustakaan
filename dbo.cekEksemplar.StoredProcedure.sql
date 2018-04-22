USE [Perpustakaan]
GO
/****** Object:  StoredProcedure [dbo].[cekEksemplar]    Script Date: 22/04/2018 16:42:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[cekEksemplar]
	-- Add the parameters for the stored procedure here
	@ISBN nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent ex tra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	declare @status bit

	select
		@status=statusEksemplar
	from
		Eksemplar
	where
		fkISBN=@ISBN

	select 
		statusPeminjaman
	from	
		statusEksemplar
	where
		@status = statusEksemplar

		
END
GO
