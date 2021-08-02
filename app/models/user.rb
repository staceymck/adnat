class User < ApplicationRecord
  has_secure_password

  belongs_to :organisation, optional: true
  has_many :shifts

  # allow_blank: true so length validation runs only if password is present
  # Allows user to update their details (email, name) without having to update their password at same time
  validates :password, length: { minimum: 6, allow_blank: true }
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  # Use gem Email Validator in strict mode to validate email addresses
  validates :email, email: {mode: :strict, require_fqdn: true}
end