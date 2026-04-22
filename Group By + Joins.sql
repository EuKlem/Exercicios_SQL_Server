/*
a) Faça um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do canal
de vendas (ChannelName). Você deve ordenar a tabela final de acordo com SalesQuantity,
em ordem decrescente.
b) Faça um agrupamento mostrando a quantidade total vendida (Sales Quantity) e
quantidade total devolvida (Return Quantity) de acordo com o nome das lojas
(StoreName).
c) Faça um resumo do valor total vendido (Sales Amount) para cada mês
(CalendarMonthLabel) e ano (CalendarYear).
*/

--A
SELECT TOP (100) * FROM FactSales
SELECT * FROM DimChannel

SELECT 
	SUM(SalesQuantity) AS 'Quantidade Total Vendida',
	DimChannel.ChannelName
FROM
	FactSales
INNER JOIN DimChannel
	ON FactSales.channelKey = DimChannel.ChannelKey
GROUP BY ChannelName
ORDER BY SUM(SalesQuantity) DESC


--B
SELECT * FROM DimStore
SELECT TOP (100) * FROM FactSales

SELECT
	SUM(SalesQuantity) AS 'Quantidade Total Vendida',
	SUM(ReturnQuantity) AS 'Quantidade Total Devolvida',
	DimStore.StoreName
FROM
	 FactSales
INNER JOIN DimStore
	ON FactSales.StoreKey = DimStore.StoreKey
GROUP BY StoreName


--C
SELECT TOP (100) * FROM FactSales
SELECT * FROM DimDate

SELECT 
	TOP (100)
	SUM(SalesQuantity) AS 'Quantidade Total Vendida',
	DimDate.CalendarMonthLabel,
	DimDate.CalendarYear
FROM
	FactSales
INNER JOIN DimDate
	ON Factsales.DateKey = DimDate.Datekey
GROUP BY CalendarMonthLabel, CalendarYear



/*
 Você precisa fazer uma análise de vendas por produtos. O objetivo final é descobrir o valor
total vendido (SalesQuantity) por produto.
a) Descubra qual é a cor de produto que mais é vendida (de acordo com SalesQuantity).
b) Quantas cores tiveram uma quantidade vendida acima de 3.000.000.
*/


SELECT TOP (100) * FROM FactSales
SELECT * FROM DimProduct

SELECT
	SUM(SalesQuantity) AS 'Quantidade Total Vendida',
	DimProduct.ProductName
FROM
	FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ProductName

--A
SELECT
	SUM(SalesQuantity) AS 'Quantidade Total Vendida',
	DimProduct.ColorName,
	DimProduct.ProductName
FROM
	FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY Productname, ColorName
ORDER BY SUM(SalesQuantity) DESC


--B
SELECT
	SUM(SalesQuantity) AS 'Quantidade Total Vendida',
	DimProduct.ColorName
FROM
	FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ColorName
HAVING SUM(SalesQuantity) >= 3000000
ORDER BY SUM(SalesQuantity) DESC



/*
Crie um agrupamento de quantidade vendida (SalesQuantity) por categoria do produto
(ProductCategoryName). Obs: Você precisará fazer mais de 1 INNER JOIN, dado que a relação
entre FactSales e DimProductCategory não é direta.
*/

SELECT TOP (100) * FROM FactSales
SELECT * FROM DimProductCategory
SELECT * FROM DimProductSubcategory


SELECT TOP (100)
	SUM(SalesQuantity) as 'QTD. Vendida',
	DimProductCategory.ProductCategoryName
FROM
	FactSales
INNER JOIN DimProduct
	on FactSales.ProductKey = DimProduct.ProductKey
		INNER JOIN DimProductSubcategory
			on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
				INNER JOIN DimProductCategory
					on DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
GROUP BY ProductCategoryName



/*
a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o nome completo
do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity).

b) Feito isso, faça um agrupamento de produtos e descubra quais foram os top 10 produtos mais
comprados pelo cliente da letra a, considerando o nome do produto.
*/


