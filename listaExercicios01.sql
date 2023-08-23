select titulo from livros;

select nome from autores
where nascimento < '1900-01-01';

select livros.titulo, autores.nome
from livros
inner join autores on autores.id = 1 and livros.autor_id = autores.id;
