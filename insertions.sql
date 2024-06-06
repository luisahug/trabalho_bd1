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

INSERT INTO tipo_investimento 
    ( nome, valor_aquisicao, rendimento_ciclo, tempo_ciclo_sec, gr_rendimento, gr_preco REAL )
VALUES 
    ( "Carrinho de Picolé", 0, 10, 10, 10.0, 50.00 ), -- Todo jogador deve possuir o "investimento inicial".
    -- ...
