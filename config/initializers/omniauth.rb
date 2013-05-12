Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["CONSUMER_KEY"], ENV["SECRET_KEY"]
end
