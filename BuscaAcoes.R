#
#1 - LER UM ARQUIVO CSV COM OS NOMES DAS AÇÕES E ARMAZENAR EM UM DATAFRAME
#2 - PEGAR CADA NOME E BUSCAR O PREÇO DA AÇÃO NO YAHOO FINANCE
#3 - SALVAR OS PREÇOS EM UM VETOR
#4 - ADICIONAR ESSE VETOR AO DATAFRAME
#5 - SALVAR ESSE DATAFRAME EM UM ARQUIVO CSV
# Carlos E. Carvalho
# carlos.e.carvalho@gmail.com
# LinkedIn: https://www.linkedin.com/in/carlos-carvalho-93204b13/

#Configurando o diretÃ³rio de trabalho
setwd("D:/CIENTISTA_DADOS/ACOES")
getwd()

#http://www.quantmod.com/

#Carrega todos os pacotes

library(quantmod)
library(xts)
library(moments)
library(readr)
library(rvest)
library(stringr)
library(dplyr)
library(lubridate)

#Carrega o arquivo com o nome das ações.
#Eu criei uma coluna a mais no arquivo, para que o script funcione na primeira vez.
#Antes de salvar os valores no data frame, essa coluna é retirada.
#Mas ela é recolocada automaticamente na hora em que o arquivo csv é recriado.
acoes <- read_csv("acoes.csv")

str(acoes)

#A coluna valor veio com o tipo logico.  Vamos transformar para numérico
acoes$VALOR <- as.numeric(acoes$VALOR)
str(acoes)

#Transforma em data frame senão a função getSimbols não funciona
acoes <- as.data.frame(acoes)
#Tirar a primeira coluna que foi criada 
acoes <- acoes[,-1]

#Selecao do periodo de analise - Aqui tem que colocar o dia que você quer 
startDate <- as.Date("2021-01-21")
endDate <- as.Date("2021-01-22")


#Agora vai pegar cada uma das ações, buscar o valor delas no yahoo e salvar novamente no data frame

for (i in 1:length(acoes$TICKER)){
  ticker <- acoes[i,1]
  obj <- getSymbols(ticker, src = "yahoo", from = startDate, to = endDate, auto.assign = F)
  acoes[i,2] <- obj[1,4]
  Sys.sleep(0.3) #É importante esperar um tempo para cada requisição, senão o site pode bloquear
}
View(acoes)

#Salva em um arquivo CSV
write.csv(acoes, "acoes.csv")

