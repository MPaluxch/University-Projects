## Porownanie algorytmow optymalizacji funkcji jednej zmiennej min i max

# 1) Algorytm Golden
# 2) Algorytm Ternery
# 3) Algorytm Fibonacci
# 4) Gradientowy

#### Wyszukiwanie min ####

# Funkcja 
funkcja <- function(x){
  x^3-4*x^2+6*x-sin(x)*cos(x)^2*exp(x)
}

draw_plot <- function(x){
  if (x == 0){
plot(funkcja, xlim=c(0,3), pch=19, type="b")
title(main = "Wykres funkcji \n + przedzialy poszukiwan Min/Max")
abline(v=c(1.5, 3), col="red", lwd= 2.5, lty= 2)
abline(v=c(1, 2), col="blue", lwd= 2.5, lty= 2)
legend(0,6.3, legend = c("x^3-4*x^2+6*x-sin(x)*cos(x)^2*e^x",  "Przedzial Min < 1.5 ; 3.0 >", "Przedzial Max < 1.0 ; 2.0 >"), 
       lty=c(1,2,2), cex = 1.2, col=c("black", "red", "blue"), box.lty = 0)
  }
  else {
    plot(funkcja, xlim=c(0,3), pch=19, type="b")
    title(main = "Wykres funkcji \n + przedzialy poszukiwan Min/Max")
    abline(v=c(1.5, 3), col="red", lwd= 2.5, lty= 2)
    abline(v=c(1, 2), col="blue", lwd= 2.5, lty= 2)
    points(lagrange_max, funkcja(lagrange_max), col="blue", pch= 19, lwd=10)
    points(golden_min, funkcja(golden_min), col="red", pch= 19, lwd=10)
    legend(0,6.3, legend = c("x^3-4*x^2+6*x-sin(x)*cos(x)^2*e^x", "Przedzial Min < 1.5 ; 3.0 >", "Przedzial Max < 1.0 ; 2.0 >"), 
           lty=c(1,2,2), cex = 1.2, col=c("black", "red", "blue"), box.lty = 0)
  }
}

draw_plot(0)

draw_plot2 <- function(x){
  if( x==0 ){
plot(funkcja, xlim=c(1.5,3), pch=19, type="b")
     title(main = "Wykres funkcji \n + przedzial poszukiwan Min")
     abline(v=c(1.5, 3), col="red", lwd= 2.5, lty= 2)
     legend(1.5,6.3, legend = c("x^3-4*x^2+6*x-sin(x)*cos(x)^2*e^x", "Przedzial Min < 1.5 ; 3.0 >"), 
            lty=c(1,2), cex = 1.2, col=c("black", "red"), box.lty = 0)
  }
  else {
    plot(funkcja, xlim=c(1.5,3), pch=19, type="b")
    title(main = "Wykres funkcji \n + przedzial poszukiwan Min")
    abline(v=c(1.5, 3), col="red", lwd= 2.5, lty= 2)
    abline(v=golden_min, col="darkorchid3", lwd= 1.5, lty= 2)
    abline(h=funkcja(golden_min), col="darkorchid3", lwd= 1.5, lty= 2)
    points(points(golden_min, funkcja(golden_min), col="darkorchid3", pch= 19, lwd=10))
    text(golden_min, funkcja(golden_min)+0.75, "Wartosc X Min", cex=1.2 ,col = "darkorchid3")
    text(golden_min, funkcja(golden_min)+0.45, round(golden_min, 3), cex=1.2, col = "darkorchid3")
    legend(1.5,6.3, legend = c("x^3-4*x^2+6*x-sin(x)*cos(x)^2*e^x", "Przedzial Min < 1.5 ; 3.0 >"), 
           lty=c(1,2), cex = 1.2, col=c("black", "red"), box.lty = 0)
  }
}

