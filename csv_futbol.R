# Carga y preparación de datos para un modelo que predecirá
# el número de goles de un jugador en un partido

# Nos proporcionan una hoja de calculo con datos de equipos, jugadores y partidos
# Nos piden un unico data frame con los datos de interés para un modelo de
# estas caracteristicas.

install.packages("readODS")
library(readODS)

setwd("/home/alumnot/Descargas/")

ruta_fichero <- "datos_futbol_R_ejercicio.ods"
equipos <- read_ods(ruta_fichero, sheet = "equipos")
jugadores <- read_ods(ruta_fichero, sheet = "jugadores")
partidos <- read_ods(ruta_fichero, sheet = "partidos")

# Vemos las primeras filas de cada data frame
head(equipos)
head(jugadores)
head(partidos)

# Construir data frame con los jugadores, partidos jugados, minutos jugados,
# partidos ganados, goles marcados en partidos jugados.

# Partidos jugados por equipo (local + visitante)
partidos_visitante <- table(partidos$equipo_visitante_id)
partidos_local     <- table(partidos$equipo_local_id)

todos_equipos <- union(names(partidos_visitante), names(partidos_local))
partidos_totales <- setNames(rep(0, length(todos_equipos)), todos_equipos)
partidos_totales[names(partidos_visitante)] <- partidos_totales[names(partidos_visitante)] + partidos_visitante
partidos_totales[names(partidos_local)]     <- partidos_totales[names(partidos_local)] + partidos_local

# Partidos ganados por equipo
get_partidos_ganados_from_equipo <- function(equipo_id) {
  ganados <- partidos[(
    partidos$equipo_local_id == equipo_id &
      partidos$goles_local > partidos$goles_visitante
  ) |
    (
      partidos$equipo_visitante_id == equipo_id &
        partidos$goles_visitante > partidos$goles_local
    ), ]
  nrow(ganados)
}

# Partidos empatados por equipo
get_partidos_empatados_from_equipo <- function(equipo_id) {
  empatados <- partidos[((
    partidos$equipo_local_id == equipo_id |
      partidos$equipo_visitante_id == equipo_id
  ) &
    partidos$goles_local == partidos$goles_visitante
  ), ]
  nrow(empatados)
}

# Vectores por jugador
ganados   <- sapply(jugadores$equipo_id, get_partidos_ganados_from_equipo)
empatados <- sapply(jugadores$equipo_id, get_partidos_empatados_from_equipo)
perdidos  <- partidos_totales[as.character(jugadores$equipo_id)] - ganados - empatados



# Data frame final
data <- data.frame(
  nombre = jugadores$nombre,
  minutos = jugadores$minutos_jugados_temporada,
  goles_marcados = jugadores$goles_temporada,
  partidos_jugados = partidos_totales[as.character(jugadores$equipo_id)],
  partidos_ganados = ganados,
  partidos_perdidos = perdidos
)

data$iMALM <- (data$partidos_ganados - data$partidos_perdidos) * (data$minutos / data$partidos_jugados)

# Normalización de la variable iMALM
normalizar <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

data$iMALM <- normalizar(data$iMALM)

# 20 jugadores con mejor iMALM
mejores_20_imalm <- data[order(-data$iMALM), ][1:20, ]

# Equipos con mas jugadores en mejores 20 iMALM
table(mejores_20_imalm$equipo_id)

