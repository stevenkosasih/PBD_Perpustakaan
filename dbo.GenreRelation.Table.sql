USE [Perpustakaan]
GO
/****** Object:  Table [dbo].[GenreRelation]    Script Date: 22/04/2018 17:07:42 ******/
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
