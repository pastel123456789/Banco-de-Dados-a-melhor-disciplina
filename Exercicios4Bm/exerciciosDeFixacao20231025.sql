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
