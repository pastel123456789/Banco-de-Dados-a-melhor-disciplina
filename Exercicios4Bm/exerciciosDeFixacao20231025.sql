-- 1
CREATE TRIGGER inserir_cliente BEFORE INSERT ON Clientes 
FOR EACH ROW
INSERT INTO Auditoria(mensagem, data_hora) VALUES
('cliente inserido', NOW());

-- 2
CREATE TRIGGER deletar_cliente BEFORE DELETE ON Clientes 
FOR EACH ROW
INSERT INTO Auditoria(mensagem, data_hora) VALUES
('tentativa de excluir cliente', NOW());

-- 3
CREATE TRIGGER atualizar_cliente AFTER UPDATE ON Clientes 
FOR EACH ROW
INSERT INTO Auditoria(mensagem, data_hora) VALUES
(CONCAT('Antigo nome: ', OLD.nome, '. Novo nome: ', NEW.nome), NOW());

-- 4 não descobri como faz pra impedir o update e fazer um registro na auditoria ao mesmo tempo, só consigo fazer ou um ou outro
CREATE TRIGGER cliente_nulo AFTER UPDATE ON Clientes 
FOR EACH ROW
BEGIN
IF NEW.nome = '' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Nome inválido';
INSERT INTO Auditoria(mensagem, data_hora) VALUES
('Nome inválido', NOW());
DELETE FROM Clientes WHERE nome = NULL;

-- 5
-- 5
CREATE TRIGGER diminuir_estoque
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    DECLARE produto_estoque INT;
    SELECT estoque INTO produto_estoque FROM Produtos WHERE id = NEW.produto_id;
    
    IF produto_estoque >= NEW.quantidade THEN
        UPDATE Produtos
        SET estoque = estoque - NEW.quantidade
        WHERE id = NEW.produto_id;
    ELSE
        INSERT INTO Auditoria (mensagem)
        VALUES ('Tentativa de inserir pedido com estoque insuficiente para o produto');
    END IF;

    IF produto_estoque - NEW.quantidade < 5 THEN
        INSERT INTO Auditoria (mensagem)
        VALUES ('Estoque do produto está abaixo de 5 unidades.');
    END IF;
END;
END IF;
END;
