library(e1071) # do kurtozy
library(dplyr) # do lepszego zarzadzania danymi
library(ggplot2)
library(ggcorrplot) # do korelacji

danewina <- read.csv2("winequality.csv", header= T)
head(danewina)

## Zadanie 1 -----

## Wybrane zmienne: pH, alcohol, chlorides, quality, citric.acid
## min i max, kwartyle, srednia, odch. stand, kurtoza,  

Catania_Wine <- danewina[danewina$region == "Catania", ]
Bolonia_Wine <- danewina[danewina$region == "Bolonia", ]
EmiliaRomana_Wine <- danewina[danewina$region == "Emilia Romana", ]

# Funkcja do wyboru regionu, zmiennej i wartosci do agregacji

aggregateFunction <- function(x,y,z){
  aggregate(list("value"= x), list(Color=y), FUN= z)
}

## Wartosci do agregacji
### pH ----

# srednia
aggregateFunction(Bolonia_Wine$pH,  Bolonia_Wine$color, mean) 
aggregateFunction(Catania_Wine$pH,  Catania_Wine$color, mean)
aggregateFunction(EmiliaRomana_Wine$pH,  EmiliaRomana_Wine$color, mean)

# mediana 
aggregateFunction(Bolonia_Wine$pH,  Bolonia_Wine$color, median)
aggregateFunction(Catania_Wine$pH,  Catania_Wine$color, median)
aggregateFunction(EmiliaRomana_Wine$pH,  EmiliaRomana_Wine$color, median)

# kwantyle
aggregateFunction(Bolonia_Wine$pH,  Bolonia_Wine$color, quantile) 
aggregateFunction(Catania_Wine$pH,  Catania_Wine$color, quantile)
aggregateFunction(EmiliaRomana_Wine$pH,  EmiliaRomana_Wine$color, quantile)

# wartosc min 
aggregateFunction(Bolonia_Wine$pH,  Bolonia_Wine$color, min)
aggregateFunction(Catania_Wine$pH,  Catania_Wine$color, min)
aggregateFunction(EmiliaRomana_Wine$pH,  EmiliaRomana_Wine$color, min)

# wartosc max
aggregateFunction(Bolonia_Wine$pH,  Bolonia_Wine$color, max)
aggregateFunction(Catania_Wine$pH,  Catania_Wine$color, max)
aggregateFunction(EmiliaRomana_Wine$pH,  EmiliaRomana_Wine$color, max)

# odchylenie standardowe 
aggregateFunction(Bolonia_Wine$pH,  Bolonia_Wine$color, sd)
aggregateFunction(Catania_Wine$pH,  Catania_Wine$color, sd) 
aggregateFunction(EmiliaRomana_Wine$pH,  EmiliaRomana_Wine$color, sd) 

# kurtoza
aggregateFunction(Bolonia_Wine$pH,  Bolonia_Wine$color, kurtosis)
aggregateFunction(Catania_Wine$pH,  Catania_Wine$color, kurtosis) 
aggregateFunction(EmiliaRomana_Wine$pH,  EmiliaRomana_Wine$color, kurtosis) 

# skosnosc - trzeci moment centralny
aggregateFunction(Bolonia_Wine$pH,  Bolonia_Wine$color, skewness)
aggregateFunction(Catania_Wine$pH,  Catania_Wine$color, skewness) 
aggregateFunction(EmiliaRomana_Wine$pH,  EmiliaRomana_Wine$color, skewness) 

### alcohol ----

# srednia
aggregateFunction(Bolonia_Wine$alcohol,  Bolonia_Wine$color, mean) 
aggregateFunction(Catania_Wine$alcohol,  Catania_Wine$color, mean)
aggregateFunction(EmiliaRomana_Wine$alcohol,  EmiliaRomana_Wine$color, mean)

