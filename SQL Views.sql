/*
a) A partir da tabela DimProduct, crie uma View contendo as informações de 
ProductName, ColorName, UnitPrice e UnitCost, da tabela DimProduct. Chame essa View 
de vwProdutos. 

b) A partir da tabela DimEmployee, crie uma View mostrando FirstName, BirthDate, 
DepartmentName. Chame essa View de vwFuncionarios. 

c) A partir da tabela DimStore, crie uma View mostrando StoreKey, StoreName e 
OpenDate. Chame essa View de vwLojas. 
*/
--A
GO
CREATE VIEW vwProduct AS
SELECT 
	ProductName,
	ColorName,
	UnitPrice,
	UnitCost
FROM 
	DimProduct
GO

SELECT * FROM vwProduct

--B
GO
CREATE VIEW vwFuncionarios AS
SELECT
	FirstName,
	BirthDate,
	DepartmentName
FROM
	DimEmployee
GO
SELECT * FROM vwFuncionarios

--C
GO
CREATE VIEW vwLojas AS
SELECT
	StoreKey,
	StoreName,
	OpenDate
FROM
	DimStore
GO
SELECT * FROM vwLojas



/*
Crie uma View contendo as informações de Nome Completo (FirstName + 
LastName), Gênero (por extenso), E-mail e Renda Anual (formatada com R$). 
Utilize a tabela DimCustomer. Chame essa View de vwClientes.
*/
GO
CREATE VIEW vwClientes AS
SELECT
	FirstName + ' ' + LastName AS 'Nome Completo',
	CASE
		WHEN Gender = 'F' THEN 'Feminino'
		WHEN Gender = 'M' THEN 'Masculino'
	END AS 'Gender',
	EmailAddress,
	'R$' + CAST(YearlyIncome AS varchar) AS 'Renda Anual'
FROM
	DimCustomer
GO
SELECT * FROM vwClientes



/*
a) A partir da tabela DimStore, crie uma View que considera apenas as lojas ativas. Faça 
um SELECT de todas as colunas. Chame essa View de vwLojasAtivas. 

b) A partir da tabela DimEmployee, crie uma View de uma tabela que considera apenas os 
funcionários da área de Marketing. Faça um SELECT das colunas: FirstName, EmailAddress 
e DepartmentName. Chame essa de vwFuncionariosMkt. 

c) Crie uma View de uma tabela que considera apenas os produtos das marcas Contoso e 
Litware. Além disso, a sua View deve considerar apenas os produtos de cor Silver. Faça 
um SELECT de todas as colunas da tabela DimProduct. Chame essa View de 
vwContosoLitwareSilver.
*/
--A
GO
CREATE VIEW vwLojasAtivas AS
SELECT 
	*
FROM 
	DimStore
WHERE Status = 'On'
GO

--B
GO
CREATE VIEW vwFuncionariosMkt AS
SELECT
	FirstName,
	EmailAddress,
	DepartmentName
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing'
GO

--C
GO
CREATE VIEW vwContosoLitwareSilver AS
SELECT
	*
FROM
	DimProduct
WHERE (BrandName = 'Contoso' OR BrandName = 'Litware') AND ColorName = 'Silver'  
GO



/*
Crie uma View que seja o resultado de um agrupamento da tabela FactSales. Este 
agrupamento deve considerar o SalesQuantity (Quantidade Total Vendida) por Nome do 
Produto. Chame esta View de vwTotalVendidoProdutos. 

OBS: Para isso, você terá que utilizar um JOIN para relacionar as tabelas FactSales e 
DimProduct.
*/
GO
CREATE VIEW vwTotalVendidoProdutos AS
SELECT
	DimProduct.ProductName,
	SUM(SalesQuantity) AS 'QTD. VENDIDO'
FROM
FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ProductName
GO

SELECT * FROM vwTotalVendidoProdutos



/*
Faça as seguintes alterações nas tabelas da questão 1. 

a. Na View criada na letra a da questão 1, adicione a coluna de BrandName. 

b. Na View criada na letra b da questão 1, faça um filtro e considere apenas os 
funcionários do sexo feminino. 

c. Na View criada na letra c da questão 1, faça uma alteração e filtre apenas as lojas 
ativas. 
*/

--A
GO
ALTER VIEW vwProduct AS
SELECT 
	ProductName,
	ColorName,
	UnitPrice,
	UnitCost,
	BrandName
FROM 
	DimProduct
GO
SELECT * FROM vwProduct


--B
GO
ALTER VIEW vwFuncionarios AS
SELECT
	FirstName,
	BirthDate,
	DepartmentName,
	Gender,
	Status
FROM
	DimEmployee
WHERE Gender = 'F'
GO
SELECT * FROM vwFuncionarios


--C
GO
ALTER VIEW vwLojas AS
SELECT
	StoreKey,
	StoreName,
	OpenDate,
	Status
FROM
	DimStore
WHERE Status = 'On'
GO
SELECT * FROM vwLojas



/*
a) Crie uma View que seja o resultado de um agrupamento da tabela DimProduct. O 
resultado esperado da consulta deverá ser o total de produtos por marca. Chame essa 
View de vw_6a.

b) Altere a View criada no exercício anterior, adicionando o peso total por marca. Atenção: 
sua View final deverá ter então 3 colunas: Nome da Marca, Total de Produtos e Peso Total. 

c) Exclua a View vw_6a.
*/

--A
GO
CREATE VIEW vw_6a AS
SELECT
	BrandName,
	COUNT(ProductKey) AS 'Total de produtos por marca'
FROM
	DimProduct
GROUP BY BrandName
GO

--B
GO
ALTER VIEW vw_6a AS
SELECT
	BrandName,
	SUM(ProductKey) AS 'Total de produtos por marca',
	SUM(Weight) AS 'Peso total'
FROM
	DimProduct
GROUP BY BrandName
GO
SELECT * FROM vw_6a

--C
DROP VIEW vw_6a
