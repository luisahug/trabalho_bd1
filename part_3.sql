-- [B]----------------------------------
-- | Gerar uma consulta que envolva uma tabela 
-- +------------------------------------
-- | 
-- | Seleciona todos os jogadores existentes.
-- | 

    SELECT * FROM jogador;

-- | 
-- +------------------------------------

-- [C]----------------------------------
-- | Gerar uma consulta que envolva duas tabelas 
-- | usando equi-join 
-- +------------------------------------
-- | 
-- | Relaciona tipos de investimento com seus
-- | respectivos gestores
-- | 

    SELECT ti.nome, g.nome as gestor
    FROM tipo_investimento ti, gestor g
    WHERE ti.id_tipo_investimento = g.id_tipo_inv;

-- | 
-- +------------------------------------


-- [D]----------------------------------
-- | Gerar uma consulta que envolva duas tabelas 
-- | usando inner-join 
-- +------------------------------------
-- | 
-- | Exibe os itens dos usuários e as informações de cada tipo de item
-- | 

    SELECT itens.*, tipo_item.*
    FROM itens
    INNER JOIN tipo_item
    USING(id_tipo_item);

-- | 
-- +------------------------------------


-- [E]----------------------------------
-- | Gerar uma consulta que envolva três tabelas 
-- | usando equi-join 
-- +------------------------------------
-- | 
-- | Retorna todas os investimentos com infomarções
-- | sobre o tipo e o jogador dono.
-- | 

    SELECT ti.nome, i.obtido_em, j.nome as jogador
    FROM tipo_investimento ti, jogador j, investimentos i
    WHERE 
        (
            ti.id_tipo_investimento = i.id_tipo_inv AND 
            i.id_jogador = j.id_jogador
        )
    ORDER BY j.nome ASC;


-- | 
-- +------------------------------------


-- [F]----------------------------------
-- | Gerar uma consulta que envolva três tabelas 
-- | usando inner-join 
-- +------------------------------------
-- | 
-- | Exibe as contratações com os nomes do jogador e gestor envolvidos.
-- | 

    SELECT cg.id_contratacao, j.nome AS jogador, g.nome AS gestor, cg.contratado_em
    FROM contratacao_gestor cg
    INNER JOIN jogador j ON cg.id_jogador = j.id_jogador
    INNER JOIN gestor g ON cg.id_gestor = g.id_gestor;

-- | 
-- +------------------------------------


-- [G]----------------------------------
-- | Gerar uma consulta que envolva mais de 
-- | três tabelas 
-- +------------------------------------
-- | 
-- | Exibe todos os rendimentos dos investimentos em Mercado de cada jogador
-- | 

    SELECT 
        j.nome AS nome_jogador, 
        ti.nome AS nome_investimento, 
        r.valor_obtido AS valor_rendimento, 
        r.ciclo_concluido_em, 
        r.coletado_em
    FROM rendimentos r 
    INNER JOIN investimentos i ON r.id_inv = i.id_inv
    INNER JOIN tipo_investimento ti ON i.id_tipo_inv = ti.id_tipo_investimento
    INNER JOIN jogador j ON i.id_jogador = j.id_jogador
    WHERE ti.nome = 'Mercado';

-- | 
-- +------------------------------------


-- [H]----------------------------------
-- | Implementar uma consulta usando NULL ou NOT 
-- | NULL, envolvendo no mínimo 2 tabelas 
-- +------------------------------------
-- | 
-- | Exibe os investimentos que já foram coletados ao menos uma vez
-- | 

    SELECT ti.nome AS "tipo investimento", ti.rendimento_ciclo
    FROM investimentos inv
    INNER JOIN tipo_investimento ti ON inv.id_tipo_inv = ti.id_tipo_investimento
    WHERE inv.ultima_coleta_em IS NOT NULL;

-- | 
-- +------------------------------------


-- [I]----------------------------------
-- | Implementar uma consulta usando a cláusula like 
-- | e o argumento %, envolvendo no mínimo 
-- | 2 tabelas 
-- +------------------------------------
-- | 
-- | Exibe os investimentos adquiridos pelo jogador com id '4' 
-- | no mês de jun/2024
-- | 

    SELECT j.nome as jogador, inv.id_inv, inv.obtido_em
    FROM investimentos inv 
    INNER JOIN jogador j ON inv.id_jogador = j.id_jogador
    WHERE inv.id_jogador = 4 AND inv.obtido_em::varchar LIKE '2024-06-%';

-- | 
-- +------------------------------------


-- [J]----------------------------------
-- | Implementar uma consulta usando a cláusula like 
-- | e o argumento _, envolvendo no mínimo 
-- | 2 tabelas 
-- +------------------------------------
-- | 
-- | Exibe os investimentos de todos os jogadores
-- | onde o nome comece com J e tenha mais de 3
-- | caracteres. 
-- | 

    SELECT j.nome, j.email, ti.nome 
    FROM investimentos i
    JOIN jogador j on j.id_jogador = i.id_jogador
    JOIN tipo_investimento ti on ti.id_tipo_investimento = i.id_tipo_inv
    WHERE j.nome LIKE 'J__%';
    -- WHERE i.rendimento_atual::varchar LIKE '1___.__';

