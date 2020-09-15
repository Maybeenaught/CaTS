if($LambdaInput) {
    $url = $LambdaInput.body.healthCheckURL
    try{
        $response =  = Invoke-WebRequest $url 
        $compliant = ($response.statuscode -eq 200)
        $certCheck = [System.Net.ServicePointManager]::FindServicePoint($url)
        $certCheck.Certificate.GetCertHashString()
        $certCheck.Certificate.GetExpirationDateString()
        $today = Get-Date
        if ($certCheck.Certificate.GetExpirationDateString -lt $today) {
            Write-Host $($url) + ' has an Expired Cert'
            
              }
        }
    catch {
        $compliant = $false
      }
}

@{
    statusCode = $statusCode
    body       = @{
      result = $compliant
    } | ConvertTo-Json -Depth 99
    headers    = @{'Content-Type' = 'text/plain' }
  }