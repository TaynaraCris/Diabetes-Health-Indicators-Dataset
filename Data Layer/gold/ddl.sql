-- =========================================================
-- DDL - SCHEMA DW (GOLD)
-- Padrão Mnemônico: 3 letras (ex: dmg_sexo, est_fumo)
-- =========================================================

CREATE SCHEMA IF NOT EXISTS dw;

-- 1. Dimensão Demografia (dmg)
DROP TABLE IF EXISTS dw.dim_demografia CASCADE;
CREATE TABLE dw.dim_demografia (
    dmg_srk SERIAL PRIMARY KEY,    -- Chave Surrogate
    dmg_sex VARCHAR(20),           -- Sexo
    dmg_ida VARCHAR(20),           -- Idade (Faixa)
    dmg_esc VARCHAR(50),           -- Escolaridade
    dmg_ren DECIMAL(10,2)          -- Renda
);

-- 2. Dimensão Estilo de Vida (est)
DROP TABLE IF EXISTS dw.dim_estilo_vida CASCADE;
CREATE TABLE dw.dim_estilo_vida (
    est_srk SERIAL PRIMARY KEY,
    est_fum VARCHAR(5),            -- Fumante
    est_fru VARCHAR(5),            -- Frutas
    est_veg VARCHAR(5),            -- Vegetais
    est_fis VARCHAR(5),            -- Atividade Física
    est_alc VARCHAR(5)             -- Álcool
);

-- 3. Dimensão Acesso Médico (acs)
DROP TABLE IF EXISTS dw.dim_acesso_medico CASCADE;
CREATE TABLE dw.dim_acesso_medico (
    acs_srk SERIAL PRIMARY KEY,
    acs_pla VARCHAR(5),            -- Plano de Saúde
    acs_cus VARCHAR(5),            -- Custo (evitou médico?)
    acs_col VARCHAR(5)             -- Checkup Colesterol
);

-- 4. Dimensão Histórico Clínico (cli)
DROP TABLE IF EXISTS dw.dim_historico_clinico CASCADE;
CREATE TABLE dw.dim_historico_clinico (
    cli_srk SERIAL PRIMARY KEY,
    cli_pre VARCHAR(5),            -- Pressão Alta
    cli_col VARCHAR(5),            -- Colesterol Alto
    cli_avc VARCHAR(5),            -- AVC / Stroke
    cli_cor VARCHAR(5),            -- Coração
    cli_and VARCHAR(5)             -- Dificuldade Andar
);

-- 5. Tabela Fato Saúde (fat)
DROP TABLE IF EXISTS dw.fat_saude_pessoa CASCADE;
CREATE TABLE dw.fat_saude_pessoa (
    fat_id SERIAL PRIMARY KEY,
    -- Chaves Estrangeiras (Ligam às dimensões)
    dmg_srk INTEGER REFERENCES dw.dim_demografia(dmg_srk),
    est_srk INTEGER REFERENCES dw.dim_estilo_vida(est_srk),
    acs_srk INTEGER REFERENCES dw.dim_acesso_medico(acs_srk),
    cli_srk INTEGER REFERENCES dw.dim_historico_clinico(cli_srk),
    -- Métricas
    fat_dia VARCHAR(20),           -- Diabetes Status
    fat_imc DECIMAL(5,2),          -- IMC Valor
    fat_sau VARCHAR(20),           -- Saúde Geral
    fat_men INTEGER,               -- Dias Saúde Mental Ruim
    fat_fis INTEGER,               -- Dias Saúde Física Ruim
    fat_ris INTEGER,               -- Risco Total (Score)
    fat_dat TIMESTAMP DEFAULT NOW() -- Data Carga
);