draw_plot3 <- function(x){
  if( x==0 ){
    plot(funkcja, xlim=c(1,2), pch=19, type="b")
    title(main = "Wykres funkcji \n + przedzial poszukiwan Max")
    abline(v=c(1, 2), col="blue", lwd= 2.5, lty= 2)
    legend(1,3.4, legend = c("x^3-4*x^2+6*x-sin(x)*cos(x)^2*e^x", "Przedzial Max < 1.0 ; 2.0 >"), 
           lty=c(1,2), cex = 1.2, col=c("black", "blue"), box.lty = 0)
  }
  else {
    plot(funkcja, xlim=c(1,2), pch=19, type="b")
    title(main = "Wykres funkcji \n + przedzial poszukiwan Max")
    abline(v=c(1, 2), col="blue", lwd= 2.5, lty= 2)
    abline(v=lagrange_max, col="darkorchid3", lwd= 1.5, lty= 2)
    abline(h=funkcja(lagrange_max), col="darkorchid3", lwd= 1.5, lty= 2)
    points(points(lagrange_max, funkcja(lagrange_max), col="darkorchid3", pch= 19, lwd=10))
    text(lagrange_max, funkcja(lagrange_max)-0.1, "Wartosc X Max", cex=1.2 ,col = "darkorchid3")
    text(lagrange_max, funkcja(lagrange_max)-0.2, round(lagrange_max, 3), cex=1.2, col = "darkorchid3")
    legend(0.99,3.4, legend = c("x^3-4*x^2+6*x-sin(x)*cos(x)^2*e^x", "Przedzial Max < 1.0 ; 2.0 >"), 
           lty=c(1,2), cex = 1.2, col=c("black", "blue"), box.lty = 0)
  }
}


## Wykres rozszerzony o granice przeszukiwania przedzialu
draw_plot2(0)
draw_plot3(0)

## minimalna wartosc z wykresu  - (index min wartosci)
wykres$x[which.min(wykres$y)]

# 1) Algorytm Golden

## golden
golden <- function(f,lower, upper, tol){
  licznik <- 0
  alpha <- (sqrt(5)-1)/2
  x1 <- alpha * lower + (1-alpha) * upper
  f.x1 <- f(x1)
  x2 <- (1-alpha) * lower + alpha * upper
  f.x2 <- f(x2)
  while(abs(upper - lower) > 2 * tol){
    if (f.x1 < f.x2){
      upper <- x2
      x2 <- x1
      f.x2 <- f.x1
      x1 <- alpha * lower + (1-alpha) * upper
      f.x1 <- f(x1)
    } else {
      lower <- x1
      x1 <- x2
      f.x1 <- f.x2
      x2 <- (1-alpha) * lower + alpha * upper
      f.x2 <- f(x2)
    }
    licznik <- licznik +1
    cat("Liczba iteracji: ", licznik, "\n", "a=", lower, "c=", x1, "d=", x2, "b=", upper, "\n")
  }
  
  return((lower + upper) / 2)
}  

golden_min <- golden(funkcja, 1.5, 3, 0.0001)
golden_min

## Golden max
goldenmax <- function(f,lower, upper, tol){
  licznik <- 0
  alpha <- (sqrt(5)-1)/2
  x1 <- alpha * lower + (1-alpha) * upper
  f.x1 <- f(x1)
  x2 <- (1-alpha) * lower + alpha * upper
  f.x2 <- f(x2)
  while(abs(upper - lower) > 2 * tol){
    if (f.x1 > f.x2){
      upper <- x2
      x2 <- x1
      f.x2 <- f.x1
      x1 <- alpha * lower + (1-alpha) * upper
      f.x1 <- f(x1)
    } else {
      lower <- x1
      x1 <- x2
      f.x1 <- f.x2
      x2 <- (1-alpha) * lower + alpha * upper
      f.x2 <- f(x2)
    }
    licznik <- licznik +1
    cat("Liczba iteracji: ", licznik, "\n", "a=", lower, "c=", x1, "d=", x2, "b=", upper, "\n")
  }
  
  return((lower + upper) / 2)
}  

golden_max <- goldenmax(funkcja, 1, 2, 0.0001)
golden_max

# 2) Algorytm Ternery

## ternary min
ternary <- function(f, lower, upper, tol) {
  licznik <- 0
  f.lower <- f(lower)
  f.upper <- f(upper)
  while (abs(upper - lower) > 2 * tol) {
    x1 <- (2 * lower + upper) / 3 ## srednia wazona przy poczatku
    f.x1 <- f(x1)
    x2 <- (lower + 2 * upper) / 3 ## srednia wazona przy koncu
    f.x2 <- f(x2)
    if (f.x1 < f.x2) { ## wartosc c i wartosc d
      upper <- x2
      f.upper <- f.x2
    } else {
      lower <- x1
      f.lower <- f.x1
    }
    licznik <- licznik + 1
    cat("Liczba iteracji: ", licznik, "\n", "a=", lower, "c=", x1, "d=", x2, "b=", upper, "\n")
  }
  
  return((upper + lower) / 2)
} 

ternary_min <- ternary(funkcja, 1.5, 3, 0.0001)
ternary_min

