1) select titulo from livros;

2) select nome from autores
where nascimento < '1900-01-01';

3) select livros.titulo, autores.nome
from livros
inner join autores on autores.id = 1 and livros.autor_id = autores.id;

4) select alunos.nome
from alunos
inner join matriculas on matriculas.curso = 'Engenharia de Software' and matriculas.aluno_id = alunos.id;
