USE [Perpustakaan]
GO
/****** Object:  Table [dbo].[statusEksemplar]    Script Date: 22/04/2018 17:07:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[statusEksemplar](
	[statusEksemplar] [bit] NOT NULL,
	[statusPeminjaman] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
