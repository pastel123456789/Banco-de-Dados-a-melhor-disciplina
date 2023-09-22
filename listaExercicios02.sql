ex 1
CREATE PROCEDURE sp_ListarAutores()
BEGIN
SELECT * FROM autor;
END

ex 2 
CREATE PROCEDURE sp_LivrosPorCategoria(IN nome_categoria varchar(200))
BEGIN
select Livro.Titulo, Categoria.Nome as categoria
from Livro
inner join Categoria on Categoria.Categoria_ID = Livro.Categoria_ID
where nome_categoria = Categoria.Nome;
END;

ex 3
CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN nome_categoria varchar(200))
BEGIN
select count(Livro.Titulo) as numero_de_livros, Categoria.Nome as categoria
from Livro
inner join Categoria on Categoria.Categoria_ID = Livro.Categoria_ID
where nome_categoria = Categoria.Nome
group by Categoria.Nome;
END;

ex 5
CREATE PROCEDURE sp_LivrosAteAno(IN ano year)
BEGIN
SELECT Titulo, Ano_Publicacao from Livro
where Ano_Publicacao <= ano
ORDER BY Ano_Publicacao desc;
END;




