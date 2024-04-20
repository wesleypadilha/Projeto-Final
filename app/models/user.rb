class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, format: {with: /\A[^@\s]+@[^@\s]+\z/, message: "Insira um endereço de email válido"}, length: { minimum: 7, maximum: 90 }
    validates :password, presence: true, length: { minimum: 7, maximum: 90 }, if: :password_required?
    validates :password_confirmation, presence: true, length: { minimum: 7, maximum: 90 }, if: :password_required?
    validates :name, presence: true, length: { minimum: 7, maximum: 50 }
    validates :nickname, presence: true, length: { minimum: 7, maximum: 50 }

    def password_required?
        password.present? || password_confirmation.present?
    end
end
