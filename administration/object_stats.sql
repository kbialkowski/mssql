--Longest lapsed objects, procedures,functions etc (SQL SERVER 2005)
select  obj.name,obj.type,creation_time,last_execution_time, execution_count,
AvgElapsedSeconds = ( total_elapsed_time/ CAST( 1000000 as float(15) ) ) / CAST( qs.execution_count as float(15) ),
LastElapsedSeconds = last_elapsed_time / CAST( 1000000 as float(38) )

,SUBSTRING(st.text, (qs.statement_start_offset/2) + 1,
         ((CASE statement_end_offset
          WHEN -1 THEN DATALENGTH(st.text)
          ELSE qs.statement_end_offset END
            - qs.statement_start_offset)/2) + 1) AS query_text 
from sys.dm_exec_query_stats qs 
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
INNER JOIN sys.sysobjects obj on st.objectid = obj.id
ORDER BY total_elapsed_time / execution_count DESC
go

