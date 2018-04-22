USE [Perpustakaan]
GO
/****** Object:  UserDefinedFunction [dbo].[pemisahKoma]    Script Date: 22/04/2018 17:07:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[pemisahKoma]
(
	@kata varchar(50)
)
RETURNS @result table(

kata varchar(50)
)
BEGIN
	declare @start int=1, @koma varchar(1)=',',@end int=1,@length int, @tempKata varchar(50)

	select @length=LEN(@kata)
	
	while(@end<=@length)
	begin
		 if(CHARINDEX(@koma,@kata,@start)!=@end )
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