--A
SELECT TOP (100) * FROM FactOnlineSales
SELECT * FROM DimCustomer

SELECT
	TOP (10)
	DimCustomer.CustomerKey,
	DimCustomer.FirstName,
	DimCustomer.LastName,
	SUM(SalesQuantity) as 'QTD. Vendida'
FROM
	FactOnlineSales
INNER JOIN DimCustomer
	ON DimCustomer.CustomerKey = FactOnlineSales.CustomerKey
WHERE CustomerType = 'Person'
GROUP BY FirstName, LastName, DimCustomer.CustomerKey
ORDER BY SUM(SalesQuantity) DESC



--B
SELECT
	TOP (10)
	ProductName AS 'Produto',
	SUM(SalesQuantity) AS 'Qtd.Vendida'
FROM FactOnlineSales
	INNER JOIN DimProduct
		on FactOnlineSales.ProductKey = DimProduct.ProductKey
WHERE CustomerKey = 7665
GROUP BY ProductName
ORDER BY SUM(SalesQuantity) DESC



/*
Faça um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o
sexo dos clientes.
*/

SELECT
	Gender AS 'Sexo',
	SUM(SalesQuantity) as 'QTD. Vendido'
FROM 
	FactOnlineSales
INNER JOIN DimCustomer
	ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE Gender IS NOT NULL
GROUP BY Gender



/*
Faça uma tabela resumo mostrando a taxa de câmbio média de acordo com cada
CurrencyDescription. A tabela final deve conter apenas taxas entre 10 e 100.
*/

SELECT TOP (100) * FROM FactExchangeRate
SELECT * FROM DimCurrency

SELECT
	CurrencyDescription,
	AVG(AverageRate) AS 'Taxa Média'
FROM
	FactExchangeRate
INNER JOIN DimCurrency
	ON FactExchangeRate.CurrencyKey = DimCurrency.CurrencyKey
GROUP BY CurrencyDescription
HAVING AVG(AverageRate) BETWEEN 10 AND 100



/*
Calcule a SOMA TOTAL de AMOUNT referente à tabela FactStrategyPlan destinado aos
cenários: Actual e Budget.
Dica: A tabela DimScenario será importante para esse exercício.
*/

SELECT TOP (1000) * FROM FactStrategyPlan
SELECT * FROM DimScenario

SELECT 
	ScenarioName,
	SUM(AMOUNT) AS 'Total'
FROM
	FactStrategyPlan
INNER JOIN DimScenario
	ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
GROUP BY ScenarioName
HAVING ScenarioName <> 'Forecast'



/*
Faça uma tabela resumo mostrando o resultado do planejamento estratégico por ano.
*/

SELECT TOP (1000) * FROM FactStrategyPlan
SELECT * FROM DimDate

SELECT 
	CalendarYear AS 'Ano',
	SUM(Amount) AS 'Total'
FROM
	FactStrategyPlan
INNER JOIN DimDate
	ON FactStrategyPlan.Datekey = DimDate.Datekey
GROUP BY CalendarYear



/*
Faça um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em
consideração em sua análise apenas a marca Contoso e a cor Silver.
*/

SELECT
	ProductSubcategoryName AS 'Subcategoria',
	COUNT(*) AS 'QTD. Produtos'
FROM
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE BrandName = 'Contoso' and ColorName = 'Silver'
GROUP BY ProductSubcategoryName



/*
Faça um agrupamento duplo de quantidade de produtos por BrandName e
ProductSubcategoryName. A tabela final deverá ser ordenada de acordo com a coluna
BrandName.
*/

SELECT
	BrandName AS 'Marca',
	ProductSubcategoryName AS 'Subcategoria',
	COUNT (*) AS 'QTD. Produtos'
FROM
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
GROUP BY BrandName, ProductSubcategoryName
ORDER BY BrandName ASC
