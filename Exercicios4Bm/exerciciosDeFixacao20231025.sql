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
END IF;
END;
