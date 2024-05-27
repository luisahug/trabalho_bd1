-- Requisiçãso schema ser chamado trabalho.
CREATE SCHEMA trabalho;
SET search_path = trabalho;

-- ALTERAÇÕES SIGNIFICANTES

-- Todas as PKs foram convertidas INT -> SERIAL (é o tipo com AUTO INCREMENT no PG);
-- Todas as variaveis de data foram convertidas pra TIMESTAMP;
-- Alguns atributos foram passados de DOUBLE PRECISION -> DECIMAL(X,Y)
--   |: X digitos antes do ponto, Y digitos depois :| 
--   Outros foram convertidos pra REAL (float normal do pg).
--   // 
--   DOUBLE PRECISION aumenta o numero de casas decimais só; 
--   Precisamos de numero grandes na maioria das vezes.


CREATE TABLE jogador(
	id_jogador SERIAL PRIMARY KEY,
	nome VARCHAR(30),
	email VARCHAR(30),
	criado_em TIMESTAMP,

	saldo DECIMAL(50, 2) -- O jogo é baseado em ter muito dinheiro, precisamos de muito espaço nesse campo;
);

CREATE TABLE tipo_investimento (
	id_tipo_investimento SERIAL PRIMARY KEY,
	nome VARCHAR(30),

	valor_aquisicao REAL,
	rendimento_ciclo REAL, -- Valor base

	tempo_ciclo_sec SMALLINT, -- tempo do ciclo em segundos. Pode ser pequeno.
	gr_rendimento REAL,       -- growth rate rendimento; float - 100% -> dobra de valor a cada nível  
	gr_preco REAL             -- growth rate do preço; flaot - 100% -> dobra o preço a cada nível
);

CREATE TABLE gestor(
	id_gestor SERIAL PRIMARY KEY,
	id_tipo_inv INT,

	nome VARCHAR(30),
	custo_aquisicao DECIMAL(10, 2), -- Grande mas não tão grande;

	comissao_venda REAL,-- seria porcentagem em decimal?
		-- Pro nosso caso sim; representa melhor a ideia que queremos.

	CONSTRAINT fk_tipo_investimento 
		FOREIGN KEY (id_tipo_inv) REFERENCES tipo_investimento (id_tipo_investimento)
 );
 

-- Essa tabela vai fugir à regra dos três campos com tipos diferentes...
-- Teríamos que pensar em alguma coisa a mais pra pôr aqui (criado_em...)
CREATE TABLE atributos_melhoraveis (
	id_atributo SERIAL PRIMARY KEY,
	-- O nome é meramente ilustrativo.
	nome VARCHAR(20) -- GROWTH_RATE, PRICE_GROWTH_RATE, CYCLE_TIME ... 
);

CREATE TABLE tipo_melhoria(
 	id_tipo_melhoria SERIAL PRIMARY KEY,
	id_tipo_inv INT,
	nome VARCHAR(30),
	descr VARCHAR(200), -- "desc" é palavra reservada 

	id_atributo_melhorado INT,
	taxa_alteracao REAL, -- Essa nunca vai ser um numero grande, nem com muitas casas decimais;
	-- Ex.: 
	--	[
	--		taxa_alteracao: -10.0;
	--		id_atri...    : 2 (PRICE_GROWTH_RATE); 
	--	] ; A taxa de crescimento de preço reduzirá em 10%; 90% -> 81%;

	CONSTRAINT fk_tipo_investimento 
		FOREIGN KEY (id_tipo_inv) REFERENCES tipo_investimento (id_tipo_investimento),
	CONSTRAINT fk_tipo_atributo
		FOREIGN KEY (id_atributo_melhorado) REFERENCES atributos_melhoraveis (id_atributo)
);


CREATE TABLE investimentos(
	id_inv SERIAL PRIMARY KEY,
	id_jogador INT,
	id_tipo_inv INT,

	nivel_atual INT,

	obtido_em TIMESTAMP,
	ultima_coleta_em TIMESTAMP,
	ultimo_ciclo_iniciou_em TIMESTAMP,

	CONSTRAINT fk_id_jogador
		FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador),
	CONSTRAINT fk_id_investimento
		FOREIGN KEY (id_tipo_inv) REFERENCES tipo_investimento (id_tipo_investimento)
);

CREATE TABLE rendimentos(
	id_rendimento SERIAL PRIMARY KEY,
	id_inv INT,

	valor_obtido DECIMAL(20, 2), -- Pode ser gigante em algum ponto do jogo

	nivel_inv INT,

	ciclo_concluido_em TIMESTAMP,
	coletado_em TIMESTAMP,

	CONSTRAINT fk_id_investimento 
	FOREIGN KEY (id_inv) REFERENCES investimentos (id_inv)
);

CREATE TABLE contratacao_gestor(
	id_contratacao SERIAL PRIMARY KEY,
	id_jogador INT,
	id_gestor INT,
	contratado_em TIMESTAMP,

	CONSTRAINT fk_id_jogador
		FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador),
	CONSTRAINT fk_id_gestor
		FOREIGN KEY (id_gestor) REFERENCES gestor (id_gestor)
);

CREATE TABLE melhorias(
	id_melhoria SERIAL PRIMARY KEY,
	id_tipo_melhoria INT,
	id_jogador INT,
	adquirido_em TIMESTAMP,

	CONSTRAINT fk_id_tipo_melhoria
		FOREIGN KEY (id_tipo_melhoria) REFERENCES tipo_melhoria (id_tipo_melhoria),
	CONSTRAINT fk_id_jogador
		FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador)
);


CREATE TABLE tipo_item(
	id_tipo_item SERIAL PRIMARY KEY,
	nome VARCHAR(30),
	preco_aquisicao DECIMAL(50, 2), -- Esperemos que os itens aumentarão radicalmamente de preço
	quant_vendas INT
);

CREATE TABLE itens(
	cod_item SERIAL PRIMARY KEY,
	id_tipo_item INT,
	id_jogador INT,
	posicao_inventario INT,

	esta_em_destaque VARCHAR(1) CHECK (esta_em_destaque IN ('s', 'n')),
	-- Não vou mexer nessa pq ta muito elegante;
	-- Mas poderia ser só um BOOLEAN; 

	obtido_em TIMESTAMP,

	CONSTRAINT fk_tipo_item 
		FOREIGN KEY (id_tipo_item) REFERENCES tipo_item (id_tipo_item),
	CONSTRAINT fk_id_jogador
		FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador)
);