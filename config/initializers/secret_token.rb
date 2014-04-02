# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
# = 'cbb6d61cc2b8a466171eedec806d0cc2d5611c89ed01e17f19df84bb20bf5c4bfed208ec4b8761fe0a08f780c8cda048be8c9db2735a180b8eb987ff94094757'

require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exists?(token_file)
    File.read(token_file).chomp
  else
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

SampleApp::Application.config.secret_key_base = secure_token
