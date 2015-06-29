--WHICH DATABASE IS THE LARGEST
-- WHERE LOG FILE IS BIGGER THAN DATA
with fs
as
(
    select database_id, type, (size * 8.0 / 1024)/1024 size
    from sys.master_files
)
select 
    name,
    (select sum(size) from fs where type = 0 and fs.database_id = db.database_id) DataSizeGB,
    (select sum(size) from fs where type = 1 and fs.database_id = db.database_id) LogSizeGB
from sys.databases db
order by DataSizeGB desc