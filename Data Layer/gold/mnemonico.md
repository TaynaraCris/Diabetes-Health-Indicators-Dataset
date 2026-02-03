# Dicionário de Mnemônicos 

Este documento estabelece as abreviações e os padrões de nomenclatura adotados no modelo Star Schema da camada Gold.


### 1. Dimensão Demografia
**Sigla da Tabela:** `dmg`

| Nome | Sigla |
| :--- | :--- |
| Surrogate Key | `srk` |
| Sexo | `sex` |
| Idade | `ida` |
| Escolaridade | `esc` |
| Renda | `ren` |

### 2. Dimensão Estilo de Vida
**Sigla da Tabela:** `est`

| Nome | Sigla |
| :--- | :--- |
| Surrogate Key | `srk` |
| Fumante | `fum` |
| Frutas | `fru` |
| Vegetais | `veg` |
| Físico | `fis` |
| Álcool | `alc` |

### 3. Dimensão Acesso Médico
**Sigla da Tabela:** `acs`

| Nome | Sigla |
| :--- | :--- |
| Surrogate Key | `srk` |
| Plano | `pla` |
| Custo | `cus` |
| Colesterol | `col` |

### 4. Dimensão Histórico Clínico
**Sigla da Tabela:** `cli`

| Nome | Sigla |
| :--- | :--- |
| Surrogate Key | `srk` |
| Pressão | `pre` |
| Colesterol | `col` |
| AVC | `avc` |
| Coração | `cor` |
| Andar | `and` |

### 5. Fato Saúde
**Sigla da Tabela:** `fat`

| Nome | Sigla |
| :--- | :--- |
| ID Fato | `id` |
| FK Demografia | `dmg` |
| FK Estilo Vida | `est` |
| FK Acesso | `acs` |
| FK Clínico | `cli` |
| Diabetes | `dia` |
| IMC | `imc` |
| Saúde Geral | `sau` |
| Mental | `men` |
| Física | `fis` |
| Risco | `ris` |
| Data | `dat` |