OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '711551912208839', '4cfa2872841fd786a1a55be4908a77ed'
end