-- | 
-- +------------------------------------


-- [K]----------------------------------
-- | Implementar uma consulta com subconsulta, usando a 
-- | cláusula IN, envolvendo no mínimo 2 tabelas 
-- +------------------------------------
-- | 
-- | Retorna todas as melhorias contratadas referentes
-- | ao Carrinho de Picolé
-- | 

    SELECT j.nome as jogador, tm.nome as melhoria, m.adquirido_em
    FROM melhorias m
    JOIN jogador j on m.id_jogador = j.id_jogador
    JOIN tipo_melhoria tm on tm.id_tipo_melhoria = m.id_tipo_melhoria
    WHERE m.id_tipo_melhoria IN (
        SELECT id_tipo_melhoria FROM tipo_melhoria tm WHERE id_tipo_inv = 1
    );

-- | 
-- +------------------------------------


-- [L]----------------------------------
-- | Implementar uma consulta com subconsulta, usando a 
-- | cláusula ANY ou ALL, envolvendo no mínimo 2 
-- | tabelas 
-- +------------------------------------
-- | 
-- | Seleciona o(s) investimento(s) de maior rendimento atual
-- | 

    SELECT ti.nome, i.nivel_atual, i.rendimento_atual, j.nome as jogador
    FROM investimentos i 
    JOIN tipo_investimento ti on ti.id_tipo_investimento = i.id_tipo_inv
    JOIN jogador j on j.id_jogador = i.id_jogador
    WHERE i.rendimento_atual >= ALL (
       SELECT rendimento_atual 
       FROM investimentos 
    );

-- | 
-- +------------------------------------


-- [M]----------------------------------
-- | Implementar uma consulta com subconsulta, usando a 
-- | cláusula EXISTS, envolvendo no mínimo 2 tabelas 
-- +------------------------------------
-- | 
-- | Seleciona os investimentos de que possuem melhorias compradas 
-- | 

    SELECT j.nome as jogador, ti.nome 
    FROM tipo_investimento ti
    JOIN investimentos i on i.id_tipo_inv = ti.id_tipo_investimento
    JOIN jogador j on j.id_jogador = i.id_jogador
    WHERE EXISTS (
        SELECT m.* FROM melhorias m 
        JOIN tipo_melhoria tm on tm.id_tipo_melhoria = m.id_tipo_melhoria
        WHERE tm.id_tipo_inv = i.id_tipo_inv 
    );

-- | 
-- +------------------------------------


-- [N]----------------------------------
-- | Implementar uma consulta usando a cláusula UNION, 
-- | envolvendo no mínimo 2 tabelas 
-- +------------------------------------
-- | 
-- |  
-- | 

    SELECT tipo, nome, COALESCE(quantidade, 0) FROM (
        SELECT 'Investimento' as tipo, ti.nome, x.count as quantidade
        FROM tipo_investimento ti 
        LEFT JOIN (
            SELECT id_tipo_inv, COUNT(id_tipo_inv)
            FROM investimentos
            GROUP BY id_tipo_inv
        ) x on x.id_tipo_inv = ti.id_tipo_investimento 

        UNION

        SELECT 'Melhoria' as tipo, tm.nome, x.count as quantidade
        FROM tipo_melhoria tm 
        LEFT JOIN (
            SELECT id_tipo_melhoria, COUNT(id_tipo_melhoria)
            FROM melhorias
            GROUP BY id_tipo_melhoria
        ) x on x.id_tipo_melhoria = tm.id_tipo_melhoria

        UNION

        SELECT 'Item' as tipo, ti.nome, x.count as quantidade
        FROM tipo_item ti 
        LEFT JOIN (
            SELECT id_tipo_item, COUNT(id_tipo_item)
            FROM itens
            GROUP BY id_tipo_item
        ) x on x.id_tipo_item = ti.id_tipo_item
    )
    ORDER BY tipo;

-- | 
-- +------------------------------------


-- [O]----------------------------------
-- | Implementar uma consulta usando a cláusula GROUP 
-- | BY e pelo menos uma função agregada,envolvendo 
-- | no mínimo 2 tabelas 
-- +------------------------------------
-- | 
-- | Retorna todo o valor ja coletado por tipo de investimento
-- | 

    SELECT ti.nome as investimento, SUM(r.valor_obtido) as total
    FROM rendimentos r 
    JOIN investimentos i on i.id_inv = r.id_inv
    JOIN tipo_investimento ti on ti.id_tipo_investimento = i.id_tipo_inv
    WHERE r.coletado_em IS NOT NULL
    GROUP BY ti.id_tipo_investimento;

