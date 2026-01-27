-- Quantidade de diabéticos por sexo
SELECT 
    d.dmg_sex,
    COUNT(*) AS qtd_diabeticos
FROM dw.fat_sau f
JOIN dw.dim_dmg d ON d.dmg_srk = f.dmg_srk
WHERE f.fat_sau = 'Diabetes'
GROUP BY d.dmg_sex;


-- Diabéticos por faixa etária
SELECT 
    d.dmg_ida AS faixa_etaria,
    COUNT(*) AS qtd_diabeticos
FROM dw.fat_sau f
JOIN dw.dim_dmg d ON d.dmg_srk = f.dmg_srk
WHERE f.fat_sau = 'Diabetes'
GROUP BY d.dmg_ida
ORDER BY qtd_diabeticos DESC;


-- IMC médio dos diabéticos
SELECT 
    ROUND(AVG(f.fat_imc), 2) AS imc_medio_diabeticos
FROM dw.fat_sau f
WHERE f.fat_sau = 'Diabetes';


-- Atividade física entre diabéticos
SELECT 
    e.est_fis AS pratica_atividade_fisica,
    COUNT(*) AS qtd_diabeticos
FROM dw.fat_sau f
JOIN dw.dim_est e ON e.est_srk = f.est_srk
WHERE f.fat_sau = 'Diabetes'
GROUP BY e.est_fis;


-- Hipertensão em diabéticos
SELECT 
    c.cli_pre AS possui_hipertensao,
    COUNT(*) AS qtd_diabeticos
FROM dw.fat_sau f
JOIN dw.dim_cli c ON c.cli_srk = f.cli_srk
WHERE f.fat_sau = 'Diabetes'
GROUP BY c.cli_pre;


-- Consumo de álcool entre diabéticos
SELECT 
    e.est_alc AS consumo_alcool,
    COUNT(*) AS qtd_diabeticos
FROM dw.fat_sau f
JOIN dw.dim_est e ON e.est_srk = f.est_srk
WHERE f.fat_sau = 'Diabetes'
GROUP BY e.est_alc;


-- Diabéticos com acesso a plano de saúde
SELECT 
    a.acs_pla AS possui_plano_saude,
    COUNT(*) AS qtd_diabeticos
FROM dw.fat_sau f
JOIN dw.dim_acs a ON a.acs_srk = f.acs_srk
WHERE f.fat_sau = 'Diabetes'
GROUP BY a.acs_pla;


-- CTE – Diabéticos com alto risco de saúde (risco ≥ 3)
WITH diab_alto_risco AS (
    SELECT 
        fat_id
    FROM dw.fat_sau
    WHERE fat_sau = 'Diabetes'
      AND fat_ris >= 3
)
SELECT 
    COUNT(*) AS total_diabeticos_alto_risco
FROM diab_alto_risco;


--CTE – Classificação de IMC em diabéticos
WITH imc_diabetes AS (
    SELECT 
        fat_imc
    FROM dw.fat_sau
    WHERE fat_sau = 'Diabetes'
)
SELECT 
    CASE
        WHEN fat_imc >= 30 THEN 'Obesidade'
        WHEN fat_imc BETWEEN 25 AND 29.9 THEN 'Sobrepeso'
        ELSE 'Normal'
    END AS classificacao_imc,
    COUNT(*) AS total_diabeticos
FROM imc_diabetes
GROUP BY classificacao_imc;


-- CTE – Diabéticos por nível de renda
WITH diab_renda AS (
    SELECT 
        d.dmg_ren
    FROM dw.fat_sau f
    JOIN dw.dim_dmg d ON d.dmg_srk = f.dmg_srk
    WHERE f.fat_sau = 'Diabetes'
)
SELECT 
    dmg_ren AS renda,
    COUNT(*) AS qtd_diabeticos
FROM diab_renda
GROUP BY dmg_ren
ORDER BY dmg_ren;