USE [Perpustakaan]
GO
/****** Object:  Table [dbo].[SearchingRelation]    Script Date: 4/20/2018 10:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchingRelation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkKata] [int] NOT NULL,
	[fkBuku] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SearchingRelation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SearchingRelation]  WITH CHECK ADD  CONSTRAINT [FK_SearchingRelation_Buku] FOREIGN KEY([fkBuku])
REFERENCES [dbo].[Buku] ([ISBN])
GO
ALTER TABLE [dbo].[SearchingRelation] CHECK CONSTRAINT [FK_SearchingRelation_Buku]
GO
ALTER TABLE [dbo].[SearchingRelation]  WITH CHECK ADD  CONSTRAINT [FK_SearchingRelation_Kata] FOREIGN KEY([fkKata])
REFERENCES [dbo].[Kata] ([id])
GO
ALTER TABLE [dbo].[SearchingRelation] CHECK CONSTRAINT [FK_SearchingRelation_Kata]
GO
