-- Data cleaning com SQL

-- Selecionando todos os dados
SELECT *
FROM Portfolio_Project_SQL.dbo.NeshvilleHousing$

-- Padronizar o formato da data
SELECT SaleDate, CONVERT(Date, SaleDate)
FROM Portfolio_Project_SQL.dbo.NeshvilleHousing$

--Adicionando uma nova coluna a tabela
ALTER TABLE NeshvilleHousing$
Add SaleDateConverted Date;

-- Alterando o valor dessa coluna com o valor de Saledate
Update NeshvilleHousing$
SET SaleDateConverted = CONVERT(Date, SaleDate)

--Visualizando a nova coluna 
SELECT SaleDateConverted
FROM Portfolio_Project_SQL.dbo.NeshvilleHousing$
------------------------------------------------------------------------

-- Preencher dados de endereço de propriedade

SELECT PropertyAddress
FROM Portfolio_Project_SQL.dbo.NeshvilleHousing$
WHERE PropertyAddress IS NULL

-- Temos 29 valoress nulos. O que sabemos é que ParcelID iguais tem o mesmo endereço.
-- Então vamos descobrir se esses valores null tem algum "irmão ParcelID"
-- Caso tenha, podemos usar o mesmo endereço para preencher esses valores vazios

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress) --ISNULL Substitui o valor nulo de a pelo de b
FROM Portfolio_Project_SQL.dbo.NeshvilleHousing$ as a -- Realizando uma auto-junção
JOIN Portfolio_Project_SQL.dbo.NeshvilleHousing$ as b
	ON a.ParcelID = b.ParcelID 
	AND a.[UniqueID ] <> b.[UniqueID ] --  Aqui dizemos que não queremos obter a mesma linha, ou seja, não haverá repet~ições.

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Portfolio_Project_SQL.dbo.NeshvilleHousing$ as a 
JOIN Portfolio_Project_SQL.dbo.NeshvilleHousing$ as b
	ON a.ParcelID = b.ParcelID 
	AND a.[UniqueID ] <> b.[UniqueID ]

--------------------------------------------------------------------------------------------------------------
-- Dividindo o endereço do imóvel em colunas individuais (Address, City, State)
--Basicamente o endereço e cidade está separado por vírgula. O estado não é informado.

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address, -- (-1) faz a (,) não aparecer
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS City --(+1) faz a (,) não aparecer
FROM Portfolio_Project_SQL.dbo.NeshvilleHousing$

--
ALTER TABLE NeshvilleHousing$
Add Address Nvarchar(255);

Update NeshvilleHousing$
SET Address = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)
--
--
ALTER TABLE NeshvilleHousing$
Add City Nvarchar(100);

Update NeshvilleHousing$
SET City = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))
--
 -- Dividindo o endereço do proprietário do imóvel em colunas individuais (Address, City, State)
 SELECT 
 PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
 PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
 PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)--usar essa função analisa nomes so é util com pontos.
 FROM Portfolio_Project_SQL.dbo.NeshvilleHousing$

-- 1 coluna
ALTER TABLE NeshvilleHousing$
Add AddressOwner Nvarchar(255);

Update NeshvilleHousing$
SET AddressOwner = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

--2 coluna
ALTER TABLE NeshvilleHousing$
Add CityOwner Nvarchar(255);

Update NeshvilleHousing$
SET CityOwner = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

--3 coluna
ALTER TABLE NeshvilleHousing$
Add StateOwner Nvarchar(255);

Update NeshvilleHousing$
SET StateOwner = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

------------------------------------------------------------------

-- Alterar Y e N para Yes e No no campo "Sold as Vacant" 

-- Identificando valores
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM Portfolio_Project_SQL.dbo.NeshvilleHousing$
GROUP BY SoldAsVacant

-- Realizando a transformação
SELECT SoldAsVacant,
	CASE WHEN SoldAsVacant = 'N' THEN 'No'
	     WHEN SoldAsVacant = 'Y' THEN 'Yes'
		 ELSE SoldAsVacant
		 END
FROM Portfolio_Project_SQL.dbo.NeshvilleHousing$

--Inserindo a transformação tabela
Update NeshvilleHousing$
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'N' THEN 'No'
	     WHEN SoldAsVacant = 'Y' THEN 'Yes'
		 ELSE SoldAsVacant
		 END

-----------------------------------------------------------------------

-- Removendo valores duplicados 

-- Identificar valores duplicados
WITH RowNumCTE AS (
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SaleDate,
				 SalePrice,
				 LegalReference
				 ORDER BY 
					UniqueID
					) row_num
FROM Portfolio_Project_SQL.dbo.NeshvilleHousing$
)
DELETE
FROM RowNumCTE
WHERE row_num > 1
-------------------------------------------------------------------------

-- Deletar colunas sem uso

ALTER TABLE Portfolio_Project_SQL.dbo.NeshvilleHousing$
DROP COLUMN PropertyAddress, OwnerAddress, SaleDate, AddressOwner

