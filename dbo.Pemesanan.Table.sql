USE [Perpustakaan]
GO
/****** Object:  Table [dbo].[Pemesanan]    Script Date: 4/20/2018 10:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pemesanan](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkUsers] [int] NOT NULL,
	[fkBuku] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Pemesanan] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pemesanan]  WITH CHECK ADD  CONSTRAINT [FK_Pemesanan_Buku] FOREIGN KEY([fkBuku])
REFERENCES [dbo].[Buku] ([ISBN])
GO
ALTER TABLE [dbo].[Pemesanan] CHECK CONSTRAINT [FK_Pemesanan_Buku]
GO
ALTER TABLE [dbo].[Pemesanan]  WITH CHECK ADD  CONSTRAINT [FK_Pemesanan_Users] FOREIGN KEY([fkUsers])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Pemesanan] CHECK CONSTRAINT [FK_Pemesanan_Users]
GO
