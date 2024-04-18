# Comandos-SQL
1) Execute o seguinte comando SQL, o qual inclui o endereço físico da linha retornada, 
apresentado na coluna virtual chamada ROWID. A condição rownum=1 limita o 
resultado a somente uma linha. A tabela EMPLOYEES usada é apresenta na Figura 1.
select rowid, employee_id, first_name, last_name, salary
from employees 
where rownum=1;
Faça uma segunda consulta, buscando o empregado pelo rowid retornado na sua 
consulta. Para isso, utilize o comando abaixo, trocando X pelo valor de rowid retornado 
na sua consulta.
select rowid, employee_id, first_name, last_name, salary
from employees
where rowid='X'
3
Apresente o plano de execução para essa última consulta. É possível ter um plano de 
execução melhor do que este? Justifique a sua resposta.
2) Execute o seguinte comando SQL, apresente o seu plano de execução assim como a 
sua explicação. 
 select * from employees where salary > 12000 
3) Crie um índice na coluna SALARY de EMPLOYEES. Apresente o comando.
4) Execute novamente o comando da questão 3, apresente o seu plano de execução assim 
como a sua explicação. Houve alguma mudança em relação ao plano da questão 2? Que 
mudança ocorreu. Justifique-a.
5) Apresente e execute os comandos SQL que criam estatísticas na tabela EMPLOYEES 
e o histograma da coluna SALARY. Explique os comandos.
6) Apresente o comando de consulta ao dicionário que mostra as estatísticas da tabela
EMPLOYEES, bem como o histograma da coluna SALARY. A partir do resultado, 
informe quantos blocos tem a tabela, quantos blocos são vazios, quantas linhas e o 
tamanho médio das linhas.
7) Execute o seguinte comando SQL, apresente o seu plano e explique por que a tabela 
EMPLOYEES não é utilizada. Por que o índice é utilizado no acesso físico?
select salary from employees where salary >= 12000
8) Apresente o comando para remover as estatísticas da tabela EMPLOYEES. 
4
9) Apresente um comando SQL que faça junção entre EMPLOYEES e DEPARTMENT, 
assim como o seu plano de execução. Explique o plano obtido
