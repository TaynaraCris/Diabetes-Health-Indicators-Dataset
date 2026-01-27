-- =========================================================
-- DDL - SCHEMA DW (GOLD)
-- =========================================================

CREATE SCHEMA IF NOT EXISTS dw;

-- 1. Dimensão Demografia (dmg)
DROP TABLE IF EXISTS dw.dim_dmg CASCADE;
CREATE TABLE dw.dim_dmg (
    dmg_srk SERIAL PRIMARY KEY,   
    dmg_sex VARCHAR(20),           
    dmg_ida VARCHAR(20),          
    dmg_esc VARCHAR(50),           
    dmg_ren DECIMAL(10,2)          
);

-- 2. Dimensão Estilo de Vida (est)
DROP TABLE IF EXISTS dw.dim_est CASCADE;
CREATE TABLE dw.dim_est (
    est_srk SERIAL PRIMARY KEY,
    est_fum VARCHAR(5),           
    est_fru VARCHAR(5),           
    est_veg VARCHAR(5),           
    est_fis VARCHAR(5),            
    est_alc VARCHAR(5)           
);

-- 3. Dimensão Acesso Médico (acs)
DROP TABLE IF EXISTS dw.dim_acs CASCADE;
CREATE TABLE dw.dim_acs (
    acs_srk SERIAL PRIMARY KEY,
    acs_pla VARCHAR(5),           
    acs_cus VARCHAR(5),            
    acs_col VARCHAR(5)             
);

-- 4. Dimensão Histórico Clínico (cli)
DROP TABLE IF EXISTS dw.dim_cli CASCADE;
CREATE TABLE dw.dim_cli (
    cli_srk SERIAL PRIMARY KEY,
    cli_pre VARCHAR(5),            
    cli_col VARCHAR(5),            
    cli_avc VARCHAR(5),           
    cli_cor VARCHAR(5),           
    cli_and VARCHAR(5)           
);

-- 5. Tabela Fato Saúde (fat)
DROP TABLE IF EXISTS dw.fat_sau CASCADE;
CREATE TABLE dw.fat_sau (
    fat_id SERIAL PRIMARY KEY,
    dmg_srk INTEGER REFERENCES dw.dim_dmg(dmg_srk),
    est_srk INTEGER REFERENCES dw.dim_est(est_srk),
    acs_srk INTEGER REFERENCES dw.dim_acs(acs_srk),
    cli_srk INTEGER REFERENCES dw.dim_cli(cli_srk),
    fat_dia VARCHAR(20),          
    fat_imc DECIMAL(5,2),          
    fat_sau VARCHAR(20),           
    fat_men INTEGER,               
    fat_fis INTEGER,               
    fat_ris INTEGER,               
    fat_dat TIMESTAMP DEFAULT NOW() 
);