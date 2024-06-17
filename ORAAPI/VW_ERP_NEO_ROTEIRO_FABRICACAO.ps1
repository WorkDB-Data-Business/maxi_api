# Defina os parâmetros de conexão com o SQL Server
$serverName = "bd-sqlserver\SQLEXPRESS"  # Substitua pelo nome do seu servidor SQL
$databaseName = "ORAAPI"  # Substitua pelo nome do seu banco de dados
$username = "api"  # Substitua pelo seu nome de usuário
$password = "Xsw23edC"  # Substitua pela sua senha

# Defina as tabelas que você deseja verificar
$tabelas = @("TB_ERP_NEO_ROTEIRO_FABRICACAO")  # Substitua pelos nomes das suas tabelas

# Crie a string de conexão
$connectionString = "Server=$serverName;Database=$:q
databaseName;User ID=$username;Password=$password;"

# Crie o objeto de conexão com o SQL Server
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

# Abra a conexão com o SQL Server
$connection.Open()

# Itere sobre as tabelas
foreach ($tabela in $tabelas) {
    # Consulte o SQL Server para verificar se a tabela existe
    $command = $connection.CreateCommand()
    $command.CommandText = "IF OBJECT_ID('$tabela', 'U') IS NOT NULL SELECT 1 ELSE SELECT 0"
    $existe = $command.ExecuteScalar()

    # Verifique se a tabela existe
    if ($existe -eq 1) {
        # Se a tabela existir, apague-a
        $command.CommandText = "DROP TABLE $tabela"
        $command.ExecuteNonQuery()
        Write-Host "A tabela $tabela foi apagada e será recriada."
        $command.CommandText = "CREATE TABLE $tabela (UNIDADE_FABRIL NVARCHAR(80), ID_ITEM NVARCHAR(21), SEQROT INT, CODOPR NVARCHAR(6), DESOPR  NVARCHAR(40), CODCRE NVARCHAR(40), SEQ_AUTOMATICO INT,  UNICRE NVARCHAR(1), TMPPRP REAL, FERRAMENTA NVARCHAR(500), TMPFIX REAL, TIPO_ESPERA NVARCHAR(500), TEMPO_MAXIMO NVARCHAR(500) )" 
        $command.ExecuteNonQuery()
        Write-Host "A tabela $tabela foi criada."
    } else {
        # Se a tabela não existir, crie-a
        $command.CommandText = "CREATE TABLE $tabela (UNIDADE_FABRIL NVARCHAR(80), ID_ITEM NVARCHAR(21), SEQROT INT, CODOPR NVARCHAR(6), DESOPR  NVARCHAR(40), CODCRE NVARCHAR(40), SEQ_AUTOMATICO INT,  UNICRE NVARCHAR(1), TMPPRP REAL, FERRAMENTA NVARCHAR(500), TMPFIX REAL, TIPO_ESPERA NVARCHAR(500), TEMPO_MAXIMO NVARCHAR(500) )" 
        $command.ExecuteNonQuery()
        Write-Host "A tabela $tabela foi criada."
    }
}

# Feche a conexão com o SQL Server
$connection.Close()