-- | 
-- +------------------------------------


-- [P]----------------------------------
-- | Implementar uma consulta usando a cláusula GROUP 
-- | BY e HAVING, envolvendo no mínimo 2 tabelas 
-- +------------------------------------
-- | 
-- | Retorna somente os tipos de investimento que ja geraram
-- | mais de 50 reais. 
-- | 

    SELECT ti.nome as investimento
    FROM rendimentos r 
    JOIN investimentos i on i.id_inv = r.id_inv
    JOIN tipo_investimento ti on ti.id_tipo_investimento = i.id_tipo_inv
    WHERE r.coletado_em IS NOT NULL
    GROUP BY ti.id_tipo_investimento
    HAVING SUM(r.valor_obtido) > 50;

-- | 
-- +------------------------------------


-- [Q]----------------------------------
-- | Implementar uma consulta usando a cláusula DELETE 
-- +------------------------------------
-- | 
-- | Exclui o jogador núm. 5 da tabela de jogadores
-- | 

    DELETE FROM jogador
    WHERE id_jogador = 5;

-- | 
-- +------------------------------------


-- [R]----------------------------------
-- | Implementar uma consulta usando a cláusula UPDATE, 
-- | atualizando mais de dois atributos 
-- +------------------------------------
-- | 
-- | Atualiza o nível de um investimento de id 1
-- | 

    UPDATE investimentos i
    SET 
        nivel_atual = nivel_atual + 1,
        
        -- | Preço atual = 
        -- |    Preço atual * ( 1 + $taxa_de_crescimento_de_preço / 100 ) 
        -- |    Preço atual * ( 1 + 10 / 100 ) 
        -- |    Preço atual * ( 1 + 0.10 )  
        -- |    Preço atual * 1.1
        -- | 

        preco_atual = (
            preco_atual * ( 1 + (SELECT gr_preco from tipo_investimento ti WHERE ti.id_tipo_investimento = i.id_tipo_inv) / 100 )
        ),

        -- | Mesmo processo para o rendimento

        rendimento_atual = (
            rendimento_atual * ( 1 + (SELECT gr_rendimento from tipo_investimento ti WHERE ti.id_tipo_investimento = i.id_tipo_inv) / 100 )
        ),
        ultimo_ciclo_iniciou_em = CURRENT_TIMESTAMP
    WHERE id_inv = 1;

-- | 
-- +------------------------------------


-- [S]----------------------------------
-- | Implementar uma consulta usando a cláusula DROP 
-- +------------------------------------
-- | 
-- | Faz com que o campo atributo melhorado não seja mais
-- | mais necessário.
-- | 

    -- |
    -- | Primeiro remover coluna que é dependente ta tabela a ser removida.
    -- |

    ALTER TABLE tipo_melhoria
    DROP COLUMN id_atributo_melhorado; 

    -- |
    -- | Remove a tabela.
    -- |
    
    DROP atributos_melhoraveis;

-- | 
-- +------------------------------------


-- [T]----------------------------------
-- | Implementar uma visão que inclua no mínimo 
-- | 3 tabelas 
-- +------------------------------------
-- | 
-- | Visão do administrador, reúne diversas informações 
-- | sobre a atividade dos jogadores. 
-- | 

    CREATE VIEW admin AS
    SELECT 
        j.nome, j.email, j.saldo,
        COALESCE(i.count, 0) as investimentos,
        COALESCE(c.count, 0) as gestores,
        COALESCE(m.count, 0) as melhorias,
        COALESCE(it.count, 0) as itens,
        COALESCE(r.count, 0) as total_coletado

    FROM jogador j

    LEFT JOIN (
        SELECT i.id_jogador, COUNT(i.id_jogador) as count
        FROM investimentos i 
        GROUP BY i.id_jogador   
    ) i on i.id_jogador = j.id_jogador

    LEFT JOIN ( 
        SELECT c.id_jogador, COUNT(c.id_jogador) as count
        FROM contratacao_gestor c
        GROUP BY c.id_jogador
    ) c on c.id_jogador = j.id_jogador

    LEFT JOIN ( 
        SELECT c.id_jogador, COUNT(c.id_jogador) as count
        FROM melhorias c
        GROUP BY c.id_jogador
    ) m on m.id_jogador = j.id_jogador

    LEFT JOIN ( 
        SELECT c.id_jogador, COUNT(c.id_jogador) as count
        FROM itens c
        GROUP BY c.id_jogador
    ) it on it.id_jogador = j.id_jogador

    LEFT JOIN (
        SELECT i.id_jogador, SUM( r.valor_obtido ) as count
        FROM rendimentos r
        JOIN investimentos i on i.id_inv = r.id_inv
        WHERE r.coletado_em IS NOT NULL
        GROUP BY i.id_jogador
    ) r on r.id_jogador = j.id_jogador

-- | 
-- +------------------------------------


