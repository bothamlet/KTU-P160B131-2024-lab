install.packages("plotly")
install.packages("gganimate")
install.packages("htmlwidgets")

library(tidyverse)
library(plotly)
library(gganimate)
library(htmlwidgets)

cat("Dabartinė direktorija: ", getwd())

data_2 <- readRDS("../data/Data.rds")

# 2.1 užduotis (Histograma)

# Pašaliname NA reikšmes
data_clean <- data_2[complete.cases(data_2$avgWage), ]

graph_1 <- ggplot(data = data_clean, aes(x = avgWage)) +
  geom_histogram() +
  labs(y = "Kiekis", x = "Vidutinis atlyginimas", main = "Vidutinio atlyginimo histograma")

ggsave("../img/1_uzd.png", graph_1, width = 3000, height = 1500, units = ("px"))

# 2.2 užduotis (Top 5 imones pagal darbuotojus)

top_5 <- data_clean %>%
  group_by(name) %>%
  summarise(wage = max(avgWage)) %>%
  arrange(desc(wage)) %>%
  head(5)

graph_2 <- data %>%
  filter(name %in% top_5$name) %>%
  mutate(month = ym(month)) %>%
  ggplot(aes(x = month, y = avgWage, color = name)) +
  geom_line() +
  labs(x = "Mėnesiai", y = "Vidutinis atlyginimas", color = "Įmonės")

ggsave("../img/2.2_uzd.png", graph_2, width = 3000,
       height = 1500, units = ("px"))

# 2.3 užduotis (Didžiausių įmonių apdraustų darbuotojųe skaičius)

graph_3 = data %>%
  filter(name %in% top_5$name) %>%
  group_by(name)%>%
  summarise(Ins=max(numInsured))%>%
  arrange(desc(Ins))

graph_3$name = factor(graph_3$name, levels = graph_3$name[order(graph_3$Ins, decreasing = T)])

graph_4 = graph_3%>%
  ggplot(aes(x = name, y = Ins, fill = name)) + geom_col() + theme_classic() +
  labs(title = " 5 didžiausių įmonių apdraustų darbutuojų skaičius", x = "Įmonė", y  = "Apdaraustų darbutojų skaičius", fill = "Įmonių pavadinimai")

ggsave("../img/2.3_uzd.png", graph_4, width = 5000, height = 2500, units = ("px"))