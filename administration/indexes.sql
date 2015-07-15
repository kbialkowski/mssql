---FRAGMENTATION--
--http://blog.sqlauthority.com/2010/01/12/sql-server-fragmentation-detect-fragmentation-and-eliminate-fragmentation/

SELECT OBJECT_NAME(A.object_id) as 'TableName', B.name as 'IndexName',a.index_id,
a.page_count, a.index_type_desc, a.avg_fragmentation_in_percent,a.avg_page_space_used_in_percent
FROM 
sys.dm_db_index_physical_stats(db_id(),NULL,NULL,NULL,'DETAILED') a 
INNER JOIN sys.indexes b ON a.object_id = b.object_id and a.index_id = b.index_id  
where page_count>1000 and avg_fragmentation_in_percent >20
order by avg_fragmentation_in_percent desc
