--last login time--
select * from (

	select max (login_time)as last_login_time, login_name from sys.dm_exec_sessions 
	group by login_name
) t 
order by last_login_time desc


--Connected logins
SELECT DB_NAME(dbid) AS DBName,COUNT(dbid)   AS NumberOfConnections,loginame AS LoginName,nt_domain AS NT_Domain,
nt_username AS NT_UserName,
hostname AS HostName
FROM   sys.sysprocesses
WHERE  dbid > 0
GROUP  BY dbid,hostname,loginame,nt_domain,nt_username
ORDER  BY NumberOfConnections DESC;