
## Creating a Service Principal 
#### Login from AZ command line
```
az login 
```

#### Get Subscription ID
```
az account show     # look for id 
az account show --subscription <name-from-az-account> --query id
```
#### Create SP as contributor role
```
az ad sp create-for-rbac --name <SP-NAME-HERE> --role Contributor --scopes /subscriptions/<subscription_id>
az ad sp create-for-rbac --name az-my-labs --role Contributor --scopes /subscriptions/<Subcription-ID-Here>
```

##### Sample Output
```
{
  "appId": "Appid-used-as-Client_ID",
  "displayName": "sp-diplay-name",
  "password": "password-used-as-client-secret",
  "tenant": "tenant-id"
}
```

## Configure Terrafrom to use Azure account
Get details from SP creation output and assign to the following variables
```
$vi .connection.env

export ARM_CLIENT_ID="xxx" <appID>
export ARM_CLIENT_SECRET="xxx" <Password>
export ARM_SUBSCRIPTION_ID="xxx" <SubscriptionID>
export ARM_TENANT_ID="xxx" <TenantID>

$source .connection.env
```