## ternary max
ternarymax <- function(f, lower, upper, tol) {
  licznik <- 0
  f.lower <- f(lower)
  f.upper <- f(upper)
  while (abs(upper - lower) > 2 * tol) {
    x1 <- (2 * lower + upper) / 3 ## srednia wazona przy poczatku
    f.x1 <- f(x1)
    x2 <- (lower + 2 * upper) / 3 ## srednia wazona przy koncu
    f.x2 <- f(x2)
    if (f.x1 > f.x2) { ## wartosc c i wartosc d
      upper <- x2
      f.upper <- f.x2
    } else {
      lower <- x1
      f.lower <- f.x1
    }
    licznik <- licznik + 1
    cat("Liczba iteracji: ", licznik, "\n", "a=", lower, "c=", x1, "d=", x2, "b=", upper, "\n")
  }
  
  return((upper + lower) / 2)
}  

ternary_max <- ternarymax(funkcja, 1, 2, 0.0001)
ternary_max

# 3) Algorytm Lagrangea

# Lagrange min
lagrange <- function(f,lower, upper, tol, tol_d){
  licznik <- 0
  d <- lower
  old.d <- upper
  c <- (lower + upper)/2
  f.c <- f(c)
  d <- (1/2) * (f(lower) * (c^2 - upper^2) + f.c * (upper^2 - lower^2)
                + f(upper) * (lower^2 - c^2)) / (f(lower) * (c - upper)
                                                 + f.c * (upper - lower) + f(upper) * (lower - c))
  f.d <- f(d)
  while((abs(upper - lower) > tol) && (abs(old.d - d) > tol_d)){
    if ((lower < d) && (d < c)) {
      if (f.d < f.c) {
        upper <- c 
        c <- d
        f.c <- f.d
      } else {
        lower <- d
      } 
    } else if ((c < d) && (d < upper)) {
      if (f.d < f.c) {
        lower <- c
        c <- d
        f.c <- f.d
      } else {
        upper <- d
      } 
    } else {stop("Algorytm nie jest zbie¿ny") 
    }
    old.d <- d
    d <- (1/2) * (f(lower) * (c^2 - upper^2) + f.c * (upper^2 - lower^2)
                  + f(upper) * (lower^2 - c^2)) / (f(lower) * (c - upper)
                                                   + f.c * (upper - lower) + f(upper) * (lower - c))
    f.d <- f(d)
    licznik <- licznik + 1
    cat("Liczba iteracji: ", licznik, "\n", "a=", lower, "c=", c, "d=", d, "b=", upper, "\n")
  } 
  return(d)
}

## Lagrange max
lagrangeMax <- function(f,lower,upper,tol, tol_d){
  mf <- function(x){
    -1*f(x)
  }  
  max <- lagrange(mf,lower,upper,tol, tol_d)
  cat("Max:",max, "Wartosc:", f(max))
  return(max)
}

lagrange_min <- lagrange(funkcja, 1.5, 3, 0.0001, 0.00001)
lagrange_min

lagrange_max <- lagrangeMax(funkcja, 1, 2, 0.001, 0.00001)
lagrange_max

# 5) Algorytm Gradientowy - Bisekcja
bisection <- function(df, lower, upper, tol) {
  licznik <- 0
  while (upper - lower > 2 * tol) {
    m <- (lower + upper) / 2
    df.m <- df(m)
    while (df.m == 0) {
      m <- (lower + upper) / 2 + runif(1, -tol, tol)
      df.m <- df(m)
    }
    if (df.m < 0) {
      lower <- m
    } else {
      upper <- m
    }
    licznik <- licznik + 1
    cat("Liczba iteracji: ", licznik, "\n", "Poczatek przedzialu: ", lower, "\n", "Srodek przedzialu: ", 
        m , "\n ", "Wart pochodnej: ", df.m, "\n","Koniec przedzialu: ", upper, "\n" , "\n")
  }
  return((upper + lower) / 2)
}


pochodna_funkcji <- function(x){
  3*x^2-8*x+6-exp(x)*cos(x)^3+exp(x)*sin(x)*sin(2*x)-exp(x)*cos(x)^2*sin(x)
}

pochodna_funkcji_minus <- function(x){
  -(pochodna_funkcji(x))
}

bisection_min <- bisection(pochodna_funkcji, 1.5, 3, 0.0001)
bisection_min

bisection_max <- bisection(pochodna_funkcji_minus, 1, 2, 0.0001)
bisection_max

## Analiza wyników - Min ####
golden_min
ternary_min
lagrange_min
bisection_min

## Analiza wynikow - Max ####
golden_max
ternary_max
lagrange_max
bisection_max

sprintf("%.6f", golden_min)
sprintf("%.6f", ternary_min)
sprintf("%.6f", lagrange_min)
sprintf("%.6f", bisection_min)

wyniki5min <- c(golden_min, ternary_min, lagrange_min, bisection_min)
wynikimax <- c(golden_max, ternary_max, lagrange_max, bisection_max)



