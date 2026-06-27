


select *
from layoffs;

create table layoffs_staging
like layoffs;


select *
from layoffs_staging;

insert layoffs_staging 
select *
from layoffs;



select *,
row_number() over (partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging 
;

with duplicate_cte as 
( 
select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,funds_raised_millions) as row_num
from layoffs_staging)

select *
 from duplicate_cte
 where row_num>1;
 
 
select *
from layoffs_staging
where company='casper';



with duplicate_cte as 
( 
select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,funds_raised_millions) as row_num
from layoffs_staging)

delete 
 from duplicate_cte
 where row_num>1;
 
 
 CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 
 
 SELECT *
 FROM LAYOFFS_STAGING2
 WHERE ROW_NUM >1;
 
 
 INSERT INTO LAYOFFS_STAGING2
SELECT *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,funds_raised_millions) as row_num
from layoffs_staging;
 
 
  DELETE
 FROM LAYOFFS_STAGING2
 WHERE ROW_NUM >1;
 
SELECT *
 FROM LAYOFFS_STAGING2
 WHERE ROW_NUM >1;
 
 
 -- STANDARDIZING DATA
 
 SELECT COMPANY ,TRIM(COMPANY)
 FROM layoffs_staging2;
 
 
 UPDATE LAYOFFS_STAGING2
 SET COMPANY=TRIM(COMPANY);
 
 
 SELECT *
 FROM layoffs_staging2 
 WHERE 
 INDUSTRY LIKE 'CRYPTO%';
 
 
 UPDATE LAYOFFS_STAGING2
 SET INDUSTRY='CRYPTO'
 WHERE INDUSTRY LIKE 'CRYPTO%';
 
 SELECT*
 FROM layoffs_staging2 
WHERE 
COUNTRY LIKE 'UNITED STATES%';

SELECT DISTINCT COUNTRY, TRIM(TRAILING '.' FROM COUNTRY)
FROM LAYOFFS_STAGING2
ORDER BY 1;
 
 UPDATE LAYOFFS_STAGING2
 SET COUNTRY = TRIM(TRAILING '.' FROM COUNTRY)
 WHERE COUNTRY LIKE 'UNITED STATES%';
 
 SELECT `DATE`
 FROM layoffs_staging2;
 
 update layoffs_staging2
 set `date`=str_to_date(`DATE`, '%m/%d/%Y');
 
 
 alter table layoffs_staging2
 modify column `date` DATE;
 
 
 select *
 from layoffs_staging2
 where total_laid_off is null 
 and percentage_laid_off is null ;
 
 update layoffs_staging2 
 set industry=null
 where industry= '';
 
 
 
 select *
 from layoffs_staging2
 where industry is null 
 or industry = '';
 
 
 select *
 from layoffs_staging2 
 where company = 'airbnb';
 
 select *
 from layoffs_staging2 t1
 join layoffs_staging2 t2
 on t1.company=t2.company 
  where (t1.industry is null or t1.industry ='')
  and t2.industry is not null ;
 
 update layoffs_staging2 t1
 join layoffs_staging2 t2
 on t1.company=t2.company
 set t1.industry= t2.industry
 where (t1.industry is null or t1.industry ='')
  and t2.industry is not null ;
 
 
 select*
 from layoffs_staging2;
 
 
 
 
  select *
 from layoffs_staging2
 where total_laid_off is null 
 and percentage_laid_off is null ;
 
 
 
 delete 
from layoffs_staging2
 where total_laid_off is null 
 and percentage_laid_off is null ;
 
 
 alter table layoffs_staging2
 drop column row_num;
 
 
 select *
 from layoffs_staging2;