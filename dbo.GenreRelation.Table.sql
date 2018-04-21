USE [Perpustakaan]
GO
/****** Object:  Table [dbo].[GenreRelation]    Script Date: 4/21/2018 11:45:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenreRelation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkBuku] [nvarchar](50) NOT NULL,
	[fkGenre] [int] NOT NULL,
 CONSTRAINT [PK_GenreRelation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GenreRelation]  WITH CHECK ADD  CONSTRAINT [FK_GenreRelation_Buku] FOREIGN KEY([fkBuku])
REFERENCES [dbo].[Buku] ([ISBN])
GO
ALTER TABLE [dbo].[GenreRelation] CHECK CONSTRAINT [FK_GenreRelation_Buku]
GO
ALTER TABLE [dbo].[GenreRelation]  WITH CHECK ADD  CONSTRAINT [FK_GenreRelation_Genre] FOREIGN KEY([fkGenre])
REFERENCES [dbo].[Genre] ([id])
GO
ALTER TABLE [dbo].[GenreRelation] CHECK CONSTRAINT [FK_GenreRelation_Genre]
GO
