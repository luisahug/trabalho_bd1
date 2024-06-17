DROP SCHEMA IF EXISTS trabalho CASCADE;

CREATE SCHEMA trabalho;
SET search_path = trabalho;

CREATE TABLE jogador(
	id_jogador SERIAL PRIMARY KEY,

	nome VARCHAR(30),
	email VARCHAR(30),

	saldo DECIMAL(50, 2)     DEFAULT 100.00, -- Todo jogador deve começar com este valor.

	criado_em TIMESTAMP      DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tipo_investimento (
	id_tipo_investimento SERIAL PRIMARY KEY,
	nome VARCHAR(40),

	valor_aquisicao REAL,
	
    rendimento_ciclo REAL, 
	tempo_ciclo_sec SMALLINT, 

	gr_rendimento REAL,       
	gr_preco REAL            
);

CREATE TABLE gestor(
	id_gestor SERIAL PRIMARY KEY,
	id_tipo_inv INT,

	nome VARCHAR(30),
	custo_aquisicao DECIMAL(10, 2), 

	comissao_venda REAL,

	CONSTRAINT fk_tipo_investimento 
		FOREIGN KEY (id_tipo_inv) REFERENCES tipo_investimento (id_tipo_investimento)
        ON DELETE CASCADE
 );
 

CREATE TABLE atributos_melhoraveis (
	id_atributo SERIAL PRIMARY KEY,
	nome VARCHAR(40) 
);

CREATE TABLE tipo_melhoria(
 	id_tipo_melhoria SERIAL PRIMARY KEY,
	id_tipo_inv INT,
	nome VARCHAR(30),
	descr VARCHAR(200), 

	id_atributo_melhorado INT,
	taxa_alteracao REAL, 

    custo DECIMAL(20, 2),

	CONSTRAINT fk_tipo_investimento 
		FOREIGN KEY (id_tipo_inv) REFERENCES tipo_investimento (id_tipo_investimento)
        ON DELETE CASCADE,
	CONSTRAINT fk_tipo_atributo
		FOREIGN KEY (id_atributo_melhorado) REFERENCES atributos_melhoraveis (id_atributo)
        ON DELETE CASCADE
);


CREATE TABLE investimentos(
	id_inv SERIAL PRIMARY KEY,
	id_jogador INT,
	id_tipo_inv INT,

	nivel_atual INT DEFAULT 1,

    -- Atributos adicionais
    preco_atual       DECIMAL(20, 2),
    rendimento_atual  DECIMAL(20, 2),
    t_ciclo_atual_sec DECIMAL(20,2), -- Deve haver uma conversão
        
	obtido_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	ultima_coleta_em TIMESTAMP,
	ultimo_ciclo_iniciou_em TIMESTAMP,

	CONSTRAINT fk_id_jogador
		FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador) ON DELETE CASCADE,
	CONSTRAINT fk_id_investimento
		FOREIGN KEY (id_tipo_inv) REFERENCES tipo_investimento (id_tipo_investimento) ON DELETE CASCADE
);

-- +-----------------------------
-- | Trigger pra inserir os valores
-- | padrão de acordo com o tipo de
-- | investimento.

CREATE OR REPLACE FUNCTION set_default_investimentos()
RETURNS TRIGGER AS $trig$
DECLARE	 
	ti tipo_investimento%ROWTYPE;
BEGIN
	SELECT * INTO ti from tipo_investimento WHERE id_tipo_investimento = NEW.id_tipo_inv;
 
    IF NEW.preco_atual IS NULL THEN
        NEW.preco_atual := ti.valor_aquisicao * ti.gr_preco;
    END IF;

    IF NEW.rendimento_atual IS NULL THEN
        NEW.rendimento_atual := ti.rendimento_ciclo;
    END IF;

	IF NEW.t_ciclo_atual_sec IS NULL THEN
        NEW.t_ciclo_atual_sec := ti.tempo_ciclo_sec::float;
    END IF;

    RETURN NEW;
END;
$trig$ LANGUAGE plpgsql;

CREATE TRIGGER set_default_investimentos_trig
BEFORE INSERT ON investimentos
FOR EACH ROW
EXECUTE FUNCTION set_default_investimentos();
-- +-------------------------------- 

CREATE TABLE rendimentos(
	id_rendimento SERIAL PRIMARY KEY,
	id_inv INT,

	valor_obtido DECIMAL(20, 2), 

	nivel_inv INT,

	ciclo_concluido_em TIMESTAMP,
	coletado_em TIMESTAMP,

	CONSTRAINT fk_id_investimento 
        FOREIGN KEY (id_inv) REFERENCES investimentos (id_inv) ON DELETE CASCADE
);

CREATE TABLE contratacao_gestor(
	id_contratacao SERIAL PRIMARY KEY,
	id_jogador INT,
	id_gestor INT,
	contratado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT fk_id_jogador
		FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador) ON DELETE CASCADE,
	CONSTRAINT fk_id_gestor
		FOREIGN KEY (id_gestor) REFERENCES gestor (id_gestor) ON DELETE CASCADE
);

CREATE TABLE melhorias(
	id_melhoria SERIAL PRIMARY KEY,
	id_tipo_melhoria INT,
	id_jogador INT,

	adquirido_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT fk_id_tipo_melhoria
		FOREIGN KEY (id_tipo_melhoria) REFERENCES tipo_melhoria (id_tipo_melhoria) ON DELETE CASCADE,
	CONSTRAINT fk_id_jogador
		FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador) ON DELETE CASCADE
);


CREATE TABLE tipo_item(
	id_tipo_item SERIAL PRIMARY KEY,
	nome VARCHAR(30),
	preco_aquisicao DECIMAL(50, 2), 
	quant_vendas INT
);

CREATE TABLE itens(
	cod_item SERIAL PRIMARY KEY,
	id_tipo_item INT,
	id_jogador INT,
	posicao_inventario INT,

	esta_em_destaque CHAR(1) CHECK (esta_em_destaque IN ('s', 'n')) DEFAULT 'n',

	obtido_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT fk_tipo_item 
		FOREIGN KEY (id_tipo_item) REFERENCES tipo_item (id_tipo_item) ON DELETE CASCADE,
	CONSTRAINT fk_id_jogador
		FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador) ON DELETE CASCADE
);


