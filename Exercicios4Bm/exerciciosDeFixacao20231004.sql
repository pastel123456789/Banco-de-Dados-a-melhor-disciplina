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
