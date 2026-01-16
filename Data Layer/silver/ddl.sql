
-- Criação do schema
CREATE SCHEMA IF NOT EXISTS silver;

-- Limpeza inicial (caso precise recriar)
DROP TABLE IF EXISTS silver.diabetes_indicators CASCADE;

-- Definição da Tabela
CREATE TABLE silver.diabetes_indicators (
    patient_id INT PRIMARY KEY,
    diabetes_status VARCHAR(20),
    high_bp VARCHAR(10),
    high_chol VARCHAR(10),
    cholesterol_check VARCHAR(10),
    bmi FLOAT,
    bmi_category VARCHAR(20),
    smoker VARCHAR(10),
    stroke VARCHAR(10),
    heart_disease_attack VARCHAR(10),
    physical_activity VARCHAR(10),
-- Criação do schema
CREATE SCHEMA IF NOT EXISTS silver;

    eats_fruits VARCHAR(10),
    eats_veggies VARCHAR(10),
    heavy_alcohol VARCHAR(10),
    has_healthcare VARCHAR(10),
    cant_afford_doctor VARCHAR(10),
    gen_health_score INT,
    general_health VARCHAR(20),
    mental_health_days INT,
    physical_health_days INT,
    diff_walking VARCHAR(10),
    sex_desc VARCHAR(15),
    age_group VARCHAR(20),
    education_level VARCHAR(50),
    income_level_raw INT,
    risk_factors_count INT,
    
    created_at TIMESTAMP DEFAULT NOW()
);