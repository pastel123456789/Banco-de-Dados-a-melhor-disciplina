-- 1, esse aqui tem umas gambiarra aí que não faz sentido mas ta funcionando
CREATE FUNCTION total_livros_por_genero(nome VARCHAR(20))
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE variavel VARCHAR(500);
	DECLARE total INT DEFAULT -1;
	DECLARE fimloop INT DEFAULT 0;
	DECLARE c_livros_genero CURSOR FOR SELECT
    titulo FROM Livro INNER JOIN Genero on Genero.id = Livro.id_genero WHERE Genero.nome_genero = nome;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fimloop = 1;
    
    OPEN c_livros_genero;
    WHILE(fimloop != 1)DO
		FETCH c_livros_genero INTO variavel;
        IF variavel IS NOT NULL THEN
        SET total = total + 1;
        END IF;
    END WHILE;
CLOSE c_livros_genero;
RETURN total;
END

-- 2
CREATE FUNCTION listar_livros_por_autor(
    autor_nome VARCHAR(100),
    autor_sobrenome VARCHAR(100)
) RETURNS VARCHAR(1000) DETERMINISTIC
BEGIN
    DECLARE fim INT DEFAULT 0;
    DECLARE titulo_livro VARCHAR(200);
    DECLARE c_nome CURSOR FOR 
        SELECT Livro.titulo
        FROM Livro_Autor
        INNER JOIN Livro ON Livro_Autor.id_livro = Livro.id
        INNER JOIN Autor ON Livro_Autor.id_autor = Autor.id
        WHERE Autor.primeiro_nome = autor_nome AND Autor.ultimo_nome = autor_sobrenome;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 1;

    SET SESSION group_concat_max_len = 1000000;

    OPEN c_nome;

    SET @titulos = '';

    read_loop: LOOP
        FETCH c_nome INTO titulo_livro;
        IF fim THEN
            LEAVE read_loop;
        END IF;
        SET @titulos = CONCAT_WS('\n', @titulos, titulo_livro);
    END LOOP;

    CLOSE c_nome;

    RETURN @titulos;
END
