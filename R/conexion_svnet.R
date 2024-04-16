# CONEXION AL SERVER DE MORANT

library(tidyverse)
library(DBI)


pool <- pool::dbPool(
  drv = odbc::odbc(),
  Driver= 'ODBC Driver 17 for SQL Server',
  Database = "SVNET",
  Server = "tcp:morant.database.windows.net",
  UID = "emorones",
  PWD = "Mor@nt2024",
  Port = 1433,
  timeout = 120
)

#LISTA DE BASES DE DATOS
dbListTables(conn= pool)

#Agregar base de datos
dbWriteTable(conn, "nombre_nueva_base",base_datos)

#LISTA DE VARIABLES DE BASES
dbListFields(conn=pool,"ds_mer_e1" )
dbListFields(conn=pool,"ds_morelos_corte" )


#LEER TABLA 
dbReadTable(con=pool, "ds_mer_e1")
df <- dbReadTable(con=pool, "ds_morelos_corte")
table(df$ine)


#MANDAR INSTRUCCION DE SQL A BASE Y A POOL
#Para bases de datos de manera directa se necesita ejecutar dbFetch para guaradar el reusltadp
res <- dbSendQuery(BASE, "SELECT * 
            FROM ds_morelos_corte 
            WHERE ine = No")
data<-dbFetch(res)
dbClearResult(res)  #Se utilizar al dbFetch

df2<-dbGetQuery(con=pool, "SELECT * 
            FROM ds_morelos_corte 
            WHERE ine = 'No'")

# Se ejecuta el query la cantidad de datos en la lista
df2<-dbGetQuery(con=pool, "SELECT COUNT(*) 
            FROM ds_morelos_corte 
            WHERE ine = ?",
                params = list(c('Sí','No','Falso')))


#Tabla de count
parametros<-list(c('Sí','No','Falso'))
df3<-dbGetQuery(con=pool, "SELECT COUNT(*) 
            FROM ds_morelos_corte 
            WHERE ine = ?",
                params = parametros)
df3['parametros']<- parametros


df3<-dbGetQuery(con=pool, "SELECT ine, COUNT(*) 
            FROM ds_morelos_corte 
            GROUP BY ine")




query <- "
  SELECT TOP 10 Id,
  RESULTADO,
  JSON_VALUE(RESULTADO,'$.mun') AS mun
  FROM Registros
  WHERE EncuestaId = 82
  
"
dat <- dbGetQuery(pool,query)


dat<-dplyr::tbl(pool, dplyr::sql(query))

query <- "
  SELECT id,
  
  FROM Registros as r
  WHERE EncuestaId = 82"




dat<-dplyr::tbl(pool, dplyr::sql(query))




dbListFields(conn=pool,"Registros" )






query_claves <- paste0("REPLACE(JSON_VALUE(r.Resultado, '$.", codigos_id82, "'), 'ñ', 'n') AS ", codigos_id82, collapse = ", ")