# mediana 
aggregateFunction(Bolonia_Wine$alcohol,  Bolonia_Wine$color, median)
aggregateFunction(Catania_Wine$alcohol,  Catania_Wine$color, median)
aggregateFunction(EmiliaRomana_Wine$alcohol,  EmiliaRomana_Wine$color, median)

# kwantyle
aggregateFunction(Bolonia_Wine$alcohol,  Bolonia_Wine$color, quantile) 
aggregateFunction(Catania_Wine$alcohol,  Catania_Wine$color, quantile)
aggregateFunction(EmiliaRomana_Wine$alcohol,  EmiliaRomana_Wine$color, quantile)

# wartosc min 
aggregateFunction(Bolonia_Wine$alcohol,  Bolonia_Wine$color, min)
aggregateFunction(Catania_Wine$alcohol,  Catania_Wine$color, min)
aggregateFunction(EmiliaRomana_Wine$alcohol,  EmiliaRomana_Wine$color, min)

# wartosc max
aggregateFunction(Bolonia_Wine$alcohol,  Bolonia_Wine$color, max)
aggregateFunction(Catania_Wine$alcohol,  Catania_Wine$color, max)
aggregateFunction(EmiliaRomana_Wine$alcohol,  EmiliaRomana_Wine$color, max)

# odchylenie standardowe 
aggregateFunction(Bolonia_Wine$alcohol,  Bolonia_Wine$color, sd)
aggregateFunction(Catania_Wine$alcohol,  Catania_Wine$color, sd) 
aggregateFunction(EmiliaRomana_Wine$alcohol,  EmiliaRomana_Wine$color, sd) 

# kurtoza
aggregateFunction(Bolonia_Wine$alcohol,  Bolonia_Wine$color, kurtosis)
aggregateFunction(Catania_Wine$alcohol,  Catania_Wine$color, kurtosis) 
aggregateFunction(EmiliaRomana_Wine$alcohol,  EmiliaRomana_Wine$color, kurtosis) 

# skosnosc - trzeci moment centralny
aggregateFunction(Bolonia_Wine$alcohol,  Bolonia_Wine$color, skewness)
aggregateFunction(Catania_Wine$alcohol,  Catania_Wine$color, skewness) 
aggregateFunction(EmiliaRomana_Wine$alcohol,  EmiliaRomana_Wine$color, skewness) 

### chlorides ----

# srednia
aggregateFunction(Bolonia_Wine$chlorides,  Bolonia_Wine$color, mean) 
aggregateFunction(Catania_Wine$chlorides,  Catania_Wine$color, mean)
aggregateFunction(EmiliaRomana_Wine$chlorides,  EmiliaRomana_Wine$color, mean)

# mediana 
aggregateFunction(Bolonia_Wine$chlorides,  Bolonia_Wine$color, median)
aggregateFunction(Catania_Wine$chlorides,  Catania_Wine$color, median)
aggregateFunction(EmiliaRomana_Wine$chlorides,  EmiliaRomana_Wine$color, median)

# kwantyle
aggregateFunction(Bolonia_Wine$chlorides,  Bolonia_Wine$color, quantile) 
aggregateFunction(Catania_Wine$chlorides,  Catania_Wine$color, quantile)
aggregateFunction(EmiliaRomana_Wine$chlorides,  EmiliaRomana_Wine$color, quantile)

# wartosc min 
aggregateFunction(Bolonia_Wine$chlorides,  Bolonia_Wine$color, min)
aggregateFunction(Catania_Wine$chlorides,  Catania_Wine$color, min)
aggregateFunction(EmiliaRomana_Wine$chlorides,  EmiliaRomana_Wine$color, min)

# wartosc max
aggregateFunction(Bolonia_Wine$chlorides,  Bolonia_Wine$color, max)
aggregateFunction(Catania_Wine$chlorides,  Catania_Wine$color, max)
aggregateFunction(EmiliaRomana_Wine$chlorides,  EmiliaRomana_Wine$color, max)

