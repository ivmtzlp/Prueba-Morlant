# CONEXION AL SERVER DE MORANT

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
