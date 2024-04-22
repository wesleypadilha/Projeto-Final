class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_secure_password
  has_secure_token :remember_token

  MAILER_FROM_EMAIL = "no_reply@email.com"
  PASSWORD_RESET_TOKEN_EXPIRATION = 10.minutes

  before_save :downcase_email

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true

  def generate_password_reset_token
    signed_id expires_in: PASSWORD_RESET_TOKEN_EXPIRATION, purpose: :reset_password
  end

  def send_password_reset_email!
    password_reset_token = generate_password_reset_token
    UserMailer.password_reset(self, password_reset_token).deliver_now
  end

  private
  def downcase_email
    self.email = email.downcase
  end
end
