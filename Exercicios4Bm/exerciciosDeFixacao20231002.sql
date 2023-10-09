-- 1 
DROP TABLE nomes;
CREATE TABLE nomes (
nome VARCHAR(100)
);

INSERT INTO nomes VALUES
('Roberta'),
('Roberto'),
('Maria Clara'),
('João');

select * from nomes;

select upper(nome) from nomes;
select length(nome) from nomes;
select concat('Sr. ', nome) from nomes where nome like '%o';
select concat('Sra. ', nome) from nomes where nome like '%a';

DROP TABLE produtos;
CREATE TABLE produtos (
produto VARCHAR(100),
preco FLOAT,
quantidade INT
);