# odchylenie standardowe 
aggregateFunction(Bolonia_Wine$chlorides,  Bolonia_Wine$color, sd)
aggregateFunction(Catania_Wine$chlorides,  Catania_Wine$color, sd) 
aggregateFunction(EmiliaRomana_Wine$chlorides,  EmiliaRomana_Wine$color, sd) 

# kurtoza
aggregateFunction(Bolonia_Wine$chlorides,  Bolonia_Wine$color, kurtosis)
aggregateFunction(Catania_Wine$chlorides,  Catania_Wine$color, kurtosis) 
aggregateFunction(EmiliaRomana_Wine$chlorides,  EmiliaRomana_Wine$color, kurtosis) 

# skosnosc - trzeci moment centralny
aggregateFunction(Bolonia_Wine$chlorides,  Bolonia_Wine$color, skewness)
aggregateFunction(Catania_Wine$chlorides,  Catania_Wine$color, skewness) 
aggregateFunction(EmiliaRomana_Wine$chlorides,  EmiliaRomana_Wine$color, skewness) 

### quality ----

# srednia
aggregateFunction(Bolonia_Wine$quality,  Bolonia_Wine$color, mean) 
aggregateFunction(Catania_Wine$quality,  Catania_Wine$color, mean)
aggregateFunction(EmiliaRomana_Wine$quality,  EmiliaRomana_Wine$color, mean)

# mediana 
aggregateFunction(Bolonia_Wine$quality,  Bolonia_Wine$color, median)
aggregateFunction(Catania_Wine$quality,  Catania_Wine$color, median)
aggregateFunction(EmiliaRomana_Wine$quality,  EmiliaRomana_Wine$color, median)

# kwantyle
aggregateFunction(Bolonia_Wine$quality,  Bolonia_Wine$color, quantile) 
aggregateFunction(Catania_Wine$quality,  Catania_Wine$color, quantile)
aggregateFunction(EmiliaRomana_Wine$quality,  EmiliaRomana_Wine$color, quantile)

# wartosc min 
aggregateFunction(Bolonia_Wine$quality,  Bolonia_Wine$color, min)
aggregateFunction(Catania_Wine$quality,  Catania_Wine$color, min)
aggregateFunction(EmiliaRomana_Wine$quality,  EmiliaRomana_Wine$color, min)

# wartosc max
aggregateFunction(Bolonia_Wine$quality,  Bolonia_Wine$color, max)
aggregateFunction(Catania_Wine$quality,  Catania_Wine$color, max)
aggregateFunction(EmiliaRomana_Wine$quality,  EmiliaRomana_Wine$color, max)

# odchylenie standardowe 
aggregateFunction(Bolonia_Wine$quality,  Bolonia_Wine$color, sd)
aggregateFunction(Catania_Wine$quality,  Catania_Wine$color, sd) 
aggregateFunction(EmiliaRomana_Wine$quality,  EmiliaRomana_Wine$color, sd) 

# kurtoza
aggregateFunction(Bolonia_Wine$quality,  Bolonia_Wine$color, kurtosis)
aggregateFunction(Catania_Wine$quality,  Catania_Wine$color, kurtosis) 
aggregateFunction(EmiliaRomana_Wine$quality,  EmiliaRomana_Wine$color, kurtosis) 

# skosnosc - trzeci moment centralny
aggregateFunction(Bolonia_Wine$quality,  Bolonia_Wine$color, skewness)
aggregateFunction(Catania_Wine$quality,  Catania_Wine$color, skewness) 
aggregateFunction(EmiliaRomana_Wine$quality,  EmiliaRomana_Wine$color, skewness) 


### citric.acid ----

# srednia
aggregateFunction(Bolonia_Wine$citric.acid,  Bolonia_Wine$color, mean) 
aggregateFunction(Catania_Wine$citric.acid,  Catania_Wine$color, mean)
aggregateFunction(EmiliaRomana_Wine$citric.acid,  EmiliaRomana_Wine$color, mean)

