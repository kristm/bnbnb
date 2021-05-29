class Guest < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates :first_name, :last_name, :email, presence: true
end
