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

-- 3
CREATE FUNCTION atualizar_resumos() RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE fim INT DEFAULT 0;
    DECLARE livro_id INT;
    DECLARE resumo_atual TEXT;
    
    DECLARE c_atualizar CURSOR FOR 
        SELECT id, resumo
        FROM Livro;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 1;

    OPEN c_atualizar;

    SET @resumos_atualizados := '';

    loop_legal: LOOP
        FETCH c_atualizar INTO livro_id, resumo_atual;
        IF fim THEN
            LEAVE loop_legal;
        END IF;
        
        SET resumo_atual = CONCAT(resumo_atual, '\nEste é um excelente livro!');
        
        UPDATE Livro
        SET resumo = resumo_atual
        WHERE id = livro_id;
        
        SET @resumos_atualizados := CONCAT_WS('\n', @resumos_atualizados, resumo_atual);
    END LOOP;

    CLOSE c_atualizar;
    
    RETURN @resumos_atualizados;
END;

-- 4
CREATE FUNCTION media_livros_por_editora() RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
    DECLARE total_livros INT;
    DECLARE total_editoras INT;
    DECLARE editora_id INT;
    DECLARE total_livros_editora INT;
    DECLARE media DECIMAL(10, 2) DEFAULT 0;
    DECLARE cur_editoras CURSOR FOR 
        SELECT id FROM Editora;
    SET total_livros := (SELECT COUNT(*) FROM Livro);
    SET total_editoras := (SELECT COUNT(*) FROM Editora);
    
    
    IF total_editoras = 0 THEN
        RETURN 0; 
    END IF;
    
    
    
    OPEN cur_editoras;

    read_editora: LOOP
        FETCH cur_editoras INTO editora_id;
        IF total_editoras = 0 THEN
            LEAVE read_editora;
        END IF;
        
        
        SET total_livros_editora := (
            SELECT COUNT(*)
            FROM Livro
            WHERE id_editora = editora_id
        );
        
        
        SET media := media + (total_livros_editora / total_editoras);
    END LOOP;

    CLOSE cur_editoras;
    
    RETURN media;
END;

-- 5
CREATE FUNCTION autores_sem_livros() RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE autor_id INT;
    DECLARE primeiro_nome_autor VARCHAR(255);
    DECLARE ultimo_nome_autor VARCHAR(255);
    DECLARE done INT DEFAULT 0;
    DECLARE autores_sem_livros TEXT DEFAULT '';
    
    DECLARE cur_autores CURSOR FOR 
        SELECT id, primeiro_nome, ultimo_nome
        FROM Autor;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur_autores;

    read_loop: LOOP
        FETCH cur_autores INTO autor_id, primeiro_nome_autor, ultimo_nome_autor;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        IF NOT EXISTS (
            SELECT 1 
            FROM Livro_Autor 
            WHERE id_autor = autor_id
        ) THEN
            SET autores_sem_livros := CONCAT(autores_sem_livros, primeiro_nome_autor, ' ', ultimo_nome_autor, '\n');
        END IF;
    END LOOP;

    CLOSE cur_autores;

    RETURN autores_sem_livros;
END;
