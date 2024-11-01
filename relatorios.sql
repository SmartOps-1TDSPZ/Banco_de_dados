-- Relatório utilizando classificação de dados
    --Relatório 1: Listagem de clientes por data de nascimento
        SELECT id_clientes, nm_cliente, nr_cpf, dt_nascimento 
        FROM T_CLIENTE
        ORDER BY dt_nascimento ASC;
    
    --Relatório 2: Listagem de carros por marca e modelo
    SELECT id_carro, nm_marca, nm_modelo, ano_fabricacao 
    FROM T_CARRO
    ORDER BY nm_marca ASC, nm_modelo ASC;

-- Relatório utilizando alguma função do tipo numérica simples
    --Relatório 1: Média de peças usadas nos orçamentos     
    SELECT id_orcamento, vl_total, ct_pecas, tx_servico, ROUND(vl_total / ct_pecas, 2) AS media_valor_por_peca 
    FROM T_ORCAMENTO
    WHERE ct_pecas > 0;

    --Relatório 2:Diferença entre o ano de fabricação do carro e o ano atual
    SELECT id_carro, nm_marca, nm_modelo, ano_fabricacao, 
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM ano_fabricacao) AS idade_carro
    FROM T_CARRO;

-- Relatório utilizando alguma função de grupo
    --Relatório 1: Contagem de carros por tipo de veículo
    SELECT tp_veiculo, COUNT(id_carro) AS total_carros
    FROM T_CARRO
    GROUP BY tp_veiculo
    ORDER BY total_carros DESC;

    --Relatório 2: Quantidade de clientes por estado
    SELECT nm_estado, COUNT(id_clientes) AS total_clientes
    FROM T_ENDERECO
    GROUP BY nm_estado
    ORDER BY total_clientes DESC;

-- Relatório utilizando sub consulta
    --Relatório 1: Clientes com mais de um carro cadastrado
    SELECT id_clientes, nm_cliente
    FROM T_CLIENTE
    WHERE id_clientes IN (
        SELECT id_clientes
        FROM T_CARRO
        GROUP BY id_clientes
        HAVING COUNT(id_carro) > 1
    );

    --Relatório 2: Orçamentos acima da média geral de valor
    SELECT id_orcamento, vl_total
    FROM T_ORCAMENTO
    WHERE vl_total > (SELECT AVG(vl_total) FROM T_ORCAMENTO);


-- Relatório utilizando junção de tabelas
    --Relatório 1: Informações dos clientes e seus respectivos carros
    SELECT c.id_clientes, c.nm_cliente, cr.id_carro, cr.nm_marca, cr.nm_modelo
    FROM T_CLIENTE c
    JOIN T_CARRO cr ON c.id_clientes = cr.id_clientes
    ORDER BY c.nm_cliente;

    --Relatório 2: Orçamentos com detalhamento do carro e cliente
    SELECT o.id_orcamento, o.vl_total, o.dt_orcamento, cr.nm_modelo, c.nm_cliente
    FROM T_ORCAMENTO o
    JOIN T_CARRO cr ON o.id_carro = cr.id_carro
    JOIN T_CLIENTE c ON cr.id_clientes = c.id_clientes
    ORDER BY o.dt_orcamento DESC;
