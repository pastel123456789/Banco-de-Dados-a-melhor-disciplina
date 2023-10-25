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