# mediana 
aggregateFunction(Bolonia_Wine$citric.acid,  Bolonia_Wine$color, median)
aggregateFunction(Catania_Wine$citric.acid,  Catania_Wine$color, median)
aggregateFunction(EmiliaRomana_Wine$citric.acid,  EmiliaRomana_Wine$color, median)

# kwantyle
aggregateFunction(Bolonia_Wine$citric.acid,  Bolonia_Wine$color, quantile) 
aggregateFunction(Catania_Wine$citric.acid,  Catania_Wine$color, quantile)
aggregateFunction(EmiliaRomana_Wine$citric.acid,  EmiliaRomana_Wine$color, quantile)

# wartosc min 
aggregateFunction(Bolonia_Wine$citric.acid,  Bolonia_Wine$color, min)
aggregateFunction(Catania_Wine$citric.acid,  Catania_Wine$color, min)
aggregateFunction(EmiliaRomana_Wine$citric.acid,  EmiliaRomana_Wine$color, min)

# wartosc max
aggregateFunction(Bolonia_Wine$citric.acid,  Bolonia_Wine$color, max)
aggregateFunction(Catania_Wine$citric.acid,  Catania_Wine$color, max)
aggregateFunction(EmiliaRomana_Wine$citric.acid,  EmiliaRomana_Wine$color, max)

# odchylenie standardowe 
aggregateFunction(Bolonia_Wine$citric.acid,  Bolonia_Wine$color, sd)
aggregateFunction(Catania_Wine$citric.acid,  Catania_Wine$color, sd) 
aggregateFunction(EmiliaRomana_Wine$citric.acid,  EmiliaRomana_Wine$color, sd) 

# kurtoza
aggregateFunction(Bolonia_Wine$citric.acid,  Bolonia_Wine$color, kurtosis)
aggregateFunction(Catania_Wine$citric.acid,  Catania_Wine$color, kurtosis) 
aggregateFunction(EmiliaRomana_Wine$citric.acid,  EmiliaRomana_Wine$color, kurtosis) 

# skosnosc - trzeci moment centralny
aggregateFunction(Bolonia_Wine$citric.acid,  Bolonia_Wine$color, skewness)
aggregateFunction(Catania_Wine$citric.acid,  Catania_Wine$color, skewness) 
aggregateFunction(EmiliaRomana_Wine$citric.acid,  EmiliaRomana_Wine$color, skewness) 

# Zadanie 2 ----

### Region - Bolonia ----
par(oma = c(2,1,1,1), mfrow = c(2, 2), mar = c(2, 2, 1, 1))
for (i in 1:4){
  boxplot(Bolonia_Wine$pH ~ Bolonia_Wine$color, col=c("purple", "green"), main = "pH Value")
  boxplot(Bolonia_Wine$alcohol ~ Bolonia_Wine$color, col=c("purple", "green"), main = "Alcohol Value") 
  boxplot(Bolonia_Wine$quality ~ Bolonia_Wine$color, col=c("purple", "green"), main = "Quality Value")
  boxplot(Bolonia_Wine$citric.acid ~ Bolonia_Wine$color, col=c("purple", "green"), main = "Citric Acid Value")
}
par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = 'l', main ="\n\nRegion - Bolonia", col.main="red", cex.main=1.3)
legend( x ="bottom", legend = c("Wino Czerwone","Wino Bia³e"), col=c("purple", "green"),
        lty=c(1,1), lwd=3, cex=0.9, horiz=T,  bty = "o")

