CREATE SCHEMA capitalist;
SET search_path = capitalist;

CREATE TABLE jogador(
	id_jogador INT PRIMARY KEY,
	nome VARCHAR(30),
	email VARCHAR(30),
	criado_em DATE,
	saldo DOUBLE PRECISION
);

CREATE TABLE tipo_investimento(
	id_tipo_investimento INT PRIMARY KEY,
	nome VARCHAR(30),
	valor_aquisicao DOUBLE PRECISION,
	rendimento_ciclo DOUBLE PRECISION,
	tempo_ciclo_seq --qual o tipo de dado
	gr_rendimento --qual tipo de dado
	gr_preco --qual tipo de dado
);

CREATE TABLE gestor(
	id_gestor INT PRIMARY KEY,
	nome VARCHAR(30),
	id_tipo_inv INT FOREIGN KEY,
	custo_aquisicao DOUBLE PRECISION,
	comissao_venda FLOAT --seria porcentagem em decimal?
	FOREIGN KEY (id_tipo_inv) REFERENCES tipo_investimentos (id_tipo_inv)
 );
 
CREATE TABLE tipo_melhoria(
 	id_tipo_melhoria INT PRIMARY KEY,
	 id_tipo_inv INT FOREIGN KEY,
	 nome VARCHAR(30),
	 desc VARCHAR(200),
	 atributo_melhorado VARCHAR(30), --criar tabela atributos?
	 taxa_alteracao DOUBLE PRECISION,
	 FOREIGN KEY (id_tipo_inv) REFERENCES tipo_investimentos (id_tipo_inv)
);

CREATE TABLE tipo_item(
	id_tipo_item INT PRIMARY KEY,
	nome VARCHAR(30),
	preco_aquisicao DOUBLE PRECISION,
	quant_vendas INT
);

CREATE TABLE investimentos(
	id_inv INT PRIMARY KEY,
	id_jogador FOREIGN KEY,
	id_tipo_inv FOREIGN KEY,
	obtido_em DATE,
	nivel_atual INT, --criar tabela niveis?
	ultima_coleta_em DATE,
	ultimo_ciclo_iniciou_em DATE,
	FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador),
	FOREIGN KEY (id_tipo_inv) REFERENCES tipo_investimento (id_tipo_inv)
);

CREATE TABLE rendimentos(
	id_rendimento INT PRIMARY KEY,
	id_inv INT FOREIGN KEY,
	valor_obtido DOUBLE PRECISION,
	nivel_inv_na_coleta INT,
	ciclo_concluido_em DATE,
	coletado_em DATE,
	FOREIGN KEY (id_inv) REFERENCES investimentos (id_inv)
);

CREATE TABLE contratacao_gestor(
	id_contratacao INT PRIMARY KEY,
	id_jogador INT FOREIGN KEY,
	id_gestor INT FOREIGN KEY,
	contratado_em DATE,
	FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador),
	FOREIGN KEY (id_gestor) REFERENCES gestor (id_gestor)
);

CREATE TABLE melhorias(
	id_melhoria INT PRIMARY_KEY,
	id_tipo_melhoria INT FOREIGN KEY,
	id_jogador INT FOREIGN KEY,
	adquirido_em DATE,
	FOREIGN KEY (id_tipo_melhoria) REFERENCES tipo_melhoria (id_tipo_melhoria),
	FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador)
);

CREATE TABLE itens(
	cod_item INT PRIMARY KEY,
	id_tipo_produto INT FOREIGN KEY,
	id_jogador INT FOREIGN KEY,
	posicao_inventario INT,
	esta_em_destaque VARCHAR(1) CHECK (esta_em_destaque IN ('s', 'n')),
	obtido_em DATE,
	FOREIGN KEY (id_tipo_produto) REFERENCES tipo_produto (id_tipo_produto),
	FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador)
);