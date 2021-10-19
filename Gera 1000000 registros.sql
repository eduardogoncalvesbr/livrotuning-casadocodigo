drop table pesquisa
/

create table pesquisa
(
   codigo   number
  ,assistem varchar(25)
  ,idade    number
  ,genero   varchar2(1)
)
/

create index assistem_ix on pesquisa (assistem)
/

declare
  qt_commit number := 0;
begin
  for i in 1..350000 loop
   
    if i <= 10 then
      insert into pesquisa values (i,'Programa do Bolinha',trunc(dbms_random.value(16,100)),decode(mod(trunc(dbms_random.value(16,100)),2),0,'F','M'));
    end if;  
    --
    if i <= 150000 then
      insert into pesquisa values (i,'Telejornais',trunc(dbms_random.value(16,100)),decode(mod(trunc(dbms_random.value(16,100)),2),0,'F','M'));
      insert into pesquisa values (i,'Novelas',trunc(dbms_random.value(16,100)),decode(mod(trunc(dbms_random.value(16,100)),2),0,'F','M'));
      insert into pesquisa values (i,'Filmes',trunc(dbms_random.value(16,100)),decode(mod(trunc(dbms_random.value(16,100)),2),0,'F','M'));
      insert into pesquisa values (i,'Series',trunc(dbms_random.value(16,100)),decode(mod(trunc(dbms_random.value(16,100)),2),0,'F','M'));
    elsif i > 150000 and i <= 200000 then
      insert into pesquisa values (i,'Novelas',trunc(dbms_random.value(16,100)),decode(mod(trunc(dbms_random.value(16,100)),2),0,'F','M'));
      insert into pesquisa values (i,'Filmes',trunc(dbms_random.value(16,100)),decode(mod(trunc(dbms_random.value(16,100)),2),0,'F','M'));
      insert into pesquisa values (i,'Series',trunc(dbms_random.value(16,100)),decode(mod(trunc(dbms_random.value(16,100)),2),0,'F','M'));
    elsif i > 200000 and i <= 300000 then
      insert into pesquisa values (i,'Filmes',trunc(dbms_random.value(16,100)),decode(mod(trunc(dbms_random.value(16,100)),2),0,'F','M'));
      insert into pesquisa values (i,'Series',trunc(dbms_random.value(16,100)),decode(mod(trunc(dbms_random.value(16,100)),2),0,'F','M'));
    elsif i > 300000 and i <= 350000 then
      insert into pesquisa values (i,'Series',trunc(dbms_random.value(16,100)),decode(mod(trunc(dbms_random.value(16,100)),2),0,'F','M'));
    end if;
    if qt_commit = 500 then
       commit;
       qt_commit :=0;
    end if;
    qt_commit := qt_commit +1;
  end loop;
  commit;
end;
/

select count(*) pessoas, assistem from pesquisa group by assistem order by 1 desc
/

select count(*) from pesquisa
/

set autotrace on

select assistem, idade, genero from pesquisa where assistem = 'Programa do Bolinha'
/

begin
  dbms_stats.gather_table_stats( 'TTUN','PESQUISA'
                                ,cascade => true
                                ,estimate_percent => 10
                                ,degree => 4);
end;
/

begin
  dbms_stats.gather_table_stats( 'TTUN','PESQUISA'
                                ,estimate_percent => 10
                                ,method_opt => 'for columns assistem size 10'                                   
                                ,cascade => true
                                ,degree => 4 ); 
end;
/

exec dbms_stats.delete_table_stats('TTUN', 'PESQUISA');
exec dbms_stats.delete_index_stats('TTUN', 'ASSISTEM_IX');
exec dbms_stats.delete_column_stats('TTUN', 'PESQUISA','ASSISTEM');
/

select trunc(dbms_random.value(16,100)) from dual

select decode(mod(trunc(dbms_random.value(16,100)),2),0,'f','m') from dual
