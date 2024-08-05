require 'securerandom'

class UsersFacade
  def create_user(email, password, confirmation)
    User.create(email: email,
                password: password,
                password_confirmation: confirmation,
                api_key: SecureRandom.hex)
  end
end