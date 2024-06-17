param (
    [string]$parametroParaApi
)

# Defina os parÃ¢metros de conexÃ£o com o SQL Server
$serverName = "bd-sqlserver\SQLEXPRESS"  # Substitua pelo nome do seu servidor SQL
$databaseName = "ORAAPI"  # Substitua pelo nome do seu banco de dados
$username = "api"  # Substitua pelo seu nome de usuÃ¡rio
$password = "Xsw23edC"  # Substitua pela sua senha


# Defina a URL da API que você deseja consumir
$url = "http://192.168.0.68:5500/recurso/_id/$parametroParaApi"

# Função para fazer a solicitação à API e retornar os dados
function Get-APIData {
    param (
        [string]$url
    )
    
    $response = Invoke-RestMethod -Uri $url -Method Get
    return $response
}

# Função para inserir dados na tabela do SQL Server
function Insert-DataToSQL {
    param (
        [System.Data.SqlClient.SqlConnection]$connection,
        [string]$tableName,
        [object]$data
    )
    
    $itens = @()
    $dado = @()
            
           

           foreach ($item in $data) {
               
                
                echo $item

                
                $command = $connection.CreateCommand()
                $command.CommandText = "INSERT INTO $tableName (UNIDADE_FABRIL, ID_RECURSO, CODIGO_RECURSO, DESCRE, PEREFI ) VALUES (@Coluna1, @Coluna2, @Coluna3, @Coluna4,@Coluna5)"  # Substitua pelas colunas necessárias
                $command.Parameters.AddWithValue("@Coluna1", $item[0])  
                $command.Parameters.AddWithValue("@Coluna2", $item[1])
                $command.Parameters.AddWithValue("@Coluna3", $item[2]) 
                $command.Parameters.AddWithValue("@Coluna4", $item[3])
                $command.Parameters.AddWithValue("@Coluna5", $item[4])
                $command.ExecuteNonQuery()

           }



} 

# Crie a string de conexão
$connectionString = "Server=$serverName;Database=$databaseName;User ID=$username;Password=$password;"

# Crie o objeto de conexão com o SQL Server
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

# Abra a conexão com o SQL Server
$connection.Open()

# Obtenha os dados da API
$apiData = Get-APIData -url $url

# Insira os dados na tabela do SQL Server
Insert-DataToSQL -connection $connection -tableName "TB_ERP_NEO_RECURSO" -data $apiData  # Substitua "NomeDaTabela" pelo nome da sua tabela

# Feche a conexão com o SQL Server
$connection.Close()
