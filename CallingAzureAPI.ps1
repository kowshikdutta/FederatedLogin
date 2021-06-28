$TenantId = ""
$ClientId = ""
$ClientSecret = ""

$Resource = "https://management.core.windows.net/"
$SubscriptionId = ""

$RequestAccessTokenUri = "https://login.microsoftonline.com/$TenantId/oauth2/token"
$body = "grant_type=client_credentials&client_id=$ClientId&client_secret=$ClientSecret&resource=$Resource"

$Token = Invoke-RestMethod -Method Post -Uri $RequestAccessTokenUri -Body $body -ContentType 'application/x-www-form-urlencoded'

Write-Host "Print Token" -ForegroundColor Green
Write-Output $Token

# Get the Azure Pricing API

$pricingURI = 'https://prices.azure.com/api/retail/prices' 

$Header = @{}

$header.Add("Authorization","$($Token.token_type) "+ " " + "$($Token.access_token)")

$Output = Invoke-RestMethod -Method Get -Uri $pricingURI -Headers $Header | ConvertTo-Json

Write-Host $Output





