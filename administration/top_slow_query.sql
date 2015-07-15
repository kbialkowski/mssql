-- Top 20 longest queries

-- sys.dm_exec_query_stats Returns performance statistics for cached query plans. This contains one row per query plan so if a stored procedure or batch contains two SELECT statements you may get two rows here
-- sys.dm_exec_sql_text Returns the text of the sql statement based on the SQL handle
-- sys.dm_exec_query_plan Returns the showplan in XML format for a batch or module based on the plan handle



select top 20 creation_time,last_execution_time, execution_count,
AvgElapsedSeconds = ( total_elapsed_time/ CAST( 1000000 as float(15) ) ) / CAST( qs.execution_count as float(15) ),
LastElapsedSeconds = last_elapsed_time / CAST( 1000000 as float(38) )

,SUBSTRING(st.text, (qs.statement_start_offset/2) + 1,
         ((CASE statement_end_offset
          WHEN -1 THEN DATALENGTH(st.text)
          ELSE qs.statement_end_offset END
            - qs.statement_start_offset)/2) + 1) AS query_text 
from sys.dm_exec_query_stats qs 
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
ORDER BY total_elapsed_time / execution_count DESC
go

