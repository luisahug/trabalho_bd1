-- [A]----------------------------------
-- | Desenvolver um script que insira no 
-- | mínimo 5 registros em cada uma das tabelas;
-- +------------------------------------
-- |
-- | Insere 5 jogadores.
-- |

INSERT INTO jogador (nome, email, saldo, criado_em) 
VALUES 
    ( "Juninho Gamer" , "jg@gmail.com"),
    ( "Bruninho Gamer", "bg@gmail.com"),
    ( "Moacir Gomes"  , "mg@gmail.com"),
    ( "Lan - PC #1"   , "l1@gmail.com"),
    ( "Lan - PC #2"   , "l2@gmail.com");

-- |
-- +------------------------------------


-- +------------------------------------
-- |
-- | Insere 5 tipos de investimentos.
-- |

INSERT INTO tipo_investimento 
    ( nome, valor_aquisicao, rendimento_ciclo, tempo_ciclo_sec, gr_rendimento, gr_preco )
VALUES 
    ( "Carrinho de Picolé",     100,     10,  5,  10.0,  50.00 ), -- A primeira ação de um jogador deverá ser comprar o investimento incial.
    ( "Lavagem de carro"  ,    1000,    300, 10,  30.0, 100.00 ),
    ( "Mercado"           ,   10000,   1000, 15,  80.0, 150.00 ),
    ( "Shopping"          ,   50000,  10000, 30, 190.0, 200.00 ),
    ( "Banco"             , 1000000, 500000, 60,  50.0,  50.00 ),

-- |
-- +------------------------------------

