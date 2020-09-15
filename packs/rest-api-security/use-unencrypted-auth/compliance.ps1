if($LambdaInput) {
  $url = $LambdaInput.body.healthCheckURL
  $cred = $LambdaInput.body.Cred
  $encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($cred))
  $basicCred = "Basic $encodedCreds"
  $headers = @{
    Authorization =   $basicCred 
  }
if ($url.startswith("http:")) 
  {
  Write-Host "Allow unencrypted Authencation"
}
try{
  $response = Invoke-RestMethod $url -AllowUnencryptedAuthentication -Headers $headers
  $compliant = ($response.statuscode -eq 200)
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