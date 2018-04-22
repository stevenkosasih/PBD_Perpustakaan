USE [Perpustakaan]
GO
/****** Object:  Table [dbo].[Buku]    Script Date: 22/04/2018 17:07:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Buku](
	[ISBN] [nvarchar](50) NOT NULL,
	[Judul] [nvarchar](70) NOT NULL,
	[TahunTerbit] [int] NOT NULL,
	[deskripsi] [text] NULL,
	[fkPengarang] [int] NOT NULL,
	[fkPenerbit] [int] NOT NULL,
 CONSTRAINT [PK_Buku] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
