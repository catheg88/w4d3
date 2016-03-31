class User < ActiveRecord::Base

  after_initialize :ensure_session_token



  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password_arg)
    self.password_digest = BCrypt::Password.create(password_arg)
  end

  def is_password?(password_arg)
    BCrypt::Password.new(self.password_digest).is_password?(password_arg )
  end

  def self.find_by_credentials(user_name, password_arg)
    user = User.find_by_username(user_name)
    user.is_password?(password_arg) ? user : nil
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end




end
