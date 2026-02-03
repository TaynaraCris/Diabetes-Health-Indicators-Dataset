-- ==================================================================
-- consultas.sql 
-- ==================================================================

-- 1. Quantidade de diabéticos por sexo
SELECT 
    d.sex,
    COUNT(*) AS qtd_diabeticos
FROM dw.fat_sau f
JOIN dw.dim_dmg d ON d.srk = f.dmg  
WHERE f.dia = 'Diabetes'
GROUP BY d.sex;

-- 2. Diabéticos por faixa etária
SELECT 
    d.ida AS faixa_etaria,
    COUNT(*) AS qtd_diabeticos
FROM dw.fat_sau f
JOIN dw.dim_dmg d ON d.srk = f.dmg
WHERE f.dia = 'Diabetes'
GROUP BY d.ida
ORDER BY qtd_diabeticos DESC;

-- 3. IMC médio dos diabéticos
SELECT 
    ROUND(AVG(f.imc), 2) AS imc_medio_diabeticos
FROM dw.fat_sau f
WHERE f.dia = 'Diabetes';

-- 4. Atividade física entre diabéticos
SELECT 
    e.fis AS pratica_atividade_fisica,
    COUNT(*) AS qtd_diabeticos
FROM dw.fat_sau f
JOIN dw.dim_est e ON e.srk = f.est
WHERE f.dia = 'Diabetes'
GROUP BY e.fis;

-- 5. Hipertensão em diabéticos
SELECT 
    c.pre AS possui_hipertensao,
    COUNT(*) AS qtd_diabeticos
FROM dw.fat_sau f
JOIN dw.dim_cli c ON c.srk = f.cli
WHERE f.dia = 'Diabetes'
GROUP BY c.pre;

-- 6. Consumo de álcool entre diabéticos
SELECT 
    e.alc AS consumo_alcool,
    COUNT(*) AS qtd_diabeticos
FROM dw.fat_sau f
JOIN dw.dim_est e ON e.srk = f.est
WHERE f.dia = 'Diabetes'
GROUP BY e.alc;

-- 7. Diabéticos com acesso a plano de saúde
SELECT 
    a.pla AS possui_plano_saude,
    COUNT(*) AS qtd_diabeticos
FROM dw.fat_sau f
JOIN dw.dim_acs a ON a.srk = f.acs
WHERE f.dia = 'Diabetes'
GROUP BY a.pla;

-- 8. CTE – Diabéticos com alto risco de saúde (risco >= 3)
WITH diab_alto_risco AS (
    SELECT id
    FROM dw.fat_sau
    WHERE dia = 'Diabetes'
      AND ris >= 3
)
SELECT COUNT(*) AS total_diabeticos_alto_risco FROM diab_alto_risco;

-- 9. CTE – Classificação de IMC em diabéticos
WITH imc_diabetes AS (
    SELECT imc
    FROM dw.fat_sau
    WHERE dia = 'Diabetes'
)
SELECT 
    CASE 
        WHEN imc >= 30 THEN 'Obesidade'
        WHEN imc BETWEEN 25 AND 29.9 THEN 'Sobrepeso'
        ELSE 'Normal' 
    END AS classificacao_imc,
    COUNT(*) AS total_diabeticos
FROM imc_diabetes
GROUP BY classificacao_imc;

-- 10. CTE – Diabéticos por nível de renda
WITH diab_renda AS (
    SELECT d.ren
    FROM dw.fat_sau f
    JOIN dw.dim_dmg d ON d.srk = f.dmg
    WHERE f.dia = 'Diabetes'
)
SELECT 
    ren AS renda,
    COUNT(*) AS qtd_diabeticos
FROM diab_renda
GROUP BY ren
ORDER BY ren;