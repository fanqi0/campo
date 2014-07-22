CarrierWave.configure do |config|
  config.storage = :upyun
  config.upyun_username = "lifedim"
  config.upyun_password = 'Mixswift14'
  config.upyun_bucket = "swiftist-images"
  # upyun_bucket_domain 以后将会弃用，请改用 upyun_bucket_host
  # config.upyun_bucket_domain = "my_bucket.files.example.com"
  config.upyun_bucket_host = "http://swiftist-images.b0.upaiyun.com"
end