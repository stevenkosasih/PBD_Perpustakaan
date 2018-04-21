USE [Perpustakaan]
GO
/****** Object:  StoredProcedure [dbo].[findByGenre]    Script Date: 4/21/2018 11:45:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[findByGenre]
	-- Add the parameters for the stored procedure here
	@genre nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
			Judul
				from
					Genre_Buku_View
								where
									genre=@genre
								
END
GO
