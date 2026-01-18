-- ============================================================================
-- SILVER LAYER: TABELA DIABETES INDICATORS
-- Camada Silver - Dados de saúde limpos, traduzidos e enriquecidos
-- ============================================================================

-- Criação do schema silver (caso não exista)
CREATE SCHEMA IF NOT EXISTS silver;

-- Comentário no schema
COMMENT ON SCHEMA silver IS 'Camada Silver - Dados de saúde processados e validados';

-- ============================================================================
-- TABELA: DIABETES_INDICATORS
-- ============================================================================
DROP TABLE IF EXISTS silver.diabetes_indicators CASCADE;

CREATE TABLE silver.diabetes_indicators (
    patient_id INT PRIMARY KEY,
    
    diabetes_status VARCHAR(20),    
    high_bp VARCHAR(10),             
    high_chol VARCHAR(10),          
    cholesterol_check VARCHAR(10),   
    bmi FLOAT,                       
    bmi_category VARCHAR(20),         
    
    stroke VARCHAR(10),              
    heart_disease_attack VARCHAR(10), 
    
    smoker VARCHAR(10),              
    physical_activity VARCHAR(10),    
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
    
    -- Métricas Calculadas
    risk_factors_count INT,           
    
    -- Metadata
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- ÍNDICES PARA PERFORMANCE
-- ============================================================================
CREATE INDEX idx_diabetes_status ON silver.diabetes_indicators(diabetes_status);
CREATE INDEX idx_diabetes_bmi_cat ON silver.diabetes_indicators(bmi_category);
CREATE INDEX idx_diabetes_age_group ON silver.diabetes_indicators(age_group);
CREATE INDEX idx_diabetes_sex ON silver.diabetes_indicators(sex_desc);
CREATE INDEX idx_diabetes_risk_score ON silver.diabetes_indicators(risk_factors_count);
CREATE INDEX idx_diabetes_high_risk ON silver.diabetes_indicators(risk_factors_count) 
WHERE risk_factors_count >= 3;

-- ============================================================================
-- COMENTÁRIOS NAS COLUNAS 
-- ============================================================================
COMMENT ON TABLE silver.diabetes_indicators IS 'Indicadores de saúde relacionados ao diabetes (BRFSS 2015)';

COMMENT ON COLUMN silver.diabetes_indicators.patient_id IS 'ID artificial gerado para o paciente';
COMMENT ON COLUMN silver.diabetes_indicators.diabetes_status IS 'Status diagnosticado de diabetes (Target)';
COMMENT ON COLUMN silver.diabetes_indicators.high_bp IS 'Indicador de pressão alta';
COMMENT ON COLUMN silver.diabetes_indicators.high_chol IS 'Indicador de colesterol alto';
COMMENT ON COLUMN silver.diabetes_indicators.cholesterol_check IS 'Verificação de colesterol feita nos últimos 5 anos';
COMMENT ON COLUMN silver.diabetes_indicators.bmi IS 'Índice de Massa Corporal (Calculado)';
COMMENT ON COLUMN silver.diabetes_indicators.bmi_category IS 'Categoria clínica do IMC (Abaixo, Normal, Obeso)';
COMMENT ON COLUMN silver.diabetes_indicators.smoker IS 'Fumou pelo menos 100 cigarros na vida';
COMMENT ON COLUMN silver.diabetes_indicators.stroke IS 'Histórico de derrame';
COMMENT ON COLUMN silver.diabetes_indicators.heart_disease_attack IS 'Histórico de doença coronariana ou infarto';
COMMENT ON COLUMN silver.diabetes_indicators.physical_activity IS 'Praticou atividade física nos últimos 30 dias';
COMMENT ON COLUMN silver.diabetes_indicators.has_healthcare IS 'Possui alguma cobertura de saúde';
COMMENT ON COLUMN silver.diabetes_indicators.cant_afford_doctor IS 'Evitou médico devido ao custo nos últimos 12 meses';
COMMENT ON COLUMN silver.diabetes_indicators.gen_health_score IS 'Nota de autoavaliação de saúde (1 a 5)';
COMMENT ON COLUMN silver.diabetes_indicators.mental_health_days IS 'Dias com saúde mental não boa nos últimos 30 dias';
COMMENT ON COLUMN silver.diabetes_indicators.physical_health_days IS 'Dias com saúde física não boa nos últimos 30 dias';
COMMENT ON COLUMN silver.diabetes_indicators.income_level_raw IS 'Nível de renda familiar (Escala 1 a 8)';
COMMENT ON COLUMN silver.diabetes_indicators.risk_factors_count IS 'Contagem de comorbidades e fatores de risco';

-- ============================================================================
-- VIEWS AUXILIARES (ANALYTICS)
-- ============================================================================

-- View: Resumo de Saúde por Faixa Etária
CREATE OR REPLACE VIEW silver.vw_health_by_age AS
SELECT 
    age_group,
    COUNT(*) as total_patients,
    ROUND(AVG(bmi)::numeric, 2) as avg_bmi,
    ROUND(AVG(mental_health_days)::numeric, 2) as avg_mental_bad_days,
    SUM(CASE WHEN diabetes_status = 'Diabetes' THEN 1 ELSE 0 END) as total_diabetics,
    ROUND((SUM(CASE WHEN diabetes_status = 'Diabetes' THEN 1 ELSE 0 END)::numeric / COUNT(*)) * 100, 2) as diabetes_percentage
FROM silver.diabetes_indicators
GROUP BY age_group
ORDER BY age_group;

-- View: Pacientes de Alto Risco (Top Risk)
CREATE OR REPLACE VIEW silver.vw_high_risk_patients AS
SELECT 
    patient_id,
    sex_desc,
    age_group,
    bmi,
    bmi_category,
    smoker,
    diabetes_status,
    risk_factors_count
FROM silver.diabetes_indicators
WHERE risk_factors_count >= 3
ORDER BY risk_factors_count DESC, bmi DESC;

-- View: Impacto do Estilo de Vida
CREATE OR REPLACE VIEW silver.vw_lifestyle_impact AS
SELECT 
    physical_activity,
    eats_fruits,
    eats_veggies,
    smoker,
    COUNT(*) as total_group,
    SUM(CASE WHEN diabetes_status = 'Diabetes' THEN 1 ELSE 0 END) as diabetics_count,
    ROUND((SUM(CASE WHEN diabetes_status = 'Diabetes' THEN 1 ELSE 0 END)::numeric / COUNT(*)) * 100, 2) as diabetes_rate
FROM silver.diabetes_indicators
GROUP BY physical_activity, eats_fruits, eats_veggies, smoker
ORDER BY diabetes_rate DESC;

-- ============================================================================
-- FIM DO DDL
-- ============================================================================