-- CEFET-MG - Eng. Computação - LBD I - Prof. Evandrino Barros
-- Processador de Consultas - 07/10/2022 e 14/10/2022

-- verificação da existência da tabela EMPLOYEES
select * from EMPLOYEES;

-- remoção de índice não único já criado sobre essa tabela
-- consulta ao dicionário de dados para se achar os
-- índices na tabela EMPLOYEES
select index_name, uniqueness, table_name 
from user_indexes where 
table_name = 'EMPLOYEES';

-- remoção do índice sobre a chave não unica SALARY
drop index SALARY_IDX;

select index_name, uniqueness, table_name from user_indexes where 
table_name = 'EMPLOYEES';

-- remoção das estatísticas já existentes para garantir
-- que elas serão usadas
analyze table EMPLOYEES delete statistics;

-- consulta simples para achar os empregados
-- com salario maior que 12.000
-- 3 registros atendem à consulta entre 107 registros da tabela
select *
from   EMPLOYEES
where  salary=12000;

-- criaçao de um índice na coluna SALARY
-- nome do índice: SALARY_IDX

create index SALARY_IDX on EMPLOYEES(SALARY);
-- gerando o plano de execução da consulta outra vez

select index_name, uniqueness, table_name from user_indexes where 
table_name = 'EMPLOYEES';

select *
from   EMPLOYEES
where  salary=12000;

select first_name, last_name 
from   employees
where  employee_id=205;

select rowid 
from   employees
where  employee_id=205;

select employee_id, first_name, last_name 
from   employees
where   rowid='AAA4PyAAAAAAF+fAAJ';


select *
from   EMPLOYEES;

select *
from   EMPLOYEES
where  salary>12000; -- 12.000

select *
from   EMPLOYEES
where  salary<1; -- 120.000

-- remover estatísticas, caso já existam
analyze table EMPLOYEES delete statistics;

select TABLE_NAME, NUM_ROWS, EMPTY_BLOCKS, blocks
from   USER_TABLES
where  TABLE_NAME='EMPLOYEES';

-- gerando as estatísticas para uma tabela
analyze table EMPLOYEES compute statistics;  --> colocar 29 aqui para consulta

select TABLE_NAME, NUM_ROWS, EMPTY_BLOCKS, blocks
from   USER_TABLES
where  TABLE_NAME='EMPLOYEES';


-- gerando o plano de execução outras com três 
-- cardinalidades
-- SALARY > 1200: 107/107 = 1 --> 100%
-- SALARY > 12000: 6/107  = 0.056 --> 6%: 
-- SALARY > 120000: 0/107: 0% (0<=seletividade<=1)
-- seletividade: que é o percentual de linhas retornados por uma consulta
-- selectivdade = (num. de reg. selecionados)/(número de registros na tabela)

-- SALARY > 1200: 107/107: Seletividade: 1 (100%)
select *
from   EMPLOYEES
where  salary>1200;


-- SALARY > 12000: seletividade: 6/107 --> 6%
select *
from   EMPLOYEES
where  salary>12000;

-- SALARY = 12000: seletividade: 2/107 --> 2%
select *
from   EMPLOYEES
where  salary=12000;


-- seletividade: 0/107: 0% (0<=seletividade<=1)
select *
from   EMPLOYEES
where  salary>120000;


-- uso do próprio índice para obteção dos dados
select salary
from   EMPLOYEES
where  salary>12000;

select salary
from   EMPLOYEES
order by salary;




-- gerando as estatísticas para uma coluna,
-- ou seja, gerando histogramas para uma consulta
analyze table EMPLOYEES compute statistics 
for columns SALARY;

-- consultando um histograma
select * from USER_HISTOGRAMS
where table_name='EMPLOYEES' and column_name='SALARY';

-- gerando o plano de execução outras com três 
-- cardinalidades
-- SALARY > 1200
-- SALARY > 12000
-- SALARY > 120000

-- SALARY > 1200: 107/107: Seletividade: 1 (100%)
select *
from   EMPLOYEES
where  salary>1200;

-- SALARY > 12000: seletividade: 6/107 --> 6%
select *
from   EMPLOYEES
where  salary>12000;

-- SALARY = 12000: seletividade: 2/107 --> 2%
select *
from   EMPLOYEES
where  salary=12000;


-- seletividade: 0/107: 0% (0<=seletividade<=1)
select *
from   EMPLOYEES
where  salary>120000;

-- removendo as estatísticas
analyze table EMPLOYEES delete statistics;

select * from USER_HISTOGRAMS
where table_name='EMPLOYEES' and column_name='SALARY';

-- algoritmos de junção

-- produto cartesiano 
select *
from   EMPLOYEES E, DEPARTMENTS D;

select *
from  EMPLOYEES E, DEPARTMENTS D
where E.DEPARTMENT_ID = D.DEPARTMENT_ID;

select *
from  EMPLOYEES E join DEPARTMENTS D on 
      E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- junção externa
select *
from  EMPLOYEES E right join DEPARTMENTS D on 
      E.DEPARTMENT_ID = D.DEPARTMENT_ID;


-- forçando o uso de outros métodos de junção
select /*+ USE_NL(E D) */ *
from  EMPLOYEES E, DEPARTMENTS D
where E.DEPARTMENT_ID = D.DEPARTMENT_ID;

select /*+ USE_HASH(E D) */ *
from  EMPLOYEES E, DEPARTMENTS D
where E.DEPARTMENT_ID = D.DEPARTMENT_ID;

select /*+ USE_MERGE(E D) */ *
from  EMPLOYEES E, DEPARTMENTS D
where E.DEPARTMENT_ID = D.DEPARTMENT_ID;


