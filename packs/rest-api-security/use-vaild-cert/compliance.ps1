if($LambdaInput) {
  $url = $LambdaInput.body.healthCheckURL
  Invoke-WebRequest $url -SslProtocol
}