### Region - Catania ----
par(oma = c(2,1,1,1), mfrow = c(2, 2), mar = c(2, 2, 1, 1))
for (i in 1:4){
  boxplot(Catania_Wine$pH ~ Catania_Wine$color, col=c("orange", "blue"), main = "pH Value")
  boxplot(Catania_Wine$alcohol ~ Catania_Wine$color, col=c("orange", "blue"), main = "Alcohol Value") 
  boxplot(Catania_Wine$quality ~ Catania_Wine$color, col=c("orange", "blue"), main = "Quality Value")
  boxplot(Catania_Wine$citric.acid ~ Catania_Wine$color, col=c("orange", "blue"), main = "Citric Acid Value")
}
par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = 'l', main ="\n\nRegion - Catania", col.main="red", cex.main=1.3)
legend( x ="bottom", legend = c("Wino Czerwone","Wino Bia³e"), col=c("orange", "blue"),
        lty=c(1,1), lwd=3, cex=0.9, horiz=T,  bty = "o")

### Region - Emilia Romana ----
par(oma = c(2,1,1,1), mfrow = c(2, 2), mar = c(2, 2, 1, 1))
for (i in 1:4){
  boxplot(Catania_Wine$pH ~ Catania_Wine$color, col=c("brown", "yellow"), main = "pH Value")
  boxplot(Catania_Wine$alcohol ~ Catania_Wine$color, col=c("brown", "yellow"), main = "Alcohol Value")
  boxplot(Catania_Wine$quality ~ Catania_Wine$color, col=c("brown", "yellow"), main = "Quality Value") 
  boxplot(Catania_Wine$citric.acid ~ Catania_Wine$color, col=c("brown", "yellow"), main = "Citric Acid Value")
}
par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = 'l', main ="\n\nRegion - Emilia Romana", col.main="red", cex.main=1.3)
legend( x ="bottom", legend = c("Wino Czerwone","Wino Bia³e"), col=c("brown", "yellow"),
        lty=c(1,1), lwd=3, cex=0.9, horiz=T,  bty = "o")

# Zadanie 3 ----

par(oma = c(2,1,1,1), mfrow = c(2, 2), mar = c(2, 2, 1, 1))
for (i in 1:4){
  boxplot(danewina$pH ~ danewina$region, col=c("brown", "yellow", "blue"), main = "pH Value",
          xlab="Color", ylab= "pH value")
  boxplot(danewina$chlorides ~ danewina$region, col=c("brown", "yellow", "blue"), main = "Chlorides Value",
          xlab="Color", ylab= "Chlorides value")
  boxplot(danewina$quality ~ danewina$region, col=c("brown", "yellow", "blue"), main = "Quality Value",
          xlab="Color", ylab= "Quality value")
  boxplot(danewina$citric.acid ~ danewina$region, col=c("brown", "yellow", "blue"), main = "Citric Acid Value",
          xlab="Color", ylab= "Citric Acid value")
  
}

# Zadanie 4 ----
### DOROBIC 1 WYKRES ----
par(mfrow=c(1,1))
plot(pH ~ sulphates, data = danewina[danewina$color == "white", ], col= "darkgrey", 
     ylim=range(danewina$pH), xlim=range(danewina$sulphates), pch= 1,
     main = "Scatter Plot - pH ~ Sulphates")
points(pH ~ sulphates, data = danewina[danewina$color == "red", ], col= "red", pch= 2)
grid()
legend( x ="topright", legend = c("White Wine","Red Wine"),
        title ="Type of Wine: ", box.lty = 3,
        col=c("darkgrey","red"), lty=c(1,1),
        lwd=3, cex=0.9, horiz=F, bty = "o")

par(mfrow=c(1,1))
plot(pH ~ alcohol, data = danewina[danewina$color == "white", ], col= "darkgrey", 
     ylim=range(danewina$pH), xlim=range(danewina$alcohol), pch= 1,
     main = "Scatter Plot - pH ~ Sulphates")
points(pH ~ alcohol, data = danewina[danewina$color == "red", ], col= "red", pch= 2)
grid()
legend( x ="topright", legend = c("White Wine","Red Wine"),
        title ="Type of Wine: ", box.lty = 3,
        col=c("darkgrey","red"), lty=c(1,1),
        lwd=3, cex=0.9, horiz=F, bty = "o")