##### 10 miejsc po przecinku ####
wyniki10min <- c(sprintf("%.10f", golden_min),
sprintf("%.10f", ternary_min),
sprintf("%.10f", lagrange_min),
sprintf("%.10f", bisection_min))

# -----
sprintf("%.10f", golden_max)
sprintf("%.10f", ternary_max)
sprintf("%.10f", lagrange_max)
sprintf("%.10f", bisection_max)


# wartosci funkcji 
wartosc_funkcji_min <- c(sprintf("%.10f", funkcja(golden_min)),
sprintf("%.10f", funkcja(ternary_min)),
sprintf("%.10f", funkcja(lagrange_min)),
sprintf("%.10f", funkcja(bisection_min)))


tabela_min <- data.frame(wyniki3min, wyniki5min, wyniki10min, wartosc_funkcji_min, iteracje_min)
names(tabela_min) <- c("3 miejsca", "5 miejsc", "10 miejsc", "Wartosc Funkcji", "Iteracje")
row.names(tabela_min) <- c("Golden", "Ternery", "Lagrange", "Bisection")

iteracje_min <- c(19, 23, 16, 13)

tabela_min







# -----
max3 <- c(sprintf("%.3f", (golden_max)),
sprintf("%.3f", (ternary_max)),
sprintf("%.3f", (lagrange_max)),
sprintf("%.3f", (bisection_max)))


max6 <- c(sprintf("%.6f", (golden_max)),
          sprintf("%.6f", (ternary_max)),
          sprintf("%.6f", (lagrange_max)),
          sprintf("%.6f", (bisection_max)))


max10 <- c(sprintf("%.10f", (golden_max)),
          sprintf("%.10f", (ternary_max)),
          sprintf("%.10f", (lagrange_max)),
          sprintf("%.10f", (bisection_max)))


wartmax <- c(sprintf("%.10f", funkcja(golden_max)),
             sprintf("%.10f", funkcja(ternary_max)),
             sprintf("%.10f", funkcja(lagrange_max)),
             sprintf("%.10f", funkcja(bisection_max)))

iteracje_max <- c(18, 11, 16, 13)

tabela_max <- data.frame(max3, max6, max10, wartmax, iteracje_max)
names(tabela_max) <- c("3 miejsca", "6 miejsc", "10 miejsc", "Wartosc Funkcji", "Iteracje")
row.names(tabela_max) <- c("Golden", "Ternery", "Lagrange", "Bisection")

tabela_max



## Wykres caly - min i max (z zaznaczonymi pkt)
draw_plot(1)

## Wykres przedzialowy - min 
draw_plot2(1)

## Wykres przedzialowy - max
draw_plot3(1)

## Wykres - Nie jest wazne ktory algorytm podamy do zaznaczenia pkt na wykresie - poniewaz przy 
# zaokragleniu do trzech miejsc po przecinku kazdy wynik jest dokladnie taki sam (przy max roznica
# na 3 miejscu po przecinku w algorytmie ternery i bisection)

## MINIMUM
## Wniosek: Jezeli w metodach optymalizacji nieliniowej przeprowadzamy badania na malej ilosci miejsc
# po przecinku to powyzsze algorytmy daja wyniki takie same. 
# Jednak jezeli zalezy nam na wiekszej ilosci miejsc - wtedy algorytm Lagrangea odbiega od reszty. 
# wynik w tej metodzie odbiega od innych juz na 4/5 miejscu po przecinku (wartosc jest wieksza)
# Jesli chodzi o zaokraglenia wartosci do 4 miejsc po przecinku (standardowe w przypadkach, gdzie nie 
# potrzebne s¹ wyniki z bardzo duza dokladnoscia) to oczywiscie wyniki beda wszedzie te same (2.5222) 
# jednak w metodzie fibonacciego musimy zanizyc wartosc oszacowania, gdzie w pozostalych metodach sa 
# one zawyzane. 
## Wartosc funkcji w punktach obliczonych przez algorytmy rowniez jest "inna" w algorytmie Lagrangea -
## tutaj jednak wynik rozni sie dopiero na 8 miejscu po przecinku.

## MAKSIMUM
## Wniosek: Jezeli w metodach optymalizacji nieliniowej przeprowadzamy badania na malej ilosci miejsc
# po przecinku to powyzsze algorytmy daja wyniki takie same. 
# Jednak jezeli zalezy nam na wiekszej ilosci miejsc - wtedy algorytmy Ternery odbiegaja od reszty. 
# Wyniki w tych metodach odbiegaj¹ od innych juz na 3 miejscu po przecinku (wartosc w Ternery jest 
# wieksza).  

