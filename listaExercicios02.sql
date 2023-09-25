ex 1
CREATE PROCEDURE sp_ListarAutores()
BEGIN
SELECT * FROM autor;
END

CREATE PROCEDURE sp_LivrosPorCategoria(IN nome_categoria varchar(200))
BEGIN
select *
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

ex 4 
CREATE PROCEDURE sp_VerificarLivrosCategoria(IN nome_categoria varchar(200), OUT resposta varchar(50))
BEGIN
DECLARE quantidade INT DEFAULT 0;
	select count(Livro.Titulo) as numero_de_livros
    INTO quantidade
	from Livro
	inner join Categoria on Categoria.Categoria_ID = Livro.Categoria_ID
	where nome_categoria = Categoria.Nome
	group by Categoria.Nome
	;
IF quantidade > 0 THEN SET resposta = 'possui livros';
ELSE 
SET resposta = 'não possui livros';
END IF;
select resposta;
END;

ex 5
CREATE PROCEDURE sp_LivrosAteAno(IN ano year)
BEGIN
SELECT Titulo, Ano_Publicacao from Livro
where Ano_Publicacao <= ano
ORDER BY Ano_Publicacao desc;
END;

ex 6
CREATE PROCEDURE sp_TitulosPorCategoria(IN nome_categoria varchar(200))
BEGIN
select Livro.Titulo, Categoria.Nome as categoria
from Livro
inner join Categoria on Categoria.Categoria_ID = Livro.Categoria_ID
where nome_categoria = Categoria.Nome;
END;

ex 8
CREATE PROCEDURE sp_AutorMaisAntigo()
BEGIN
SELECT Nome from Autor
ORDER BY Data_Nascimento
LIMIT 1;
END

ex 9
CREATE PROCEDURE sp_AutorMaisAntigo()
-- aqui a procedure foi criada/nomeada e ela não usa parâmetros
  
BEGIN
-- aqui ela começa

SELECT Nome from Autor
-- aqui a tabela "Nome" da tabela "Autor" foi selecionada
  
ORDER BY Data_Nascimento
-- os nomes dos autores foram ordenados pelos valores da tabela "Data_Nascimento"
  
LIMIT 1;
-- apenas um registro será exibido

END
-- fim da procedure

ex 10
CREATE PROCEDURE sp_LivrosESeusAutores()
BEGIN
select Livro.Titulo, Autor.Nome, Autor.Sobrenome
from Livro
inner join Autor_Livro on Autor_Livro.Livro_ID = Livro.Livro_ID
inner join Autor on Autor_Livro.Autor_ID = Autor.Autor_ID;
END


