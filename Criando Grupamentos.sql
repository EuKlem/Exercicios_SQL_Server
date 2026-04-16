/*
FACTSALES
1. a) Faça um resumo da quantidade vendida (SalesQuantity) de acordo com o canal de vendas
(channelkey).
b) Faça um agrupamento mostrando a quantidade total vendida (SalesQuantity) e quantidade
total devolvida (Return Quantity) de acordo com o ID das lojas (StoreKey).
c) Faça um resumo do valor total vendido (SalesAmount) para cada canal de venda, mas apenas
para o ano de 2007.
*/

--A
SELECT * FROM FactSales

SELECT
	ChannelKey,
	SUM(SalesQuantity) AS 'Total vendido'
FROM
	FactSales
GROUP BY channelKey

--B
SELECT
	StoreKey,
	SUM(SalesQuantity) AS 'Quantidade Vendida',
	SUM(ReturnQuantity) AS 'Quantidade Devolvida'
FROM
	FactSales
GROUP BY StoreKey

--C

SELECT
	ChannelKey,
	SUM(SalesAmount) AS 'Valor total vendido'
FROM
	FactSales
WHERE DateKey >= '2007-01-01' and DateKey <= '2007-12-31'
GROUP BY channelKey



/*
Você precisa fazer uma análise de vendas por produtos. O objetivo final é descobrir o valor
total vendido (SalesAmount) por produto (ProductKey).
a) A tabela final deverá estar ordenada de acordo com a quantidade vendida e, além disso,
mostrar apenas os produtos que tiveram um resultado final de vendas maior do que
$5.000.000.
b) Faça uma adaptação no exercício anterior e mostre os Top 10 produtos com mais vendas.
Desconsidere o filtro de $5.000.000 aplicado.
*/

SELECT * FROM FactOnlineSales

SELECT
	ProductKey AS 'ID do Produto',
	SUM(SalesAmount) AS 'Compras Realizadas'
FROM
	FactOnlineSales
GROUP BY ProductKey
ORDER BY SUM(SalesAmount) DESC

/*
a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o ID
(CustomerKey) do cliente que mais realizou compras online (de acordo com a coluna
SalesQuantity).

b) Feito isso, faça um agrupamento de total vendido (SalesQuantity) por ID do produto
e descubra quais foram os top 3 produtos mais comprados pelo cliente da letra a).
*/

Select * FROM DimProduct

SELECT TOP (3)
	ProductKey,
	SUM(SalesQuantity) AS 'Compras Realizadas'
FROM
	FactOnlineSales
GROUP BY ProductKey
ORDER BY SUM(SalesQuantity) DESC

  

/*
4. a) Faça um agrupamento e descubra a quantidade total de produtos por marca.
b) Determine a média do preço unitário (UnitPrice) para cada ClassName.
c) Faça um agrupamento de cores e descubra o peso total que cada cor de produto possui.
*/

SELECT * FROM DimProduct
---------------------
SELECT
	BrandName,
	COUNT(ProductName) AS 'Quantidade de produtos'
FROM
	DimProduct
GROUP BY BrandName
----------------
SELECT
	ClassName,
	AVG(UnitPrice)
FROM
	DimProduct
GROUP BY ClassName
--------------------
SELECT
	ColorName,
	Sum(Weight)
FROM
	DimProduct
GROUP BY ColorName

  

/*
Você deverá descobrir o peso total para cada tipo de produto (StockTypeName).
A tabela final deve considerar apenas a marca ‘Contoso’ e ter os seus valores classificados em
ordem decrescente.
*/

SELECT * FROM DimProduct

SELECT
	StockTypeName,
	SUM(Weight) AS 'Peso total'
FROM
	DimProduct
WHERE BrandName = 'Contoso'
GROUP BY StockTypeName
ORDER BY SUM(Weight) DESC


  
/*
Você seria capaz de confirmar se todas as marcas dos produtos possuem à disposição todas as
16 opções de cores?
*/

SELECT * FROM DimProduct

SELECT 
	BrandName,
	Count(DISTINCT ColorName)
FROM
	DimProduct
GROUP BY BrandName


  
/*
Faça um agrupamento para saber o total de clientes de acordo com o Sexo e também a média
salarial de acordo com o Sexo. Corrija qualquer resultado “inesperado” com os seus
conhecimentos em SQL
*/

SELECT * FROM DimCustomer

SELECT
	Gender,
	Count(CustomerKey) AS 'Total de Clientes',
	AVG(YearlyIncome) AS 'Média Salarial'
FROM
	DimCustomer
WHERE GENDER IS NOT NULL
GROUP BY Gender


  
/*
Faça um agrupamento para descobrir a quantidade total de clientes e a média salarial de
acordo com o seu nível escolar. Utilize a coluna Education da tabela DimCustomer para fazer
esse agrupamento.
*/

SELECT * FROM DimCustomer

SELECT 
	Education,
	Count(CustomerKey) AS 'Total de Clientes',
	AVG(YearlyIncome) AS 'Média Salarial'
FROM 
	DimCustomer
WHERE Education IS NOT NULL
GROUP BY Education


  
/*
Faça uma tabela resumo mostrando a quantidade total de funcionários de acordo com o
Departamento (DepartmentName). Importante: Você deverá considerar apenas os
funcionários ativos.
*/

SELECT * FROM DimEmployee

SELECT 
	DepartmentName,
	Count(EmployeeKey) AS 'Total de Funcionários'
FROM 
	DimEmployee
WHERE Status = 'Current'
GROUP BY DepartmentName


  
/*
Faça uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). Você
deve considerar apenas as mulheres, dos departamentos de Production, Marketing,
Engineering e Finance, para os funcionários contratados entre os anos de 1999 e 2000.
*/

SELECT * FROM DimEmployee

SELECT 
	Title,
	SUM(VacationHours)
FROM
	DimEmployee
WHERE 
	Gender = 'F' and DepartmentName in ('Production','Marketing','Engineerin','Finance') and 
	HireDate BETWEEN '1999-01-01' and '2000-12-31' 
GROUP BY Title
