SET search_path = trabalho;

-- [A]----------------------------------
-- | Desenvolver um script que insira no 
-- | mínimo 5 registros em cada uma das tabelas;
-- +------------------------------------
-- |
-- | Insere 5 jogadores.
-- |

INSERT INTO jogador (nome, email) 
VALUES 
    ( 'Juninho Gamer' , 'jg@gmail.com'),
    ( 'Bruninho Gamer', 'bg@gmail.com'),
    ( 'Moacir Gomes'  , 'mg@gmail.com'),
    ( 'Jogador 1'     , 'p1@gmail.com'),
    ( 'Jogador 2'     , 'p2@gmail.com');

-- |
-- +------------------------------------


-- +------------------------------------
-- |
-- | Insere 5 tipos de investimentos.
-- |

INSERT INTO tipo_investimento 
    ( nome, valor_aquisicao, rendimento_ciclo, tempo_ciclo_sec, gr_rendimento, gr_preco )
VALUES 
    ( 'Carrinho de Picolé',     100,     10,  5,  10.0,  50.00 ), -- A primeira ação de um jogador deverá ser comprar o investimento incial.
    ( 'Lavagem de carro'  ,    1000,    300, 10,  30.0, 100.00 ),
    ( 'Mercado'           ,   10000,   1000, 15,  80.0, 150.00 ),
    ( 'Shopping'          ,   50000,  10000, 30, 190.0, 200.00 ),
    ( 'Banco'             , 1000000, 500000, 60,  50.0,  50.00 );

-- |
-- +------------------------------------


-- +------------------------------------
-- |
-- | Insere 5 gestores ( um para cada investimento ).
-- |

INSERT INTO gestor 
    ( nome, id_tipo_inv, custo_aquisicao, comissao_venda )
VALUES 
    ( 'Felipe do Picolé',     1,    1000,  5 ),
    ( 'Serginho Lava-rápido', 2,   30000, 10),
    ( 'Carlos Mercado'      , 3,   90000, 15),
    ( 'Adagoberto Bida'     , 4,  100000, 10),
    ( 'João dos Bancos'     , 5, 5000000,  5);

-- |
-- +------------------------------------


-- +------------------------------------
-- |
-- | Insere os 5 atributos melhoraveis possíveis.
-- |

INSERT INTO atributos_melhoraveis(nome)
VALUES 
    ('Preço'), 
    ('Rendimento Atual'), 
    ('Taxa de Crescimento do Preço'), 
    ('Taxa de Crescimento do Rendimento'),
    ('Tempo do Ciclo');

-- |
-- +------------------------------------


-- +------------------------------------
-- |
-- | Insere 5 tipos de melhoria para o carrinho de picolé
-- |

INSERT INTO tipo_melhoria ( id_tipo_inv, nome, descr, id_atributo_melhorado, taxa_alteracao, custo )
VALUES 
    ( 1, 'Desconto nos picolés!', '10% de desconto no preço de evolução.',      1, 10.0,  1000), 
    ( 1, 'Os picolés rendem mais!', '10% de aumento no rendimento dos picolés', 2, 10.0,  2000), 
    ( 1, 'Eficiência na produção!', 'Redução de 10% no preço/nível.',           3, 10.0,  5000), 
    ( 1, 'Eficiência na distribuição!', 'Aumento de 10% o rendimento/nível.',   4, 10.0, 10000),
    ( 1, 'Monpólio dos picolés!', 'Reduz em 50% o tempo do ciclo de coleta.',   5, 50.0, 99999);

-- |
-- +------------------------------------


-- +------------------------------------
-- |
-- | Insere investimentos para alguns jogadores
-- |

INSERT INTO investimentos ( id_jogador, id_tipo_inv )
VALUES 
    -- Todos os investimentos serão de nível 1
    (5, 1),
    (5, 2),
    (5, 3),
    (5, 4),
    (5, 5),

    (4, 1),
    (4, 2);

-- Atualiza a ultima coleta dos necessaŕios para demonstração.
UPDATE investimentos SET ultima_coleta_em = CURRENT_TIMESTAMP
WHERE id_inv IN (1,2,6,7);
    
-- |
-- +------------------------------------

-- +------------------------------------
-- |
-- | Insere rendimentos para alguns investimentos. 
-- |

INSERT INTO rendimentos (id_inv, valor_obtido, nivel_inv, ciclo_concluido_em, coletado_em )
VALUES 
    ( 1,    10, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP ),
    ( 1,    10, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP ),
    ( 1,    10, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP ),
    ( 2,   100, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP ),
    ( 3,  1000, 1, CURRENT_TIMESTAMP, NULL ),
    ( 4, 10000, 1, CURRENT_TIMESTAMP, NULL ),
    ( 5, 50000, 1, CURRENT_TIMESTAMP, NULL ),

    ( 6,  10, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP ),
    ( 7, 100, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
    

-- |
-- +------------------------------------


-- +------------------------------------
-- |
-- | Insere 5 contratos com gestor
-- |

INSERT INTO contratacao_gestor (id_jogador, id_gestor)
VALUES 
    ( 5, 1 ), 
    ( 5, 2 ),
    ( 5, 3 ),
    
    ( 4, 1 ),
    ( 4, 2 );

-- |
-- +------------------------------------


-- +------------------------------------
-- |
-- | Insere 5 melhorias
-- |

INSERT INTO melhorias (id_tipo_melhoria, id_jogador)
VALUES 
    ( 1, 5 ), 
    ( 2, 5 ),
    ( 3, 5 ),
    ( 4, 5 ),
    ( 5, 5 );

-- |
-- +------------------------------------


-- +------------------------------------
-- |
-- | Insere 5 tipos de itens compraveis
-- |

INSERT INTO tipo_item (nome, preco_aquisicao, quant_vendas)
VALUES 
    ( 'Estatueta de Cobre',       10000, 2),    
    ( 'Estatueta de Bronze',     100000, 2),    
    ( 'Estatueta de Prata',     1000000, 1),    
    ( 'Estatueta de Ouro',     10000000, 0),    
    ( 'Estatueta de Platina', 100000000, 0);

-- |
-- +------------------------------------

 
-- +------------------------------------
-- |
-- | Insere 5 itens comprados por jogadores
-- |

INSERT INTO itens (id_tipo_item, id_jogador, posicao_inventario)
VALUES 
    (1, 4, 0),
    (1, 4, 1),
    (2, 5, 0),
    (2, 5, 1),
    (3, 5, 2);
-- |
-- +------------------------------------


