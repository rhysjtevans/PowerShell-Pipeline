$password = ConvertTo-SecureString 'admin123' -AsPlainText -Force
$Creds = New-Object System.Management.Automation.PSCredential ('admin', $password)


Get-ChildItem -Path ./repositories -filter *.json | ForEach-Object {
    Write-Host "Pushing $($PSItem.Name)"
    $Payload = @{
        Uri = "http://localhost:8081/service/rest/v1/script/"
        ContentType = "application/json"
        Credential = $Creds
        Authentication = "Basic"
        Body = Get-Content -Raw -Path $PSItem.FullName
        AllowUnencryptedAuthentication = true
    }
    Invoke-RestMethod  @Payload 
}
