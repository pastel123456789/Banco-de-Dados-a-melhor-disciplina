-- 1
CREATE TRIGGER inserir_cliente BEFORE INSERT ON Clientes 
FOR EACH ROW
INSERT INTO Auditoria(mensagem, data_hora) VALUES
('cliente inserido', NOW());
