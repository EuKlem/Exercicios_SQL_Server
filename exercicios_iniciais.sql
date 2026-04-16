-- ============================================================
-- Exercício 1: Verificação de contagem de registros
-- ============================================================

-- a) Confirmar se existem 2.517 produtos cadastrados
SELECT
    COUNT(*) AS 'Total de Produtos'
FROM
    DimProduct

-- b) Verificar se o total de clientes aumentou ou reduziu em relação a 19.500
SELECT
    COUNT(*) AS 'Total de Clientes'
FROM
    DimCustomer


-- ============================================================
-- Exercício 2: Contato com clientes para ação de aniversário
-- ============================================================

SELECT
    CustomerKey  AS 'ID do Cliente',
    FirstName    AS 'Primeiro Nome',
    EmailAddress AS 'E-mail',
    BirthDate    AS 'Data de Nascimento'
FROM
    DimCustomer


-- ============================================================
-- Exercício 3: Premiação dos primeiros clientes (10 anos Contoso)
-- ============================================================

-- a) Vale de R$10.000 - primeiros 100 clientes (todas as colunas)
SELECT
    TOP (100)
    *
FROM
    DimCustomer

-- b) Vale de R$2.000 - primeiros 20% de clientes (todas as colunas)
SELECT
    TOP (20) PERCENT
    *
FROM
    DimCustomer

-- c) Primeiros 100 clientes - apenas nome, e-mail e nascimento
SELECT
    TOP (100)
    FirstName,
    EmailAddress,
    BirthDate
FROM
    DimCustomer

-- d) Mesmas colunas renomeadas em português
SELECT
    TOP (100)
    FirstName    AS 'Primeiro Nome',
    EmailAddress AS 'E-mail',
    BirthDate    AS 'Data de Nascimento'
FROM
    DimCustomer


-- ============================================================
-- Exercício 4: Identificar fornecedores para reposição de estoque
-- ============================================================

SELECT DISTINCT
    Manufacturer AS 'Fornecedor'
FROM
    DimProduct


-- ============================================================
-- Exercício 5: Verificar se há produtos que nunca foram vendidos
-- ============================================================

SELECT
    COUNT(*) AS 'Produtos sem venda registrada'
FROM
    DimProduct
WHERE
    ProductKey NOT IN (
        SELECT DISTINCT ProductKey
        FROM FactSales
    )
