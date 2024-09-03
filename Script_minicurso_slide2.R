### Tratamento de dados

## Importando a base de dados

library(readxl)
dados <- read_excel(path = "database/petro.xls",na="NA", sheet = "Refino")
dados


### Nome das variáveis
## Funções tidyverse e janitor

library(tidyverse)
library(janitor)

names(dados)

dados <- clean_names(dados) # a função clean_names() para primeiro ajuste dos nomes das variaveis
names(dados)

### Linhas e colunas vazias

dados <- remove_empty(dados,"rows")

dados <- remove_empty(dados,"cols")
names(dados)

### Identificação de casos duplicados

get_dupes(dados, amostra)

library(dplyr)
dados1 <-  distinct(dados,amostra, .keep_all = TRUE)
dados1

### Identificar tipo e classe de todas as variáveis da base

str(dados1)

## converter a variável para data reduzida
dados1$data  <- as.Date(dados1$data)
str(dados1)

# Para variáveis qualitativas: tabela de frequências da variável campo.
#do pacote janitor
tabyl(dados1,campo)


# Para lidar com variáveis de texto, vamos utilizar o pacote stringr.
library(stringr)
dados1$campo <- str_to_lower(dados1$campo)
tabyl(dados1,campo)




