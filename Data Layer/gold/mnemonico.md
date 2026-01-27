### 1. Dimensão Demografia

Este documento estabelece as abreviações e os padrões de nomenclatura adotados no modelo Star Schema da camada Gold.


| Nome | Sigla |
| :--- | :--- |
| **Demografia (Tabela)** | **dmg** |
| Surrogate Key | `dmg_srk` |
| Sexo | `dmg_sex` |
| Idade | `dmg_ida` |
| Escolaridade | `dmg_esc` |
| Renda | `dmg_ren` |

### 2. Dimensão Estilo de Vida

| Nome | Sigla |
| :--- | :--- |
| **Estilo de Vida (Tabela)** | **est** |
| Surrogate Key | `est_srk` |
| Fumante | `est_fum` |
| Frutas | `est_fru` |
| Vegetais | `est_veg` |
| Atividade Física | `est_atv_fis` |
| Álcool | `est_alc` |

### 3. Dimensão Acesso Médico

| Nome | Sigla |
| :--- | :--- |
| **Acesso Médico (Tabela)** | **acs** |
| Surrogate Key | `acs_srk` |
| Plano de Saúde | `acs_pla_sau` |
| Custo Médico | `acs_cus_med` |
| Checkup Colesterol | `acs_che_col` |

### 4. Dimensão Histórico Clínico

| Nome | Sigla |
| :--- | :--- |
| **Histórico Clínico (Tabela)** | **cli** |
| Surrogate Key | `cli_srk` |
| Pressão Alta | `cli_pre_alt` |
| Colesterol Alto | `cli_col_alt` |
| AVC | `cli_avc` |
| Doença Coração | `cli_doe_cor` |
| Dificuldade Andar | `cli_dif_and` |

### 5. Fato Saúde Pessoa

| Nome | Sigla |
| :--- | :--- |
| **Fato Saúde (Tabela)** | **fat** |
| ID Fato | `fat_id` |
| Diabetes Status | `fat_dia_sta` |
| IMC | `fat_imc` |
| Saúde Geral | `fat_sau_ger` |
| Saúde Mental | `fat_sau_men` |
| Saúde Física | `fat_sau_fis` |
| Risco Total | `fat_ris_tot` |
| Data Carga | `fat_dat_car` |