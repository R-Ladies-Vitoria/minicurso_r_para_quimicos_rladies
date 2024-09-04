### Tratamento de dados

## Importando a base de dados

library(readxl)
dados <- read_excel(path = "database/petro.xls",na="NA", sheet = "Refino")
View(dados)


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
dados1$data_inicio  <- as.Date(dados1$data_inicio)
str(dados1)

dados1$data_fim  <- as.Date(dados1$data_fim)
str(dados1)

# Para variáveis qualitativas: tabela de frequências da variável campo.
#do pacote janitor
tabyl(dados1,campo)


# Para lidar com variáveis de texto, vamos utilizar o pacote stringr.
library(stringr)
dados1$campo <- str_to_lower(dados1$campo)
tabyl(dados1,campo)


# tabela de frequências da variável campo
tabyl(dados1,campo)

library(stringr)
dados1$campo <- str_to_lower(dados1$campo)
tabyl(dados1,campo)

## Transformação de variáveis quantitativas

dados1 <- mutate(dados1, indice_saturados_aromaticos = dados1$saturados / dados1$aromaticos)

summary(dados1$indice_saturados_aromaticos)

## Discretizar dados
dados1$ponto_de_fluidez_categoria <- cut(
  dados1$ponto_de_fluidez,
  breaks = c(-Inf, 0, 10, Inf),  # Definindo os limites das categorias
  labels = c("Baixo", "Medio", "Alto"),
  right = TRUE  # Inclui o valor de limite superior na categoria
)

tabyl(dados1, ponto_de_fluidez_categoria)

library(forcats)

dados1$ponto_de_fluidez_categoria <- fct_recode(dados1$ponto_de_fluidez_categoria,
                                                "Baixo" = "Baixo",
                                                "Medio" = "Medio",
                                                "Alto" = "Alto")
fct_count(dados1$ponto_de_fluidez_categoria)

## Diferença de datas
library(lubridate)
intervalo <- ymd(dados1$data_inicio) %--%  ymd(dados1$data_fim)

dados1$tempo_coleta <- intervalo / ddays(1)  #número de dias

dados1$tempo_coleta

## Filtrando banco de dados

dados_jubarte <- dados1 %>% filter(campo == "jubarte")

dados_jubarte

## Combinação de bases de dados

dados2 <- read_excel(path = "database/petro1.xls",na="NA")

str(dados2)

