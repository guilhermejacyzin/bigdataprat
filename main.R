# Analisando a Temperatura Médias nas Cidades Brasileiras // Dataset OLD

# UTF8
Sys.setlocale("LC_ALL", "pt_BR.UTF-8")

# Instalando os pacotes necessários
install.packages("readr")
install.packages("data.table")
install.packages("dplyr")
install.packages("ggplot2")
library(readr)
library(dplyr)
library(ggplot2)
library(scales)
library(data.table)

# Carregando os dados e comparando a velocidade(tempo de carregamento) de diferentes métodos
# read.csv2()
# system.time(df_teste1 <- read.csv("TemperaturasGlobais.csv"))

# read.table()
# system.time(df_teste2 <- read.table("TemperaturasGlobais.csv"))

# fread
system.time(df <- fread("TemperaturasGlobais.csv"))

# Conferindo
# head(df_teste1)
# head(df_teste2)
head(df)

# fread é o mais rápido
# usuário   sistema decorrido
# 1.94      0.38      1.34

# Criando subset dos dados carregados
cidadesBrasil <- subset(df, Country == "Brazil")
cidades <- na.omit(cidadesBrasil)
head(cidadesBrasil)
View(cidadesBrasil)
nrow(df)
ncol(df)
nrow(cidadesBrasil)
dim(cidadesBrasil)

# Convertendo as Datas
cidadesBrasil$dt <- as.POSIXct(cidadesBrasil$dt, format='%Y-%m-%d')
cidadesBrasil$Month <- month(cidadesBrasil$dt)
cidadesBrasil$Year <- year(cidadesBrasil$dt)
View(cidadesBrasil)

# Carregando Subsets
# Palmas
plm <- subset(cidadesBrasil, City == 'Palmas')
plm <- subset(plm, Year %in% c(1796,1846,1896,1946,1996,2012))

# Curitiba
crt <- subset(cidadesBrasil, City == 'Curitiba')
crt <- subset(crt, Year %in% c(1796,1846,1896,1946,1996,2012))

# Recife
recf <- subset(cidadesBrasil, City=='Recife')
recf <- subset(recf,Year %in% c(1796,1846,1896,1946,1996,2012))


# Construindo os Plots
p_plm <- ggplot(plm, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mês")+
  ylab("Temperatura Média") +
  scale_color_discrete("") +
  ggtitle("Temperatura Média ao longo dos anos em Palmas") +
  theme(plot.title = element_text(size = 18))

p_crt <- ggplot(crt, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mês")+
  ylab("Temperatura") +
  scale_color_discrete("") +
  ggtitle("Temperatura Média ao longo dos anos em Curitiba") +
  theme(plot.title = element_text(size = 18))

p_recf <- ggplot(recf, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mês")+
  ylab("Temperatura Média") +
  scale_color_discrete("") +
  ggtitle("Temperatura Média ao longo dos anos em Recife") +
  theme(plot.title = element_text(size = 18))


# Plotando
p_plm
p_crt
p_recf

