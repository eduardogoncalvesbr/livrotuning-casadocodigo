--drop user ttun
--/
create user ttun identified by ttun
/
grant connect, resource to ttun
/
grant create table to ttun
/
grant create view to ttun
/