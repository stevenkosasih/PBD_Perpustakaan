USE [Perpustakaan]
GO
/****** Object:  StoredProcedure [dbo].[pesanBuku]    Script Date: 29/04/2018 18:16:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[pesanBuku]
	-- Add the parameters for the stored procedure here
	@ISBN varchar(50),
	@id nvarchar(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into Pemesanan(fkUsers,fkBuku)
	select
		@id,
		@ISBN

	
END
