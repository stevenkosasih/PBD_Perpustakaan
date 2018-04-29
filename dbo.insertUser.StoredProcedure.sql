USE [Perpustakaan]
GO
/****** Object:  StoredProcedure [dbo].[insertUser]    Script Date: 29/04/2018 18:07:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[insertUser]
	-- Add the parameters for the stored procedure here
	@npm nvarchar(15),
	@nama nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    insert into Users
	select
		@npm,
		@nama

	select CONCAT('User dengan nama ',@nama, ' berhasil ditambahkan')
END
