$iniciais = "jr"
$resourceGroup = "ManagedPlatform"
$storageAccount = "imgtor$($iniciais)"
$storageContainer = "images"
$appService = "ManagedPlan"
$webApp = "imgapi$($iniciais)"

Write-Output "Criando o ResourceGroup"
az group create --name $resourceGroup -l eastus -o jsonc
Write-Output "Finalizado ResourceGroup"

Write-Output "==============================================="
# The SKU of the storage account defaults to 'Standard_RAGRS'.
Write-Output "Criando o Storage Account"
az storage account create --name $storageAccount --resource-group $resourceGroup  --sku Standard_LRS -o jsonc
Write-Output "Finalizado Storage Account"
Write-Output "==============================================="

Write-Output "Criando o Storage Container"
az storage container create --name $storageContainer  --account-name $storageAccount --public-access blob -o jsonc
Write-Output "Finalizado Storage Container"
Write-Output "==============================================="

Write-Output "Criando o AppService Plan"
# SKU é para dizer qual o plano - F1 é o FREE
az appservice plan create --resource-group $resourceGroup --name $appService --sku F1 -o jsonc
Write-Output "Finalizado AppService Plan"
Write-Output "==============================================="

Write-Output "Criando o WebApp"
# Runtime é para colocar qual é a aplicacao que vai rodar neste servidor
az webapp create --resource-group $resourceGroup --plan $appService   --name imgapijr --runtime "DOTNETCORE:3.1" -o jsonc
Write-Output "Finalizado WebApp"
Write-Output "==============================================="

Write-Output "Processo Finalizado"

# para deletar
# az group delete --name $appService --no-wait --yes