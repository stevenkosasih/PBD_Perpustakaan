USE [Perpustakaan]
GO
/****** Object:  StoredProcedure [dbo].[insertUser]    Script Date: 22/04/2018 17:07:42 ******/
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
