library(ggpubr)
library(ggthemes)
library(ggdark)
library(ggrepel)

## Dane wstepne ----
## Generowanie losowych param. czasu (wagi)
time_attack <- round(abs((rnorm(70)*50))+1,0)

## Generowanie losowych param. czasu (wagi)
value <- round(abs(time_attack*rnorm(35)*10)+1,0)

## Tablica z wartoscia i "waga"
data_frame <- data.frame(value,time_attack)

## Generowanie nazw przedmiotow 
name_attack <- c()

for (i in 1:nrow(data_frame)){
  
  if (data_frame$time_attack[i] <= 15){
  name_attack[i] <- paste0("Wioska_",i)
  }
  
  else if (data_frame$time_attack[i] > 15  &  data_frame$time_attack[i] <= 60) {
    name_attack[i] <- paste0("Magazyn_",i)
  }
  
  else {
    name_attack[i] <- paste0("Twierdza_",i)
  }
}

## Ostateczna wersja tablicy z danymi
data_frame <- cbind(data_frame,name_attack)
data_frame <- data_frame[c(3,1,2)]

data_frame$name_attack <- as.character(data_frame$name_attack)

## Korelacja -----
ggscatter(na.omit(data_frame), y = "value", x = "time_attack",
          color = "#FF3399", size = 3.75, shape = 1,
          add = "reg.line", xlab = "Czas ataku [s] ", ylab="Wartoœæ",
          cor.method = "pearson",
          add.params = list(color = "red", fill = "grey", size=2.4),
          conf.int = TRUE, cor.coef = TRUE, 
          cor.coeff.args = list(method = "pearson", color="red", size=4.65, label.x=5, label.sep = "\n")) +
  dark_theme_minimal() +
  theme(panel.background = element_rect(fill="#330066")) +
  theme(plot.title = element_text(size= 16, colour= "red")) +
  theme(axis.title.x = element_text(size = 15)) +
  theme(axis.title.y = element_text(size = 15)) +
  labs(title = "Korelacja", subtitle = "Pomiêdzy wartoœci¹ obiektu, a czasem potrzebnym na jego zniszczenie")

## 1) Algorytmy zachlanne ----
## a) Najwartosciowsze ----

## Sortujemy po wartosci najcenniejszej 
value_function <- function(seconds){
  sort_val <- data_frame[order(-data_frame$value),]

  ## Obliczenie sumy sekund
  sum_time <- 0
  for (i in 1:nrow(sort_val)){
    sum_time <- sum_time + sort_val$time_attack[i]
    if (seconds <= sort_val$time_attack[1]) {
      return(0)
    }
    else if (sum_time >= seconds){
      sum_time <- sum_time - sort_val$time_attack[i]
      value_table <<- sort_val[(1:(i-1)),]
      break
    }
  }
  
print(value_table)

print(ggplot(value_table, aes(cumsum(time_attack), cumsum(value))) + 
        geom_step(aes(x= cumsum(time_attack), y = cumsum(value)), color="white") +
        geom_point(aes(x= cumsum(time_attack), y = cumsum(value)), size=4) +
        geom_point(aes(x=0,y=0),size= 4) +
        geom_segment(aes(x = 0, y = 0, xend = time_attack[1], yend = 0)) +
        geom_segment(aes(x = time_attack[1], y = 0, xend = time_attack[1], yend = value[1])) +
        geom_label_repel(aes(label=name_attack), size = 4) +
        labs(title= "Algorytm Zach³anny\n(Najwartoœciowsze)", 
             x="Skumulowany czas [s]", y= "Skumulowana wartoœæ") +
        dark_theme_light())
  
return(cat("\n\n",paste0("Optymalnie mozna wybrac: ", "\n",
                              paste0(as.vector(value_table$name_attack), collapse = ", "), ",",
                               "\n\n","gdzie laczna wartosc to: ", sum(value_table$value),
                               "\n","a potrzebny czas to: ", sum_time, "s\n\n")))
  
}

