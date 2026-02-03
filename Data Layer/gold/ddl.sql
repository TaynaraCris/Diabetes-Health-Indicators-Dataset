-- =========================================================
-- DDL - SCHEMA DW (GOLD)
-- =========================================================

CREATE SCHEMA IF NOT EXISTS dw;

-- 1. Dimensão Demografia (dmg)
DROP TABLE IF EXISTS dw.dim_dmg CASCADE;
CREATE TABLE dw.dim_dmg (
    srk SERIAL PRIMARY KEY,        
    sex VARCHAR(20),               
    ida VARCHAR(20),               
    esc VARCHAR(50),               
    ren DECIMAL(10,2)             
);

-- 2. Dimensão Estilo de Vida (est)
DROP TABLE IF EXISTS dw.dim_est CASCADE;
CREATE TABLE dw.dim_est (
    srk SERIAL PRIMARY KEY,        
    fum VARCHAR(5),                
    fru VARCHAR(5),
    veg VARCHAR(5),
    fis VARCHAR(5),
    alc VARCHAR(5)
);

-- 3. Dimensão Acesso Médico (acs)
DROP TABLE IF EXISTS dw.dim_acs CASCADE;
CREATE TABLE dw.dim_acs (
    srk SERIAL PRIMARY KEY,        
    pla VARCHAR(5),                
    cus VARCHAR(5),
    col VARCHAR(5)
);

-- 4. Dimensão Histórico Clínico (cli)
DROP TABLE IF EXISTS dw.dim_cli CASCADE;
CREATE TABLE dw.dim_cli (
    srk SERIAL PRIMARY KEY,        
    pre VARCHAR(5),                
    col VARCHAR(5),
    avc VARCHAR(5),
    cor VARCHAR(5),
    "and" VARCHAR(5)              
);

-- 5. Tabela Fato Saúde (fat)
DROP TABLE IF EXISTS dw.fat_sau CASCADE;
CREATE TABLE dw.fat_sau (
    id SERIAL PRIMARY KEY,        
    
    dmg INTEGER REFERENCES dw.dim_dmg(srk),
    est INTEGER REFERENCES dw.dim_est(srk),
    acs INTEGER REFERENCES dw.dim_acs(srk),
    cli INTEGER REFERENCES dw.dim_cli(srk),
    dia VARCHAR(20),               
    imc DECIMAL(5,2),              
    sau VARCHAR(20),
    men INTEGER,
    fis INTEGER,
    ris INTEGER,
    dat TIMESTAMP DEFAULT NOW()
);