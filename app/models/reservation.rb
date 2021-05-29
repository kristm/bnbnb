class Reservation < ApplicationRecord
  belongs_to :guest
  enum status: [ :booked, :accepted, :rejected ]

  validates :start_date, :end_date, :number_of_guests, presence: true


  def nights
    (end_date - start_date).to_i
  end
end
