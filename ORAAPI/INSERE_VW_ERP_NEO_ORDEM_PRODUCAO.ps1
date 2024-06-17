param (
    [string]$parametroParaApi
)

# Defina os parÃ¢metros de conexÃ£o com o SQL Server
$serverName = "bd-sqlserver\SQLEXPRESS"  # Substitua pelo nome do seu servidor SQL
$databaseName = "ORAAPI"  # Substitua pelo nome do seu banco de dados
$username = "api"  # Substitua pelo seu nome de usuÃ¡rio
$password = "Xsw23edC"  # Substitua pela sua senha


# Defina a URL da API que você deseja consumir
$url = "http://192.168.0.68:5500/ordem_producao/_id/$parametroParaApi"

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
                $command.CommandText = "INSERT INTO $tableName (UNIDADE_FABRIL, NUMORP, SEQROT, SITORP, ID_ITEM, CODOPR, DESOPR, CODCRE,DATENT, UNIMED, QTDPRV, QTD_SALDO, QTD_TRANSFERENCIA, UNICRE, TMPTPR,NUMPED,AGRNEC, NUMORI, CODCLI, NOMCLI ) VALUES (@Coluna1, @Coluna2, @Coluna3, @Coluna4,@Coluna5,@Coluna6,@Coluna7,@Coluna8,@Coluna9,@Coluna10,@Coluna11,@Coluna12,@Coluna13,@Coluna14,@Coluna15,@Coluna16,@Coluna17,@Coluna18,@Coluna19,@Coluna20)"  # Substitua pelas colunas necessárias
                $command.Parameters.AddWithValue("@Coluna1", $item[0])  
                $command.Parameters.AddWithValue("@Coluna2", $item[1])
                $command.Parameters.AddWithValue("@Coluna3", $item[2]) 
                $command.Parameters.AddWithValue("@Coluna4", $item[3])
                $command.Parameters.AddWithValue("@Coluna5", $item[4])
                $command.Parameters.AddWithValue("@Coluna6", $item[5])
                $command.Parameters.AddWithValue("@Coluna7", $item[6])
                $command.Parameters.AddWithValue("@Coluna8", $item[7])
                $command.Parameters.AddWithValue("@Coluna9", $item[8])
                $command.Parameters.AddWithValue("@Coluna10", $item[9])
                $command.Parameters.AddWithValue("@Coluna11", $item[10])
                $command.Parameters.AddWithValue("@Coluna12", $item[11])
                $command.Parameters.AddWithValue("@Coluna13", $item[12])
                $command.Parameters.AddWithValue("@Coluna14", $item[13])
                $command.Parameters.AddWithValue("@Coluna15", $item[14])
                $command.Parameters.AddWithValue("@Coluna16", $item[15])
                $command.Parameters.AddWithValue("@Coluna17", $item[16])
                $command.Parameters.AddWithValue("@Coluna18", $item[17])
                $command.Parameters.AddWithValue("@Coluna19", $item[18])
                $command.Parameters.AddWithValue("@Coluna20", $item[19])


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
Insert-DataToSQL -connection $connection -tableName "TB_ERP_NEO_ORDEM_PRODUCAO" -data $apiData  # Substitua "NomeDaTabela" pelo nome da sua tabela

# Feche a conexão com o SQL Server
$connection.Close()
