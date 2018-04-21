USE [Perpustakaan]
GO
/****** Object:  Table [dbo].[Denda]    Script Date: 4/21/2018 11:45:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Denda](
	[Id] [int] NOT NULL,
	[Harga] [int] NOT NULL,
	[TanggalMulai] [date] NULL,
	[TanggalBerakhir] [date] NULL,
	[PerBerapaHari] [int] NOT NULL,
 CONSTRAINT [PK_Denda] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
