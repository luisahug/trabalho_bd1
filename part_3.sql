-- [B]----------------------------------
-- | Gerar uma consulta que envolva uma tabela 
-- +------------------------------------
-- | 
-- | // Insira comentário aqui.
-- | 

    SELECT * FROM jogador;

-- | 
-- +------------------------------------

-- [C]----------------------------------
-- | Gerar uma consulta que envolva duas tabelas 
-- | usando equi-join 
-- +------------------------------------
-- | 
-- | // Relaciona investimentos com gestores que trabalham com o mesmo tipo de investimento.
-- | 

    SELECT investimentos.*, gestor.*
    FROM investimentos, gestor
    WHERE investimentos.id_tipo_inv = gestor.id_tipo_inv;

-- | 
-- +------------------------------------


-- [D]----------------------------------
-- | Gerar uma consulta que envolva duas tabelas 
-- | usando inner-join 
-- +------------------------------------
-- | 
-- | // Exibe os itens dos usuários e as informações de cada tipo de item
-- | 

    SELECT itens.*, tipo_item.*
    FROM itens
    INNER JOIN tipo_item
    USING itens.id_tipo_item = tipo_item.id_tipo_item;

-- | 
-- +------------------------------------


-- [E]----------------------------------
-- | Gerar uma consulta que envolva três tabelas 
-- | usando equi-join 
-- +------------------------------------
-- | 
-- | // Insira comentário aqui.
-- | 

-- Código SQL aqui

-- | 
-- +------------------------------------


-- [F]----------------------------------
-- | Gerar uma consulta que envolva três tabelas 
-- | usando inner-join 
-- +------------------------------------
-- | 
-- | // Exibe as contratações com os nomes do jogador e gestor envolvidos.
-- | 

    SELECT cg.id_contratacao, j.nome AS 'jogador', g.nome AS 'gestor', cg.contratado_em
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
-- | // Insira comentário aqui.
-- | 

-- Código SQL aqui

-- | 
-- +------------------------------------


-- [H]----------------------------------
-- | Implementar uma consulta usando NULL ou NOT 
-- | NULL, envolvendo no mínimo 2 tabelas 
-- +------------------------------------
-- | 
-- | // Exibe os investimentos que já foram coletados ao menos uma vez, e que já
--      renderam mais que rendimento por ciclo
-- | 

    SELECT inv.*, ti.nome AS 'tipo investimento', ti.rendimento_ciclo
    FROM investimentos inv
    INNER JOIN tipo_investimento ti ON inv.id_tipo_investimento = ti.id_tipo_investimento
    WHERE inv.ultima_coleta_em IS NOT NULL AND inv.rendimento_atual > ti.rendimento_ciclo;

-- | 
-- +------------------------------------


-- [I]----------------------------------
-- | Implementar uma consulta usando a cláusula like 
-- | e o argumento %, envolvendo no mínimo 
-- | 2tabelas 
-- +------------------------------------
-- | 
-- | // Exibe os investimentos feitos pelo jogador com id '3' no mês de jan/2024
-- | 

    SELECT inv.* 
    WHERE investimentos inv 
    INNER JOIN jogador j ON inv.id_jogador = j.id_jogador
    WHERE inv.id_jogador = 3 AND inv.obtido_em LIKE '2024-01-%';

-- | 
-- +------------------------------------


-- [J]----------------------------------
-- | Implementar uma consulta usando a cláusula like 
-- | e o argumento _, envolvendo no mínimo 
-- | 2tabelas 
-- +------------------------------------
-- | 
-- | // Insira comentário aqui.
-- | 

-- Código SQL aqui

-- | 
-- +------------------------------------


-- [K]----------------------------------
-- | Implementar uma consulta com subconsulta, usando a 
-- | cláusula IN, envolvendo no mínimo 2tabelas 
-- +------------------------------------
-- | 
-- | // Insira comentário aqui.
-- | 

-- Código SQL aqui

-- | 
-- +------------------------------------


-- [L]----------------------------------
-- | Implementar uma consulta com subconsulta, usando a 
-- | cláusula ANY ou ALL, envolvendo nomínimo 2 
-- | tabelas 
-- +------------------------------------
-- | 
-- | // Insira comentário aqui.
-- | 

-- Código SQL aqui

-- | 
-- +------------------------------------


-- [M]----------------------------------
-- | Implementar uma consulta com subconsulta, usando a 
-- | cláusula EXISTS, envolvendo no mínimo 2tabelas 
-- +------------------------------------
-- | 
-- | // Insira comentário aqui.
-- | 

-- Código SQL aqui

-- | 
-- +------------------------------------


-- [N]----------------------------------
-- | Implementar uma consulta usando a cláusula UNION, 
-- | envolvendo no mínimo 2 tabelas 
-- +------------------------------------
-- | 
-- | // Insira comentário aqui.
-- | 

-- Código SQL aqui

-- | 
-- +------------------------------------


-- [O]----------------------------------
-- | Implementar uma consulta usando a cláusula GROUP 
-- | BY e pelo menos uma função agregada,envolvendo 
-- | no mínimo 2 tabelas 
-- +------------------------------------
-- | 
-- | // Insira comentário aqui.
-- | 

-- Código SQL aqui

-- | 
-- +------------------------------------


-- [P]----------------------------------
-- | Implementar uma consulta usando a cláusula GROUP 
-- | BY e HAVING, envolvendo no mínimo 2tabelas 
-- +------------------------------------
-- | 
-- | // Insira comentário aqui.
-- | 

-- Código SQL aqui

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
-- | Atualiza os dados de um investimento de id 2
-- | 

    UPDATE investimentos
    SET nivel_atual = 3,
        preco_atual = 234002.45,
        ultimo_ciclo_iniciou_em = CURRENT_TIMESTAMP
    WHERE id_inv = 2;

-- | 
-- +------------------------------------


-- [S]----------------------------------
-- | Implementar uma consulta usando a cláusula DROP 
-- +------------------------------------
-- | 
-- | // Insira comentário aqui.
-- | 

    --primeiro remover coluna que usa a PK da tabela do drop como FK
    ALTER TABLE tipo_melhoria
    DELETE COLUMN id_atributo_melhorado; 

    DROP atributos_melhoraveis;

-- | 
-- +------------------------------------


-- [T]----------------------------------
-- | Implementar uma visão que inclua no mínimo 
-- | 3 tabelas 
-- +------------------------------------
-- | 
-- | // Insira comentário aqui.
-- | 

-- Código SQL aqui

-- | 
-- +------------------------------------


