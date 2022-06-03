SELECT * FROM [PortfolioProject].[dbo].[Nashvillehousing]

SELECT CONVERT(date,SaleDate)
FROM [PortfolioProject].[dbo].[Nashvillehousing]

UPDATE [PortfolioProject].[dbo].[Nashvillehousing]
SET SaleDate = CONVERT(date,SaleDate)

/*The above method didnt work*/

ALTER TABLE [PortfolioProject].[dbo].[Nashvillehousing]
ADD SaleDateConverted Date;

UPDATE [PortfolioProject].[dbo].[Nashvillehousing]
SET SaleDateConverted = CONVERT(Date,Saledate)



SELECT SaleDate
FROM [PortfolioProject].[dbo].[Nashvillehousing]

SELECT SaleDateConverted FROM [PortfolioProject].[dbo].[Nashvillehousing]

SELECT PropertyAddress
FROM [PortfolioProject].[dbo].[Nashvillehousing]
WHERE PropertyAddress is null

SELECT PropertyAddress
FROM [PortfolioProject].[dbo].[Nashvillehousing]
--WHERE PropertyAddress is null
order by ParcelID

SELECT a.ParcelID , a.PropertyAddress , b.ParcelID , b.PropertyAddress , ISNULL(a.PropertyAddress , b.PropertyAddress )
FROM [PortfolioProject].[dbo].[Nashvillehousing] AS a
JOIN [PortfolioProject].[dbo].[Nashvillehousing] AS b
	ON a.ParcelID = b.ParcelID
WHERE a.PropertyAddress is NULL

UPDATE a
SET a.PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [PortfolioProject].[dbo].[Nashvillehousing] AS a
JOIN [PortfolioProject].[dbo].[Nashvillehousing] AS b
	ON a.ParcelID = b.ParcelID
WHERE a.PropertyAddress is NULL AND a.[UniqueID ] <> b.[UniqueID ]

SELECT PropertyAddress FROM [PortfolioProject].[dbo].[Nashvillehousing]

SELECT SUBSTRING(PropertyAddress , 1 , CHARINDEX(',' , PropertyAddress)-1) as Address,SUBSTRING(PropertyAddress , CHARINDEX(',' , PropertyAddress)+1 , len(PropertyAddress)) as CITY
FROM [PortfolioProject].[dbo].[Nashvillehousing]

ALTER TABLE [PortfolioProject].[dbo].[Nashvillehousing]
Add PropertySplitAddress Nvarchar(255);
GO
Update [PortfolioProject].[dbo].[Nashvillehousing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress , 1 , CHARINDEX(',' , PropertyAddress)-1)


ALTER TABLE [PortfolioProject].[dbo].[Nashvillehousing]
Add PropertySplitCity Nvarchar(255);
GO
Update [PortfolioProject].[dbo].[Nashvillehousing]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) 


SELECT * FROM [PortfolioProject].[dbo].[Nashvillehousing]

select PARSENAME(replace(OwnerAddress , ',' , '.') , 3) , PARSENAME(replace(OwnerAddress , ',' , '.') , 2) , PARSENAME(replace(OwnerAddress , ',' , '.') , 1)
from [PortfolioProject].[dbo].[Nashvillehousing]

alter table [PortfolioProject].[dbo].[Nashvillehousing]
add OwnerSplitAddress Nvarchar(255)
go
update [PortfolioProject].[dbo].[Nashvillehousing]
set OwnerSplitAddress = PARSENAME(replace(OwnerAddress , ',' , '.') , 3)

alter table [PortfolioProject].[dbo].[Nashvillehousing]
add OwnerSplitCity Nvarchar(255)
go
update [PortfolioProject].[dbo].[Nashvillehousing]
set OwnerSplitCity = PARSENAME(replace(OwnerAddress , ',' , '.') , 2)

alter table [PortfolioProject].[dbo].[Nashvillehousing]
add OwnerSplitState Nvarchar(255)
go
update [PortfolioProject].[dbo].[Nashvillehousing]
set OwnerSplitState = PARSENAME(replace(OwnerAddress , ',' , '.') , 1)

SELECT * FROM [PortfolioProject].[dbo].[Nashvillehousing]

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From [PortfolioProject].[dbo].[Nashvillehousing]
Group by SoldAsVacant
order by 2

Select SoldAsVacant , case when SoldAsVacant = 'Y' then 'Yes' when SoldAsVacant = 'N' then 'No' else SoldAsVacant end
FROM [PortfolioProject].[dbo].[Nashvillehousing]


Update [PortfolioProject].[dbo].[Nashvillehousing]
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From [PortfolioProject].[dbo].[Nashvillehousing]
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress


WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From [PortfolioProject].[dbo].[Nashvillehousing]
--order by ParcelID
)
DELETE
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress



Select *
From [PortfolioProject].[dbo].[Nashvillehousing]

ALTER TABLE [PortfolioProject].[dbo].[Nashvillehousing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