#b) Najmniej czasochlonne ----
time_function <- function(seconds){
sort_time <- data_frame[order(data_frame$time_attack),]

sum_time <- 0
for (i in 1:nrow(sort_time)){
  sum_time <- sum_time + sort_time$time_attack[i]
  if (seconds <= sort_time$time_attack[1]) {
    return(0)
  }
  else if (sum_time >= seconds){
    sum_time <- sum_time - sort_time$time_attack[i]
    time_table <<- sort_time[(1:(i-1)),]
    break
  }
}

print(time_table)

print(ggplot(time_table, aes(cumsum(time_attack), cumsum(value))) + 
        geom_step(aes(x= cumsum(time_attack), y = cumsum(value)), color="white") +
        geom_point(aes(x= cumsum(time_attack), y = cumsum(value)), size=4) +
        geom_point(aes(x=0,y=0),size= 4) +
        geom_segment(aes(x = 0, y = 0, xend = time_attack[1], yend = 0)) +
        geom_segment(aes(x = time_attack[1], y = 0, xend = time_attack[1], yend = value[1])) +
        geom_label_repel(aes(label=name_attack), color=rep(c(18)), size = 4) +
        labs(title= "Algorytm Zach³anny\n(Najmniej czasoch³onne)", 
             x="Skumulowany czas [s]", y= "Skumulowana wartoœæ") +
        dark_theme_light())



return(cat("\n\n",paste0("Optymalnie mozna wybrac: ", "\n",
                            paste0(as.vector(time_table$name_attack), collapse = ", "), ",",
                            "\n\n","gdzie laczna wartosc to: ", sum(time_table$value),
                            "\n","a potrzebny czas to: ", sum_time, "s\n\n")))

}

##c) Jednostkowe----
unit_function <- function(seconds){

## Tablica z podzielona wartoscia na 1 sekunde ataku
sort_unit <- data_frame[order(-data_frame$value),]
unit_sec <- round(c(sort_unit$value/sort_unit$time_attack),3)
sort_unit <- cbind(sort_unit, unit_sec)
sort_unit <- sort_unit[order(-sort_unit$unit_sec),]

sum_time <- 0
for (i in 1:nrow(sort_unit)){
  sum_time <- sum_time + sort_unit$time_attack[i]
  if (seconds <= sort_unit$time_attack[1]) {
    return(0)
  }
  else if (sum_time >= seconds){
    sum_time <- sum_time - sort_unit$time_attack[i]
    unit_table <<- sort_unit[(1:(i-1)),]
    break
  }
}

print(unit_table)

print(ggplot(unit_table, aes(cumsum(time_attack), cumsum(value))) + 
        geom_step(aes(x= cumsum(time_attack), y = cumsum(value)), color="white") +
        geom_point(aes(x= cumsum(time_attack), y = cumsum(value)), size=4) +
        geom_point(aes(x=0,y=0),size= 4) +
        geom_segment(aes(x = 0, y = 0, xend = time_attack[1], yend = 0)) +
        geom_segment(aes(x = time_attack[1], y = 0, xend = time_attack[1], yend = value[1])) +
        geom_label_repel(aes(label=name_attack),color=rep(c(5)), size = 4) +
        labs(title= "Algorytm Zach³anny\n(Wartoœæ/Waga) ", 
             x="Skumulowany czas [s]", y= "Skumulowana wartoœæ") +
        dark_theme_light())

return(cat("\n\n",paste0("Optymalnie mozna wybrac: ", "\n",
                         paste0(as.vector(unit_table$name_attack), collapse = ", "), ",",
                         "\n\n","gdzie laczna wartosc to: ", sum(unit_table$value), 
                         "\n","a potrzebny czas to: ", sum_time, "s\n\n")))

}

##2) Algorytm optymalny ----
optim_function <- function(w, p, cap) {
  n <- length(w)
  
  # macierze
  x <- logical(n)
  Fr <- matrix(0, nrow = cap + 1, ncol = n)
  G <- matrix(0, nrow = cap + 1, ncol = 1)
  
  # uzupelnienie macierzy wartosciami
  for (k in 1:n) {
    Fr[, k] <- G
    H <- c(numeric(w[k]), G[1:(cap + 1 - w[k]), 1] + p[k])
    G <- pmax(G, H)
  }
  fmax <- G[cap + 1, 1]
  
  # wyszukiwanie nazw
  f <- fmax
  j <- cap + 1
  for (k in n:1) {
    if (Fr[j, k] < f) {
      x[k] <- TRUE
      j <- j - w[k]
      f <- Fr[j, k]
    }
  }
  
  inds <- which(x)
  wght <- sum(w[inds])
  prof <- sum(p[inds])
  names_list <- c()
  v <- as.vector(inds)
  v_leng <- as.numeric(length(v))
  
  for (i in 1:v_leng){
    names_list[i] <- (data_frame[v[i],1])
    knap_table <<- data_frame[v,]
  }
  
  print(knap_table)
  
print(ggplot(knap_table, aes(cumsum(time_attack), cumsum(value))) + 
  geom_step(aes(x= cumsum(time_attack), y = cumsum(value)), color="white") +
  geom_point(aes(x= cumsum(time_attack), y = cumsum(value)), size=5) +
  geom_point(aes(x=0,y=0),size= 5) +
  geom_segment(aes(x = 0, y = 0, xend = time_attack[1], yend = 0)) +
  geom_segment(aes(x = time_attack[1], y = 0, xend = time_attack[1], yend = value[1])) +
  geom_label_repel(aes(label=name_attack),color=rep(c(6)), size = 4) +
  labs(title= "Algorytm Optymalny", x="Skumulowany czas [s]", y= "Skumulowana wartoœæ") + 
  dark_theme_light())

return(cat("\n\n",paste0(" Optymalnie mozna wybrac: ", "\n",
                           paste0(as.vector(names_list), collapse = ", "), ",",
                           "\n\n","gdzie laczna wartosc to: ", prof,
                           "\n","a potrzebny czas to: ", wght, "s\n\n")))

}

