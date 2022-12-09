# Install Azure CLI on Windows https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli
# Install Packer https://www.packer.io/downloads

# 1 Create a resource group 
az group create -n myResourceGroup -l eastus --tags 'contact=Azure' 'customer=Azure'

# 2 Obtain your Azure subscription ID
az account show --query "{ subscription_id: id }"

# 3 create a service principal with az ad sp create-for-rbac and output the credentials that Packer needs:
az ad sp create-for-rbac --role Contributor --scopes /subscriptions/xxxxxxxxxxxxxxxxxxx --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"

# 4 Paste client id, secret id, tenant id, subscription_id into .json file


# 5 Build the image
packer build ubuntu.json



# 6 Create VM from Azure Image
az vm create --resource-group myResourceGroup --name myVM --image myPackerImage --admin-username azureuser --generate-ssh-keys

# 7 Open port 80
az vm open-port --resource-group myResourceGroup --name myVM --port 80

# delete az resource group
az group delete --name ExampleResourceGroup


