# ================================================================
# Ejercicios de clase Volumen 2: Dataframes
# Autor: ChatGPT y Miguel A. Lopez (por ese orden)
# 28/10/2025
# ================================================================

# ----------------------------------------------------------------
# Ejercicio 1: Creación de un data frame
# Enunciado:
#   Cree un data frame llamado df_alumnos con las columnas:
#     nombre  = c("Ana", "Luis", "Marta", "Jorge", "Eva")
#     edad    = c(22, 25, 24, 23, 27)
#     nota    = c(8.5, 6.0, 9.2, 4.8, 7.5)
#   Asegúrese de que 'nombre' sea carácter y no factor.

nombre  = c("Ana", "Luis", "Marta", "Jorge", "Eva")
edad    = c(22, 25, 24, 23, 27)
nota    = c(8.5, 6.0, 9.2, 4.8, 7.5)

df_alumnos <- data.frame(nombre =  as.character(nombre),
                         edad   = edad,
                         nota   = nota)

df_alumnos



# ----------------------------------------------------------------
# Ejercicio 2: Selección de filas por condición
# Enunciado:
#   Obtenga las filas de df_alumnos correspondientes
#   a estudiantes con nota >= 7.

# Selección de filas con nota >= 7
df_aprobados <- df_alumnos[df_alumnos$nota >= 7, ]
df_aprobados


# ----------------------------------------------------------------
# Ejercicio 3: Selección de columnas
# Enunciado:
#   Extraiga únicamente las columnas nombre y nota
#   en un nuevo data frame df_notas.
df_notas <- df_alumnos[, c(1, 3)]
df_notas


# ----------------------------------------------------------------
# Ejercicio 4: Nueva columna calculada
# Enunciado:
#   Añada a df_alumnos una columna llamada "aprobado"
#   que valga TRUE si nota >= 5 y FALSE en caso contrario.
df_alumnos$aprobado <- df_alumnos$nota >= 5
df_alumnos

# ----------------------------------------------------------------
# Ejercicio 5: Reordenación por una columna
# Enunciado:
#   Ordene df_alumnos de mayor a menor nota.
#   Guarde el resultado en df_ordenado.
# ordena la indexacion
df_ordenado <- df_alumnos[order(-df_alumnos$nota), ]
rownames(df_ordenado) <- NULL
df_ordenado



# ----------------------------------------------------------------
# Ejercicio 6: Filtrado combinado
# Enunciado:
#   Seleccione las filas de df_alumnos donde:
#     - aprobado == TRUE
#     - edad es estrictamente mayor que 23
#   Guarde el resultado en df_filtrado.
df_filtrado <- df_alumnos[df_alumnos$aprobado &
                            df_alumnos$edad > 23, ]
df_filtrado




# ----------------------------------------------------------------
# Ejercicio 7: Estadísticos agrupados "a mano"
# Enunciado:
#   Suponga que cada alumno pertenece a un grupo:
#     grupo = c("A", "A", "B", "B", "A")
#   Añada esta columna a df_alumnos y calcule la nota media por grupo
#   usando tapply().
grupo <- c("A", "A", "B", "B", "A")
df_alumnos$grupo <- grupo
nota_media_grupo <- tapply(df_alumnos$nota, df_alumnos$grupo, mean)
nota_media_grupo

# sin tapply
notas_A <- df_alumnos$nota[df_alumnos$grupo == "A"]
notas_B <- df_alumnos$nota[df_alumnos$grupo == "B"]
media_A <- mean(notas_A)
media_B <- mean(notas_B)
media_A
media_B



# ----------------------------------------------------------------
# Ejercicio 8: Eliminación de filas con NA
# Enunciado:
#   Cree un nuevo data frame df_sensores con las columnas:
#     sensor_id = c("S1", "S2", "S3", "S4", "S5")
#     temperatura = c(20.1, NA, 19.8, NA, 22.5)
#     activo = c(TRUE, TRUE, FALSE, TRUE, TRUE)
#   Elimine todas las filas que tengan NA en la columna temperatura.
sensor_id    = c("S1", "S2", "S3", "S4", "S5")
temperatura  = c(20.1, NA, 19.8, NA, 22.5)
activo       = c(TRUE, TRUE, FALSE, TRUE, TRUE)
df_sensores <- data.frame(sensor_id = sensor_id,
                          temperatura = temperatura,
                          activo = activo)
df_sensores_sinNA <- df_sensores[!is.na(df_sensores$temperatura), ]
df_sensores_sinNA

# Con which
index <- which(!is.na(df_sensores$temperatura))
df_sensores[index, ]

# ----------------------------------------------------------------
# Ejercicio 9: Unión por posición y por nombre
# Enunciado:
#   Considere dos data frames pequeños:
#     df_ids <- data.frame(
#       id   = c(101, 102, 103),
#       user = c("u1", "u2", "u3"),
#       stringsAsFactors = FALSE
#     )
#     df_scores <- data.frame(
#       user = c("u2", "u1", "u4"),
#       score = c(15, 20, 5),
#       stringsAsFactors = FALSE
#     )
#   1) Haga un "merge" por la columna común 'user' para unir la puntuación.
#   2) Interprete por qué un usuario puede tener NA.
df_ids <- data.frame(
  id   = c(101, 102, 103),
  user = c("u1", "u2", "u3"),
  stringsAsFactors = FALSE
)

df_score <- data.frame(
  user  = c("u2", "u1", "u4"),
  score = c(15, 20, 5),
  stringsAsFactors = FALSE
)

df_merge <- merge(df_ids, df_score, by = "user", all.x = TRUE)
df_merge


# ----------------------------------------------------------------
# Ejercicio 10: Resumen estadístico columna a columna
# Enunciado:
#   Usando df_alumnos (con las columnas edad y nota),
#   calcule para cada columna numérica:
#     mínimo, máximo, media y sd.
#   Hágalo usando sapply() sobre un subconjunto numérico del data frame.
# Solución:

df_numerico <- df_alumnos[, c("edad", "nota")]
resumen <- sapply(df_numerico, function(x) {
  c(
    min = min(x),
    max = max(x),
    media = mean(x),
    sd = sd(x)
  )
})
resumen