# Zadanie 5 ----
### DOROBIC 1 WYKRES ----
unique(danewina$region)

par(mfrow=c(1,1))
plot(chlorides ~ sulphates, data = danewina[danewina$region == "Bolonia", ], col= "red", 
     ylim=range(danewina$chlorides), xlim=range(danewina$sulphates), pch= 1,
     main = "Scatter Plot - Chlorides ~ Sulphates")
points(chlorides ~ sulphates, data = danewina[danewina$region == "Catania", ], col= "blue", pch= 2)
points(chlorides ~ sulphates, data = danewina[danewina$region == "Emilia Romana", ], col= "green", pch= 3)
legend( x ="topleft", legend = c("Bolonia","Catania", "Emilia Romana"),
        title ="Region: ", box.lty = 2,
        col=c("red","blue", "green"), lty=c(1,1,1),
        lwd=3, cex=0.9, horiz=F, bty = "o")


par(mfrow=c(1,1))
plot(citric.acid ~ alcohol, data = danewina[danewina$region == "Bolonia", ], col= "red", 
     ylim=range(danewina$citric.acid), xlim=range(danewina$alcohol), pch= 1,
     main = "Scatter Plot - Chlorides ~ Sulphates")
points(citric.acid ~ alcohol, data = danewina[danewina$region == "Catania", ], col= "blue", pch= 2)
points(citric.acid ~ alcohol, data = danewina[danewina$region == "Emilia Romana", ], col= "green", pch= 3)
legend( x ="topleft", legend = c("Bolonia","Catania", "Emilia Romana"),
        title ="Region: ", box.lty = 2,
        col=c("red","blue", "green"), lty=c(1,1,1),
        lwd=3, cex=0.9, horiz=F, bty = "o")


# Zadanie 6 ----

### test dla sredniej ----

# dla ogolnych danych
wines_ttest <- t.test(x = danewina$pH, y= danewina$citric.acid, conf.level = 0.95)

# dla regionu Bolonia
winesB_ttest <- t.test(x = Bolonia_Wine$pH, y= Bolonia_Wine$citric.acid, conf.level = 0.95)

# dla regionu Catania
winesC_ttest <- t.test(x = Catania_Wine$pH, y= Catania_Wine$citric.acid, conf.level = 0.95)

# dla regionu Emilia Romana
winesER_ttest <- t.test(x = EmiliaRomana_Wine$pH, y= EmiliaRomana_Wine$citric.acid,conf.level = 0.95)

# Ramka danych dla przedzialu wariancji
meanintervaldf <- data.frame( c("ALL","Bolonia","Catania","Emilia Romana"),
                              c(round(wines_ttest$conf.int[1],5), round(winesB_ttest$conf.int[1],5),
                                round(winesC_ttest$conf.int[1],5), round(winesER_ttest$conf.int[1],5)),
                              c(round(wines_ttest$conf.int[2],5), round(winesB_ttest$conf.int[2],5),
                                round(winesC_ttest$conf.int[2],5), round(winesER_ttest$conf.int[2],5)))

names(meanintervaldf) <- c("Region:","Min","Max")

meanintervaldf

### test dla wariancji ---- 

# dla ogolnych danych
wines_vartest <- var.test(x = danewina$pH, y= danewina$citric.acid, conf.level =0.95)

# Dla regionu Bolonia
winesB_vartest <- var.test(x = Bolonia_Wine$pH, y= Bolonia_Wine$citric.acid, conf.level =0.95)

# Dla regionu Catania
winesC_vartest <- var.test(x = Catania_Wine$pH, y= Catania_Wine$citric.acid, conf.level =0.95)

