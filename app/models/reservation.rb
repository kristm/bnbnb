class Reservation < ApplicationRecord
  belongs_to :guest
  enum status: [ :booked, :accepted, :rejected ]

  validates :start_date, :end_date, :adults, presence: true


  def nights
    (end_date - start_date).to_i
  end

  def number_of_guests
   adults + children
  end

end
