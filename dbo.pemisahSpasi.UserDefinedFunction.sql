USE [Perpustakaan]
GO
/****** Object:  UserDefinedFunction [dbo].[pemisahSpasi]    Script Date: 4/21/2018 11:45:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[pemisahSpasi]
(
	@kata varchar(50)
)
RETURNS @result table(

kata varchar(50)
)
BEGIN
	declare @start int=1, @space varchar(1)=' ',@end int=1,@length int, @tempKata varchar(50)

	select @length=LEN(@kata)
	
	while(@end<=@length)
	begin
		 if(CHARINDEX(@space,@kata,@start)!=@end )
		 begin
			
				set @tempKata=CONCAT(@tempKata,SUBSTRING(@kata,@start,1))
			
				set @end=@end+1
			
			set @start=@start+1
		 end
		
		else
		begin
		
				insert into @result
				select
					@tempKata
			set @tempKata=''
				set @start=@start+1
				set @end=@end+1
		end
		
	end
	insert into @result
	select @tempKata


RETURN
END

GO
