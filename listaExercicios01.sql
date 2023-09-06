1) select titulo from livros;

2) select nome from autores
where nascimento < '1900-01-01';

3) select livros.titulo, autores.nome
from livros
inner join autores on autores.id = 1 and livros.autor_id = autores.id;

4) select alunos.nome
from alunos
inner join matriculas on matriculas.curso = 'Engenharia de Software' and matriculas.aluno_id = alunos.id;

5) select produto, sum(receita) as receita_total from vendas
group by produto;

6) select autores.nome, count(livros.autor_id) as quantidade_livros
from autores
inner join livros on autores.id = livros.autor_id
group by autores.nome;

7) select count(alunos.id) as quantidade_alunos, matriculas.curso
from alunos
inner join matriculas on alunos.id = matriculas.aluno_id
group by curso

8) select produto, avg(receita) as receita_media from vendas
group by produto;

9) select produto, sum(receita) as receita_total from vendas
group by produto
having receita_total > 10000;
