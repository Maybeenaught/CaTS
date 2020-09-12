if($LambdaInput) {
  $url = $LambdaInput.body.healthCheckURL
  try {
    $response = Invoke-WebRequest $url -SslProtocol tls12
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
