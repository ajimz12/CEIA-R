# ================================================================
# Ejercicios de clase Volumen 3: Dataframes
# Autor: ChatGPT y Miguel A. Lopez (por ese orden)
# ----
# ================================================================

# ---------------------------------------------------------------------
# Ejercicio 1: if / else básico
# Enunciado:
#   Dados dos números a y b, imprima cuál es mayor o si son iguales
#   utilizando if / else.
a <- 3
b <- 2

if (a > b) {
  print("a es mayor que b")
} else if (a < b) {
  print("b es mayor que a")
} else {
  print("Ambos números son iguales")
}


# ---------------------------------------------------------------------
# Ejercicio 2: switch para mapear códigos
# Enunciado:
#   Cree una función categoria(nivel) que devuelva:
#     1 -> "Bajo", 2 -> "Medio", 3 -> "Alto"; cualquier otro -> "Desconocido"
#   Use switch().
#   https://r-coder.com/funcion-switch-r/
categoria <- function(nivel) {
  resultado <- switch(nivel,
                      "1" = "Bajo",
                      "2" = "Medio",
                      "3" = "Alto",
                      "Desconocido")
  return(resultado)
}

print(categoria(1))


# ---------------------------------------------------------------------
# Ejercicio 3: for con next y break
# Enunciado:
#   Recorra 1:10 e imprima solo los números impares hasta encontrar el 7.
#   Use next para saltar pares y break al llegar a 7.
for (i in 1:10) {
  if (i %% 2 == 0) {
    next
  }
  if (i == 7) {
    break
  }
  print(i)
}



# ---------------------------------------------------------------------
# Ejercicio 4: while con condición de parada
# Enunciado:
#   Genere números uniformes U(0,1) hasta que la suma supere 3.
#   Cuente cuántos números fueron necesarios.
suma <- 0
contador <- 0
while (suma <= 3) {
  numero <- runif(1, min = 0, max = 1)
  suma <- suma + numero
  contador <- contador + 1
}
print(paste("Números necesarios", contador))



# ---------------------------------------------------------------------
# Ejercicio 5: repeat con validación y salida por break
# Enunciado:
#   Simule tiradas de un dado justo (1..6) hasta obtener un 6.
#   Use repeat y salga con break.
#   https://r-coder.com/funcion-sample-r/
repeat {
  tirada <- sample(1:6, 1)
  print(paste("Tirada:", tirada))
  if (tirada == 6) {
    break
  }
}



# ---------------------------------------------------------------------
# Ejercicio 6: Función con argumentos por defecto y validación
# Enunciado:
#   Defina una función escalar(x, factor = 1) que multiplique un vector numérico
#   por 'factor'. Valide que x sea numérico y que factor sea escalar finito;
#   en caso contrario lance error con stop().
escalar <- function(x, factor = 1) {
  if (!is.numeric(x)) {
    stop("Error: x debe ser un vector numérico")
  }
  if (!is.finite(factor)) {
    stop("Error: factor debe ser escalar finito")
  }
  return(x * factor)
}
# Ejemplo de uso
vec <- c(1, 2, 3)
print(escalar(vec, 2))



# ---------------------------------------------------------------------
# Ejercicio 7: Función que devuelve múltiples valores (lista)
# Enunciado:
#   Defina una función resumen_num(x) que devuelva una lista con
#   minimo, maximo, media y sd de un vector numérico, ignorando NA.
resumen_num <- function(x) {
  if (!is.numeric(x)) {
    stop("Error: x debe ser un vector numérico")
  }
  
  
  resultado <- list(
    min <- min(x, na.rm = TRUE),
    max <- max(x, na.rm = TRUE),
    media <- mean(x, na.rm = TRUE),
    desv <- sd(x, na.rm = TRUE)
  )
  
  return(resultado)
}

print(resumen_num(c(1, 2, 3, NA)))



# ---------------------------------------------------------------------
# Ejercicio 8: Función de orden superior (recibe otra función)
# Enunciado:
#   Defina aplicar2(x, f) que aplique una función 'f' elemento a elemento
#   sobre 'x'. Valide que 'f' sea una función. Devuelva el mismo tipo que sapply.

aplicar2 <- function(x, f) {
  if (!is.function(f)) {
    stop("Error: f debe ser una función.")
  }
  return(sapply(x, f))
}

valores <- c(1, 2, 3, 4, 5)

cuadrado <- function(n)
  n^2

resultado <- aplicar2(valores, cuadrado)

print(resultado)


# ---------------------------------------------------------------------
# Ejercicio 9: Clausuras (closures)
# Enunciado:
#   Implemente fabrica_suma(k) que devuelva una función g(x) = x + k,
#   capturando el valor de k en el entorno.
fabrica_suma <- function(k) {
  g <- function(x) {
    return(x + k)
  }
  return(g)
}

sumar10 <- fabrica_suma(10)
sumar10(10)



# ---------------------------------------------------------------------
# Ejercicio 10: Recursión (factorial) con control de errores
# Enunciado:
#   Escriba factorial_r(n) recursivo que:
#     - Lance error si n no es entero no negativo.
#     - Use caso base para n==0 o n==1.
factorial_r <- function(n) {
  if (!is.numeric(n) || length(n) != 1 || n < 0 || n != floor(n)) {
    stop("Error: n debe ser un entero positivo")
  }
  if (n == 0 || n == 1) {
    return(1)
  } else {
    return(n * factorial_r(n - 1))
  }
}

print(factorial_r(5))  



# ---------------------------------------------------------------------
# Ejercicio 11: Manejo de errores con tryCatch
# Enunciado:
#   Defina segura_sqrt(x) que devuelva sqrt(x) y, si x < 0, capture el error
#   y devuelva NA con una advertencia (warning()).
segura_sqrt <- function(x) {
  res <- tryCatch({
    if (x < 0) {
      stop("Error: Se ha dado un numero negativo")
    }
    return(sqrt(x))
  }, error = function(e) {
    warning("Se ha devuelto NA")
    return(NA)
  })
  return(res)
}

print(segura_sqrt(3))
