class Employee < ApplicationRecord
  require "SecureRandom"
  rolify
  has_secure_password

  has_many :sessions, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true, length: { minimum:6 }
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :fiscal_number, presence: true, uniqueness: true, length: { minimum: 6, maximum: 11 }
end