# Dla regionu Emilia Romana
winesER_vartest <- var.test(x = EmiliaRomana_Wine$pH, y= EmiliaRomana_Wine$citric.acid, conf.level =0.95)

# Ramka danych dla przedzialu wariancji
varintervaldf <- data.frame( c("ALL","Bolonia","Catania","Emilia Romana"),
                             c(round(wines_vartest$conf.int[1],5), round(winesB_vartest$conf.int[1],5),
                               round(winesC_vartest$conf.int[1],5), round(winesER_vartest$conf.int[1],5)),
                             c(round(wines_vartest$conf.int[2],5), round(winesB_vartest$conf.int[2],5),
                               round(winesC_vartest$conf.int[2],5), round(winesER_vartest$conf.int[2],5)))

names(varintervaldf) <- c("Region:","Min","Max")

varintervaldf

# Zadanie 7 ----

# ogolne dane
t.test(x = danewina$sulphates, 
       mu = mean(danewina$sulphates.after.filtering), 
       conf.level = 0.95)

# wino biale
t.test(x = danewina$sulphates[danewina$color == "white"], 
       mu = mean(danewina$sulphates.after.filtering), 
       conf.level = 0.95)

# wino czerwone
t.test(x = danewina$sulphates[danewina$color == "red"], 
       mu = mean(danewina$sulphates.after.filtering), 
       conf.level = 0.95)

## we wszystkich przypadkach mamy podstawy do odrzucenia hipotezyy zerowej mowiacej ze srednia 
# bez filtracji jest rowna sredniej z filtracja. 

# Zadanie 8 ----
t.test(danewina$sulphates[danewina$color == "white"], danewina$sulphates[danewina$color == "red"], 
       conf.level = 0.95)

t.test(danewina$pH[danewina$color == "white"], danewina$pH[danewina$color == "red"], 
       conf.level = 0.95)

t.test(danewina$alcohol[danewina$color == "white"], danewina$alcohol[danewina$color == "red"], 
       conf.level = 0.95)

t.test(x = danewina$citric.acid[danewina$color == "white"], danewina$citric.acid[danewina$color == "red"], 
       conf.level = 0.95)

t.test(x = danewina$quality[danewina$color == "white"], danewina$quality[danewina$color == "red"], 
       conf.level = 0.95)

# Zadanie 9 ----
var.test(danewina$quality[danewina$color=="red"], danewina$quality[danewina$color== "white"])

var.test(danewina$pH[danewina$color=="red"], danewina$pH[danewina$color== "white"])

var.test(danewina$chlorides[danewina$color=="red"], danewina$chlorides[danewina$color== "white"])

var.test(danewina$sulphates[danewina$color=="red"], danewina$sulphates[danewina$color== "white"])

var.test(danewina$density[danewina$color=="red"], danewina$density[danewina$color== "white"])

### Do wnioskow:
### Wartoœæ p dla testu F wynosi p = 0,2331433 i jest wiêksza od poziomu istotnoœci 0,05. 
### Podsumowuj¹c, nie ma istotnej ró¿nicy pomiêdzy obiema wariancjami.

# Zadanie 10 ----

# Catania - Bolonia
t.test(Catania_Wine$sulphates, Bolonia_Wine$sulphates)
t.test(Catania_Wine$pH, Bolonia_Wine$pH)
t.test(Catania_Wine$alcohol, Bolonia_Wine$alcohol) 
t.test(Catania_Wine$citric.acid, Bolonia_Wine$citric.acid)
t.test(Catania_Wine$quality, Bolonia_Wine$quality)

# Catania - Emilia Romana
t.test(Catania_Wine$sulphates, EmiliaRomana_Wine$sulphates)
t.test(Catania_Wine$pH, EmiliaRomana_Wine$pH)
t.test(Catania_Wine$alcohol, EmiliaRomana_Wine$alcohol) 
t.test(Catania_Wine$citric.acid, EmiliaRomana_Wine$citric.acid)
t.test(Catania_Wine$quality, EmiliaRomana_Wine$quality)

