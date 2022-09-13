library(tsbox)
library(TSstudio)
library(forecast)

setwd("C:/Users/macie/Desktop/Dokumenty")

## I. Wczytanie danych ####
## 1) Dane 1
## 2) Dane 2 
dane1 <- read.csv2("Poland2.csv", sep=",", header = T)
dane2 <- read.csv2("owoce.csv", sep=",", header = T)
colnames(dane1) <- c("Data", "Wartosc")
colnames(dane2) <- c("Data", "Cena_[tona]")

dane1
dane2

dane1$Wartosc <- round(as.numeric(dane1$Wartosc),1)
dane2$`Cena_[tona]` <- round(as.numeric(dane2$`Cena_[tona]`),1)

## Ograniczenie danych ####
## 1) Dane1 ----
dane1 <- ts(dane1$Wartosc, start=c(2010,1), frequency = 12)
dane1 <- window(dane1, start = c(2010,1), end = c(2020,12))

## 2) Dane2 ----
dane2 <- ts(dane2$`Cena_[tona]`, start=c(2000,1), frequency = 12)
dane2 <- window(dane2, start = c(2000,1), end = c(2020,12))

dane1
dane2

## II. Wykresy ####
## a) Wykres podstawowy -----
## 1) Dane1 
plot(dane1, main="Zharmonizowany Indeks Cen Konsumpcyjnych:
Pakiety wypoczynkowe dla Polski")
## 2) Dane2 
plot(dane2, main="Wskaznik cen konsumpcyjnych (owoce, warzywa) w USA")

## b) Sezonowosc na wykresach ------
## 1) Dane1 
ts_seasonal(dane1, type="cycle")
ts_seasonal(dane1, type="box")
## 2) Dane2 
ts_seasonal(dane2, type="cycle")
ts_seasonal(dane2, type="box")

# c) wykres sezonowy -----
seasonplot(dane1, col = rainbow(12), year.labels = TRUE, pch = 19,
           main = "Wykres sezonowosci Dane1") 
seasonplot(dane2, col = rainbow(12), year.labels = TRUE, pch = 19,
           main = "Wykres sezonowosci Dane2") 

## d) Wykres rozrzutu -----
lag.plot(dane1, lags= 12, do.lines = F,
         main= "Wykres rozrzutu Dane1")
lag.plot(dane2, lags=12, do.lines = F,
         main = "Wykres rozrzutu Dane2")

## e) Wykres miesieczny ------
monthplot(dane1, main= "Wykres miesieczny Dane1")
monthplot(dane2, main= "Wykres miesieczny Dane2")

## Wniosek 1 - jest sezonowosc dla Dane1 - (Lipiec i Sierpien maja najwyzsze wartosci)
## Wniosek 2 - nie ma wyraznej sezonowosci dla Dane2

# III. Dekompozycja ####
#1) Normalna ----
dane1PD <- decompose(dane1)
plot(dane1PD)

dane2PD <- decompose(dane2)
plot(dane2PD)

#Korelogramy ACF i PACF
tsdisplay(dane1)
tsdisplay(dane2)

## ACF - dodatnie i powoli opadajace - dane zawierajaja deterministyczna skladowa trendu
## ACF - zanikaja powoli i sa cykliczne - obecnosc sezonowosci - trend sezonowy
## PACF - duza wartosc dla lag= 1 - obecnosc silnego trendu wzrostowego

#2) Srednia ruchoma ----
#dekompozycja - ruchoma srednia
#dane2 - sezonowosc
dane1.6 <- filter(dane1, sides = 2, filter = rep(1/6,6))
dane1.12 <- filter(dane1, sides = 2, filter = rep(1/12,12))
plot(dane1, main = "Wygladzanie -  ruchoma srednia", lwd=1.6)
lines(dane1.6, col = "red", lty = 5, lwd= 2.5)
lines(dane1.12, col = "blue", lty = 4, lwd= 3)
legend("topleft", legend=c("Dane1", "Dane1 (1/6,6)", "Dane1 (1/12,12)"), 
       col= c("black", "red", "blue"), lty=c(1,2))

## Uwaga: Dekompozycja sredniej ruchomej moze byc przeprowadzana w przypadku danych okresowych
## lub takich gdzie podejrzewamy wystepowanie sezonowosci

## Wniosek: 12msc srednia kroczaca wskazuje na tendencje wzrostowa (kolor niebieski)
## 6msc srednia kroczaca wskazuje na istnienie skladnika sezonowego (kolor czerwony)

#3) Regresja ----
#dekompozycja na podstawie modelu regresji liniowej: trend liniowy

#a) tylko trend liniowy ----
dane2Trend <- tslm(dane2 ~ trend) 
sumTrend <- summary(dane2Trend)
sumTrend$adj.r.squared
plot(dane2, main="Model regresji liniowej")
lines(fitted(dane2Trend), col="red", lty=2, lwd= 2.5)
legend("topleft", legend=c("Dane2", "Model trendu"), col= c("black", "red"),
       lty=c(1,2))
#reszty
tsdisplay(residuals(dane2Trend), main="Reszty (trend liniowy)")

# b) trend + sezonowosc ----
dane2TrendS <- tslm(dane2 ~ trend + season)
sumTrendS <- summary(dane2TrendS)
sumTrendS$adj.r.squared
plot(dane2, main="Model regresji liniowej: trend + sezonowosc")
lines(fitted(dane2TrendS), col="blue", lty=2, lwd= 2.5)
legend("topleft", legend=c("Dane2", "Model trendu"), col= c("black", "blue"),
       lty=c(1,2))
#reszty
tsdisplay(residuals(dane2TrendS), main="Reszty (trend + sezonowosc)")

# c) Box-Cox transformacja ----
dane2TrendSLog <- tslm(dane2 ~ trend + season, lambda = 0)
sumTrendSLog <- summary(dane2TrendSLog)
sumTrendSLog$adj.r.squared
plot(dane2, main="Model regresji liniowej po transormacji Boxa-Coxa")
lines(fitted(dane2TrendSLog), col="green", lty=2, lwd= 2.5)
legend("topleft", legend=c("Dane2", "Model trendu"), col= c("black", "green"),
       lty=c(1,2))
#reszty
tsdisplay(residuals(dane2TrendSLog), main="Reszty (transformacja Boxa-Coxa)")

# d) wielowymiarowy ----
dane2TrendSLog2 <- tslm(dane2 ~ season + poly(trend, raw= T, degree = 2), lambda = 0)
sumTrendSLog2 <- summary(dane2TrendSLog2)
sumTrendSLog2$adj.r.squared
plot(dane2, main="Model regresji kwadratowej po transormacji Boxa-Coxa")
lines(fitted(dane2TrendSLog2), col="red", lty=2, lwd= 2.5)
legend("topleft", legend=c("Dane2", "Model trendu"), col= c("black", "red"),
       lty=c(1,2))
#reszty
tsdisplay(residuals(dane2TrendSLog2), main="Reszty - Funkcja kwadratowa - (transformacja Boxa-Coxa)")

# Wnioski:

## IV. Eliminacja trendu/sezonowosci ####
dane1.multi <- decompose(dane1, "multiplicative")
dane1.odsezonowane <- seasadj(dane1.multi)
plot(dane1, main="Szereg oryginalny i odsezonowany")
lines(dane1.odsezonowane, col="red", lty=2, lwd= 2.5)
legend("topleft", legend=c("Dane oryginalne", "Dane odsezonowane"), col= c("black", "red"),
       lty=c(1,2))

## V. Stacjonarnosc ####
tsdisplay(dane1)

dane1.log <- BoxCox(x=dane1, lambda=0)
#tsdisplay(data_sL)

dane1.log.diff <- diff(dane1.log, lag = 1)
#tsdisplay(data_sLS)
dane1.log.diff2 <- diff(dane1.log.diff, lag = 12)
tsdisplay(dane1.log.diff2)

## Wniosek: Tutaj jest szum bialy

dane2.log <- BoxCox(x = dane2, lambda = 0)
dane2.log.diff <- diff(dane2.log)
#tsdisplay(dane2)
#tsdisplay(dane2.log)
#tsdisplay(dane2.log.diff)
dane2.log.diff2 <- diff(dane2.log.diff, lag=12)
tsdisplay(dane2.log.diff2, lag.max= 100)

# Wniosek: Tutaj nie ma szumu bialego

## Wniosek do Dane2: rzad modelu AR(p) nalepiej to - AR(36), AR(12), AR()
## Dane1: rzad modelu MA(q) to najlepiej to - MA(46)


## __Rzad modeli__ ####
## Dane 2
## rzad modelu wybierany przez nas na oko
dane2_manual_yw <- ar(x = dane2.log.diff2, aic = F, order.max = 36, method = "yule-walker" )
dane2_manual_mle <- ar(x = dane2.log.diff2, aic = F, order.max = 36, method = "mle" )

dane2_manual_yw$ar
dane2_manual_mle$ar

### automatycznie wybierany rzad modelu
dane2_auto_yw<- ar(x = dane2.log.diff2, aic = T, order.max= 100, method = "yule-walker")
dane2_auto_mle <- ar(x = dane2.log.diff2, aic = T, order.max=36 ,method = "mle")

dane2_auto_yw$ar
dane2_auto_mle$ar

## Wniosek: Tutaj rzad wybrany na oko przeze mnie okazal sie byc tym opytmalnym 
##- patrzylem na ostatnia wartosc na wykresu PACF

### Dane 1
tsdisplay(dane1.log.diff2)

## rzad modelu wybierany przez nas na oko
dane1_manual_yw1 <- ar(x = dane1.log.diff2, aic = F, order.max = 12, method = "yule-walker" )
dane1_manual_mle1 <- ar(x = dane1.log.diff2, aic = F, order.max = 12, method = "mle" )

dane1_manual_yw1$ar
dane1_manual_mle1$ar

### automatycznie wybierany rzad modelu
dane1_auto_yw1<- ar(x = dane1.log.diff2, aic = T, order.max= 100, method = "yule-walker")
dane1_auto_mle1 <- ar(x = dane1.log.diff2, aic = T, method = "mle")

dane1_auto_yw1$ar
dane1_auto_mle1$ar

## VI. Wyznaczenie optymalnych modeli #### 
## Funkcja auto.arima()

## Dane 1
dane1.arimaAIC <- auto.arima(dane1, ic="aic")
summary(dane1.arimaAIC)

dane1.arimaAICC <- auto.arima(dane1, ic="aicc")
summary(dane1.arimaAICC)

dane1.arimaBIC <- auto.arima(dane1, ic="bic")
summary(dane1.arimaBIC)

## Wniosek: Obojetnie ktory model wybierzemy - wszystkie wartosci sa takie same (nie ma minimalnych)

## Dane 2
dane2.arimaAIC <- auto.arima(dane2, ic="aic")
summary(dane2.arimaAIC)

dane2.arimaAICC <- auto.arima(dane2, ic="aicc")
summary(dane2.arimaAICC)

dane2.arimaBIC <- auto.arima(dane2, ic="bic")
summary(dane2.arimaAIC)

## Wniosek: Wybieramy model AIC - najmniejsze wartosci RMSE, MAE, MAPE, MASE


## VII. Prognozowanie ####
## a) Naiwne -----
## Dane 1 
prognoza1 <- meanf(dane1, h=24)
accuracy(prognoza1)
prognoza2 <- meanf(dane1, h=24, lambda = 0)
accuracy(prognoza2)
prognoza3 <- naive(dane1, h=24, lambda = 0)
accuracy(prognoza3)
prognoza4 <- snaive(dane1, h=24, lambda = 0)
accuracy(prognoza4)
prognoza5 <- rwf(dane1, h=24, drift = T) 
accuracy(prognoza5)

## Wniosek: Dane1 - najlepsza prognoza jest prognoza5 (metoda bladzenia losowego z dryfem)
## poniewaz kryteria RMSE, MAE, MAPE, MASE sa najmniejsze w porownaniu z innymi kryteriami w innych prognozach

par(mfrow = c(3,2))
plot(prognoza1, main="PROGNOZA: Metoda na podstawie sredniej")
plot(prognoza2, main="PROGNOZA: Metoda na podstawie sredniej
     lamba = 0")
plot(prognoza3, main="PROGNOZA: Metoda naiwna")
plot(prognoza4, main="PROGNOZA: Metoda naiwna sezonowa")
plot(prognoza5, main="PROGNOZA: Metoda uwzgledniajaca dryf")


## Dane 2 
prognoza11 <- meanf(dane2, h=24)
accuracy(prognoza1)
prognoza22 <- meanf(dane2, h=24, lambda = 0)
accuracy(prognoza2)
prognoza33 <- naive(dane2, h=24, lambda = 0)
accuracy(prognoza3)
prognoza44 <- snaive(dane2, h=24, lambda = 0)
accuracy(prognoza4)
prognoza55 <- rwf(dane2, h=24, drift = T) 
accuracy(prognoza5)

## Wniosek: Dane1 - najlepsza prognoza jest prognoza5 (metoda bladzenia losowego z dryfem)
## poniewaz kryteria RMSE, MAE, MAPE, MASE sa najmniejsze w porownaniu z innymi kryteriami w innych prognozach

par(mfrow = c(3,2))
plot(prognoza11, main="PROGNOZA: Metoda na podstawie sredniej")
plot(prognoza22, main="PROGNOZA: Metoda na podstawie sredniej
     lamba = 0")
plot(prognoza33, main="PROGNOZA: Metoda naiwna")
plot(prognoza44, main="PROGNOZA: Metoda naiwna sezonowa")
plot(prognoza55, main="PROGNOZA: Metoda uwzgledniajaca dryf")







## b) Zbiory: testowy i uczacy ----
## Wykorzystany szereg 1

dane1.train <- window(dane1, end=c(2018,12))
dane1.test <- window(dane1, start=c(2019,1))
length(dane1.train); length(dane1.test)

prognoza1.train <- meanf(dane1.train, h =24)
prognoza2.train <- meanf(dane1.train, h =24, lambda=0)
prognoza3.train <- naive(dane1.train, h =24, lambda=0)
prognoza4.train <- snaive(dane1.train, h =24, lambda=0)
prognoza5.train <- rwf(dane1.train, h =24, drift=T)

zakres.y <- c(0.95, 1.05)*range(dane1, dane1.test)

accuracy(prognoza1.train)
accuracy(prognoza2.train)
accuracy(prognoza3.train)
accuracy(prognoza4.train)
accuracy(prognoza5.train)

## Wniosek: Dane2 - najlepsza prognoza jest prognoza5 (metoda bladzenia losowego z dryfem)
## poniewaz kryteria RMSE, MAE, MAPE, MASE sa najmniejsze w porownaniu z innymi kryteriami w innych prognozach

par(mfrow = c(3,2))
plot(prognoza1.train, ylim=zakres.y, main="PROGNOZA: Metoda na podstawie sredniej")
lines(dane1.test, col="red", lty=1, lwd=3)
plot(prognoza2.train, ylim=zakres.y, main="PROGNOZA: Metoda na podstawie sredniej
     lamba = 0")
lines(dane1.test, col="red", lty=1, lwd=3)
plot(prognoza3.train, ylim=zakres.y, main="PROGNOZA: Metoda naiwna")
lines(dane1.test, col="red", lty=1, lwd=3)
plot(prognoza4.train, ylim=zakres.y, main="PROGNOZA: Metoda naiwna sezonowa")
lines(dane1.test, col="red", lty=1, lwd=3)
plot(prognoza5.train, ylim=zakres.y, main="PROGNOZA: Metoda uwzgledniajaca dryf")
lines(dane1.test, col="red", lty=1, lwd=3)

## Wniosek: Dane2 - najlepsza prognoza jest prognoza5 (metoda bladzenia losowego z dryfem)
## poniewaz kryteria RMSE, MAE, MAPE, MASE sa najmniejsze w porownaniu z innymi kryteriami w innych prognozach

# przywrocenie ustawien
par(mfrow= c(1,1)) 

