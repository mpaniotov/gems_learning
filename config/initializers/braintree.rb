# Those are just delegation to Braintree::Configuration
BraintreeRails::Configuration.environment = :sandbox
BraintreeRails::Configuration.logger = Logger.new('log/braintree.log')
BraintreeRails::Configuration.merchant_id = ENV['MERCHANT_ID']
BraintreeRails::Configuration.public_key = ENV['PUBLIC_KEY']
BraintreeRails::Configuration.private_key = ENV['PRIVATE_KEY']

# This is just a convenient place you can put your CSE key
BraintreeRails::Configuration.client_side_encryption_key = ENV['CLIENT_SIDE_ENCRYPTION_KEY']