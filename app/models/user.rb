class User < ApplicationRecord
  belongs_to :organisation, optional: true
end
