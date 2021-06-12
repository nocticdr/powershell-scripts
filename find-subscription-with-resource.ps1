#Search for a resource type exist in all subscriptions and return subscriptions that 

$resType     = "Microsoft.Storage/storageAccounts" # Actual resource type to check.
$resTypeName = "StorageAccount" # For cosmetic purposes only

Get-AzSubscription | ForEach-Object {
    $subscriptionName = $_.Name
    $tenantId = $_.TenantId
    Set-AzContext -SubscriptionId $_.SubscriptionId -TenantId $_.TenantId
    (Get-AzResource -ResourceType $ResType) | ForEach-Object {     
        [PSCustomObject] @{
            true_sub = $subscriptionName
        } 
    } | get-unique 
} | Select-String 'true_sub' | ForEach-Object{ "Found " + "$resTypeName" + " In Subscription '$($subscriptionName)'"}

