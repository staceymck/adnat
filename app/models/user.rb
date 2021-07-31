class User < ApplicationRecord
  has_secure_password

  belongs_to :organisation, optional: true
  has_many :shifts

  validates :password, length: { minimum: 6 }
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  # Use gem Email Validator in strict mode to validate email addresses
  validates :email, email: {mode: :strict, require_fqdn: true}

end
