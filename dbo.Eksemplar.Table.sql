USE [Perpustakaan]
GO
/****** Object:  Table [dbo].[Eksemplar]    Script Date: 4/21/2018 11:45:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Eksemplar](
	[Id] [int] NOT NULL,
	[fkISBN] [nvarchar](50) NOT NULL,
	[statusEksemplar] [bit] NOT NULL,
 CONSTRAINT [PK_Eksemplar] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Eksemplar] ADD  CONSTRAINT [DF_Eksemplar_statusEksemplar]  DEFAULT ((0)) FOR [statusEksemplar]
GO
ALTER TABLE [dbo].[Eksemplar]  WITH CHECK ADD  CONSTRAINT [Fk_eksemplar_buku] FOREIGN KEY([fkISBN])
REFERENCES [dbo].[Buku] ([ISBN])
GO
ALTER TABLE [dbo].[Eksemplar] CHECK CONSTRAINT [Fk_eksemplar_buku]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 berarti belum dipinjam/tersedia , 1 vice versa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Eksemplar', @level2type=N'COLUMN',@level2name=N'statusEksemplar'
GO
