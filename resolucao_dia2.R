####### EXERCÍCIOS RESOLVIDOS SLIDES 2 ###############

# Crie uma variável que calcula a razão entre resinas e asfaltenos, indicando a estabilidade coloidal do petróleo.

dados1 <- mutate(dados1,
                 estabilidade_coloidal = round(dados1$resinas / dados1$asfaltenos, 2))


# O TAN (Número de Acidez Total) é uma medida da acidez de um petróleo ou produto petroquímico, a interpretação dos níveis de acidez pode variar dependendo do tipo de petróleo. Discretize essa variável com base no seguinte critério

dados1$tan_categoria <- cut(
  dados1$tan,
  breaks = c(0, 0.5, 1, Inf),  # Definindo os limites das categorias
  labels = c("Baixo", "Medio", "Alto"),
  right = TRUE  # Inclui o valor de limite superior na categoria
)


# Filtre do banco de dados apenas as linhas que tiver ponto de fluidez baixo e forem do campo Baleia Azul.

dados_filtrados <- dados_filtrados |> filter(ponto_de_fluidez_categoria == "Baixo" & campo == "baleia azul")

# Realize o tratamento da base de dados "dados2".

## Corrigindo nomes das variáveis

dados2 <- clean_names(dados2)
names(dados2)

# Remover linhas e colunas vazias

dados2 <- remove_empty(dados2,"rows")
dados2 <- remove_empty(dados2,"cols")
names(dados2)

# Identificação de dados duplicados
get_dupes(dados2, amostra)
dados2 <-  distinct(dados2,amostra, .keep_all = TRUE)

#Ajustando a classe de cada variável
str(dados2)


### Observando a natureza dos dados, discutam, qual o melhor tipo de junção? E porquê? Faça a junção no R.

# Como gostaríamos de manter o máximo de informações possíveis de cada amostra, usamos o full_join()

dados_juncao <- full_join(dados1, dados2, by = c("amostra"))


