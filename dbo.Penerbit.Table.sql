USE [Perpustakaan]
GO
/****** Object:  Table [dbo].[Penerbit]    Script Date: 4/21/2018 11:45:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Penerbit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nama] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Penerbit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