##3) Wykres porownujacy ----
all_plot_function <- function(){
print(ggplot() + 
  geom_step(data=time_table,aes(x=cumsum(time_attack), y=cumsum(value)), color="white") +
  geom_point(data=time_table,aes(x=cumsum(time_attack), y=cumsum(value)), size=2, color="white") +
  geom_point(data=time_table, aes(x=0,y=0, colour="white"),size=2) +
  geom_segment(data=time_table, aes(x=0, y=0, xend=time_attack[1], yend=0), color="white") +
  geom_segment(data=time_table, aes(x=time_attack[1], y=0, xend=time_attack[1], yend=value[1]),
               color= "white") +
  
  geom_step(data=unit_table,aes(x=cumsum(time_attack), y=cumsum(value)), color="green") +
  geom_point(data=unit_table,aes(x=cumsum(time_attack), y=cumsum(value)), size=2, color="green") +
  geom_point(data=unit_table, aes(x=0,y=0, colour="green"),size=2) +
  geom_segment(data=unit_table, aes(x=0, y=0, xend=time_attack[1], yend=0), color="green") +
  geom_segment(data=unit_table, aes(x=time_attack[1], y=0, xend=time_attack[1], yend=value[1]),
               color= "green") +
  
  geom_step(data=value_table,aes(x=cumsum(time_attack), y=cumsum(value)), color="royalblue2") +
  geom_point(data=value_table,aes(x=cumsum(time_attack), y=cumsum(value)), size=2, color="royalblue2") +
  geom_point(data=value_table, aes(x=0,y=0, colour="royalblue2"),size=2) +
  geom_segment(data=value_table, aes(x=0, y=0, xend=time_attack[1], yend=0), color="royalblue2") +
  geom_segment(data=value_table, aes(x=time_attack[1], y=0, xend=time_attack[1], yend=value[1]), 
               color= "royalblue2") +
  
  geom_step(data=knap_table,aes(x=cumsum(time_attack), y=cumsum(value)), color="red") +
  geom_point(data=knap_table,aes(x=cumsum(time_attack), y=cumsum(value)), size=2, color="red") +
  geom_point(data=knap_table, aes(x=0,y=0, colour="red"),size=2) +
  geom_segment(data=knap_table, aes(x=0, y=0, xend=time_attack[1], yend=0), color="red") +
  geom_segment(data=knap_table, aes(x=time_attack[1], y=0, xend=time_attack[1], yend=value[1]),
               color="red") +
  
  geom_point(data=knap_table, aes(x=0,y=0),size=3.5, shape=8) +
  
  scale_color_manual(labels=c("Najl¿ejszy", "Wartoœæ", "Wartoœæ / Waga", "Optymalny"), 
                     values = c("white", "royalblue2", "green", "red")) +
  labs(title= "Porównanie Algorytmów", x= "Skumulowany czas [s]", y= "Skumulowana wartoœæ",
       color= "Algorytm: ") + 
  dark_theme_light())
}
  
##4) Wykorzystanie funkcji----
## Jako argument podajemy sekundy
value_function(300) #Algorytm zachlanny (najwartosciowsze)
time_function(300) #Algorytm zachlanny ("najlzejsze")
unit_function(300) #Algorytm zachlanny (wartosc/waga)

## Jako argumenty podajemy wage, wartosc i sekundy
optim_function(data_frame$time_attack, data_frame$value, 300) #Algorytm optymalny

## Bez argumentow
all_plot_function()


