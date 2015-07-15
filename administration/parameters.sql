--Server parametrs 
--http://blogs.msdn.com/b/sqlcat/archive/2006/06/23/tom-davidson-sqlcat-best-practices.aspx


---Buffer pool hit ratio------
SELECT (a.cntr_value * 1.0 / b.cntr_value) * 100.0 as BufferCacheHitRatio
FROM sys.dm_os_performance_counters  a
JOIN  (SELECT cntr_value,OBJECT_NAME 
    FROM sys.dm_os_performance_counters  
    WHERE counter_name = 'Buffer cache hit ratio base'
        AND OBJECT_NAME = 'SQLServer:Buffer Manager') b ON  a.OBJECT_NAME = b.OBJECT_NAME
WHERE a.counter_name = 'Buffer cache hit ratio'
AND a.OBJECT_NAME = 'SQLServer:Buffer Manager'


----Page life expectancy----
--https://www.sqlskills.com/blogs/jonathan/finding-what-queries-in-the-plan-cache-use-a-specific-index/

SELECT * FROM sys.dm_os_performance_counters 
WHERE [object_name] LIKE '%Buffer Manager%' AND [counter_name] = 'Page life expectancy' 


SELECT object_name, counter_name, cntr_value, cntr_type
FROM sys.dm_os_performance_counters
WHERE [object_name] LIKE '%Buffer Manager%'
AND [counter_name] = 'Lazy writes/sec'
