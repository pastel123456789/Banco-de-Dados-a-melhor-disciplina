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

10) select autores.nome, count(livros.autor_id) as quantidade_livros
from autores
inner join livros on autores.id = livros.autor_id
group by autores.nome
having quantidade_livros > 2;

11) select livros.titulo, autores.nome
from livros
inner join autores on livros.autor_id = autores.id;

12) select alunos.nome, matriculas.curso
from alunos
inner join matriculas on matriculas.aluno_id = alunos.id;

13) select autores.nome, livros.titulo
from autores
left join livros on livros.autor_id = autores.id;

14) select matriculas.curso, alunos.nome
from matriculas
right join alunos on matriculas.aluno_id = alunos.id;

15) select alunos.nome, matriculas.curso
from alunos
inner join matriculas on matriculas.aluno_id = alunos.id;

16) select autores.nome, count(livros.autor_id) as quantidade_livros
from autores
inner join livros on autores.id = livros.autor_id
group by autores.nome
order by quantidade_livros desc;
