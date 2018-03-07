class User < ApplicationRecord
  def ensure_session_token
    generate_session_token if self.session_token.nil?
  end

  def find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def generate_session_token
    self.session_token = SecureRandom::urlsafe_base64(1234)
  end

  def reset_session_token!

  end

  def password=
    self.password_digest = SecureRandom::urlsafe_base64(password)
  end

  def is_password?(password)
    SecureRandom::urlsafe_base64.new(self.password_digest).is_password?(password)
  end

  # validates :username, :session_token presence: true
  # validates :password_digest :message => "Password can't be blank"
  # validates :password_digest, minimum: 5, maximum: 10, allow_blank: true

end
