
############################################################
### Creating a Service Principal 

# login from AZ command line
az login 


# Get Subscription ID
az account show     # look for id 
az account show --subscription <name-from-az-account> --query id

# create SP as contributor role
az ad sp create-for-rbac --name <SP-NAME-HERE> --role Contributor --scopes /subscriptions/<subscription_id>
az ad sp create-for-rbac --name az-my-labs --role Contributor --scopes /subscriptions/<Subcription-ID-Here>
	

############################################################
### Configure Terrafrom to use Azure account

$vi .connection.env
# get details from SP creation output 
export ARM_CLIENT_ID="xxx" <appID>
export ARM_CLIENT_SECRET="xxx" <Password>
export ARM_SUBSCRIPTION_ID="xxx" <SubscriptionID>
export ARM_TENANT_ID="xxx" <TenantID>

$source .connection.env
