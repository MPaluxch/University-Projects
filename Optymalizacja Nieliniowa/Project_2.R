hookejeeves <- function (f,x,step,alpha,tol) {
  
  while (step >= tol) {
    xb <- x
    cat("Etap próbny \n")
    x <- trial_stage(f,xb,step)
    if (f(x) < f(xb)) {
      cat("Etap roboczy \n")
      while (f(x) < f(xb)) {
        old.xb <- xb
        xb <- x
        x <- 2*xb-old.xb
        x <- trial_stage(f,x,step)
      }
      x <- xb
    } else {
      step <- alpha * step
      cat("Skrócenie kroku, step=", step , "\n")
    }
    cat("x=",x," xb=",xb," f(x)=",f(x)," f(xb)=",f(xb)," step=",step,"\n" )
  } 
  return(xb)
}
trial_stage <- function (f,x,step) {
  n <- length(x)
  versor <- diag(n)
  i <- 1
  while (i <= n) {
    if (f(x + step*versor[i,]) < f(x)) {
      x <- x + step*versor[i,]
      cat("Udany krok w kieunku wektora [",step*versor[i,],"] do punktu [",x ,"]\n")
    } else if (f(x - step*versor[i,]) < f(x)) {
      x <- x - step*versor[i,]
      cat("Udany krok w kieunku wektora [",-step*versor[i,],"] do punktu [",x ,"]\n")
    }
    i <- i + 1
  }
  return(x)
}

## Deklaracja funkcji
x <- seq(-50, 50, length.out = 30)
y <- seq(-5, 5, length.out = 30)


f <- function(x,y) {((3*x^2)-3*y^2+3*y^4+4*(x))}
z <- outer(x, y, f)
for (i in 1:700){
  persp(x,y,z, theta=i,phi=10,expand=0.4,col = "lightblue",xlab = "X",
        ylab = "Y", zlab = "Z",ticktype = "detailed")
  Sys.sleep(0.04)
}

f1 <- function(x) {((3*x[1]^2)-3*x[2]^2+3*x[2]^4+4*x[1]^4)}
f1<-function(x) {(1-x[1])^2+20*(x[2]^2-x[1]^2)^2+x[2]^2+x[2]^4+x[1]^4-300-3*x[1]-3*x[2]}

f1(c(50,0.7))


## Wywolanie funkcji
hookejeeves(f1,c(0,0),0.5,0.5,0.001)
hookejeeves(f1,c(0.34,0.72),0.5,0.5,0.001)



hookejeeves(f1,c(1.21,2.32),0.5,0.5,0.001)

hookejeeves(f1,c(30,50),0.5,0.5,0.001)


hookejeeves(f1,c(5580,900),0.5,0.5,0.001)



## Wersja interaktywna ##
library("rgl")

open3d()
persp3d(x,y,z, theta=i,phi=2,expand=0.4,col = "lightblue",xlab = "X",
        ylab = "Y", zlab = "Z",ticktype = "detailed")
