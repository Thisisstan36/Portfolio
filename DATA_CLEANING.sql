SELECT * from portfolioproject..NashVIlleHousing

--standardize date format

SELECT SaleDate, CONVERT(Date, SaleDate) AS SaleDateConverted
from portfolioproject..NashVIlleHousing


--Populate property address

SELECT *
From portfolioproject..NashVIlleHousing
--where PropertyAddress is NULL'
Order by ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from portfolioproject..NashVIlleHousing a
JOIN portfolioproject..NashVIlleHousing b 
	on a.ParcelID=b.ParcelID
	AND a.[UniqueID ]<>b.[UniqueID ]
WHERE a.PropertyAddress is NULL


UPDATE a 
SET a.PropertyAddress= ISNULL(a.PropertyAddress, b.PropertyAddress)
from portfolioproject..NashVIlleHousing a
JOIN portfolioproject..NashVIlleHousing b 
	on a.ParcelID=b.ParcelID
	AND a.[UniqueID ]<>b.[UniqueID ]
WHERE a.PropertyAddress is NULL

select * 
from portfolioproject..NashVIlleHousing


--Breaking down address in different columns


--Where PropertyAddress is null
--order by ParcelID


----

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From PortfolioProject.dbo.NashvilleHousing


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
Add PropertySplitOfAddress Nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousing
SET PropertySplitOfAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

Select *
From PortfolioProject.dbo.NashvilleHousing







select OwnerAddress
from portfolioproject..NashVIlleHousing





---parse name is used to sparate the values by the period. 
--The parsename onl work the period ie '.', to separate the values we need to replace the ',' with the '.'. 

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From PortfolioProject.dbo.NashvilleHousing



ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

SELECT *
from portfolioproject..NashVIlleHousing

 
--replace Y with Yes and N with No 

SELECT DISTINCT (SoldAsVacant), COUNT(SoldAsVacant)
FROM portfolioproject..NashVIlleHousing
GROUP BY SoldAsVacant
ORder BY SoldAsVacant

SELECT SoldAsVacant,
CASE when SoldAsVacant= 'Y' then 'Yes'
	when SoldAsVacant= 'N' then 'No'
	ELSE SoldAsVacant
	END
FROM portfolioproject..NashVIlleHousing



UPDATE portfolioproject..NashVIlleHousing
	SET SoldAsVacant= CASE when SoldAsVacant= 'Y' then 'Yes'
	when SoldAsVacant= 'N' then 'No'
	ELSE SoldAsVacant
	END


------Remove Duplicate

				LegalReference,


WITH ROWNUMCTE AS(
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
from portfolioproject..NashVIlleHousing