# Emilia Romana - Bolonia
t.test(EmiliaRomana_Wine$sulphates, Bolonia_Wine$sulphates)
t.test(EmiliaRomana_Wine$pH, Bolonia_Wine$pH)
t.test(EmiliaRomana_Wine$alcohol, Bolonia_Wine$alcohol) 
t.test(EmiliaRomana_Wine$citric.acid, Bolonia_Wine$citric.acid)
t.test(EmiliaRomana_Wine$quality, Bolonia_Wine$quality)

## Zadanie 11 ----
## Do dlaszej analizy potrzebujemy danych numeric
wine_numeric <- select_if(danewina, is.numeric)

# oczyszczenie danych z brakow danych
(res <- as.data.frame(cor(na.omit(wine_numeric))))

## korelacja z innnymi parametrami
ggcorrplot(res, hc.order= T, type= "lower", outline.color = "white", lab= T)

# Zaleznosc od rodzaju wina
freqcolordf <- data.frame(table(danewina$quality[danewina$color=="white"]),
           table(factor(danewina$quality[danewina$color=="red"], levels=3:9)))

freqcolordf <- freqcolordf[,c(2,4)]
names(freqcolordf) <- c("white","red")
rownames(freqcolordf) <- 3:9
freqcolordf

nrow(danewina[danewina$color=="red",])
nrow(danewina[danewina$color=="white",])

## Badanie testem niezaleznosci chi kwadrat
chisq.test(unlist(danewina$quality[danewina$color=="red"]),unlist(danewina$quality[danewina$color=="red"]))

# Hipoteza zerowa: badane dane sa niezalezne
# p wartosc mala dlatego odrzucamy hipoteze zerowa i sklaniamy sie ku hipotezie alternatywnej
# Wynik sugeruje ze istnieje statystyczne powiazanie pomiedzy kolorem wina a jego jakoscia


# Zaleznosc od regionu pochodzenia
qualCat <- as.data.frame(table(Catania_Wine$quality))
qualBol <- as.data.frame(table(Bolonia_Wine$quality))
qualEmiR <- as.data.frame(table(EmiliaRomana_Wine$quality))

qualData <- qualCat
qualData <- cbind(qualData, qualBol$Freq)
qualData <- cbind(qualData, qualEmiR$Freq)

row.names(qualData) <- qualData$Var1
qualData <- qualData[,2:4]
names(qualData) <- c("Catania","Bolonia","Emilia Romana")
qualData

barplot(t(qualData[c("Catania", "Bolonia", "Emilia Romana")]),
        beside= T, ylab= "Frequency", xlab= "Quality")
grid()
barplot(t(qualData[c("Catania", "Bolonia", "Emilia Romana")]),
        beside= T, ylab= "Frequency", xlab= "Quality", add = T, 
        col= c("deeppink","pink2", "pink4"))
box()
legend(x ="topright", legend = c("Bolonia","Catania", "Emilia Romana"),
        title ="Region: ", box.lty = 2,
        col= c("deeppink","pink2", "pink4"), lty=c(1,1,1),
        lwd=3, cex=0.9, horiz=F, bty = "o")

# nowa ramka danych 

## Funkcja zamiany wartosci na procenty w zaleznosci od wierszy
percentSumRows <- function(x){
  
  percentqualData <- data.frame(matrix(NA, ncol = ncol(x)))
  
  for (i in 1:nrow(x)){
    percentqualData <- rbind(percentqualData, paste0(round(as.numeric(x[i,]/rowSums(x[i,]))*100,1),"%"))
  }
  
  ## Wynik procentowy jakosci wina z podzialem na regiony
  percentqualData <- percentqualData[2:8,]
  row.names(percentqualData) <- row.names(x)
  names(percentqualData) <- names(x)
  return(percentqualData)
}

percentSumRows(qualData)


