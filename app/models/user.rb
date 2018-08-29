class User < ApplicationRecord
  has_many :ideas

  has_secure_password

  validates_presence_of :email, :name, :password_digest
end
