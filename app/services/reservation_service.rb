class ReservationService < ApplicationService
  attr_reader :guest, :reservation

  def initialize(guest, reservation)
    if !guest.empty?
      service_id = guest.delete(:id)
      @guest = Guest.where(email: guest[:email]).first_or_create(guest.merge(service_id: service_id))

      @reservation = Reservation.new(reservation.merge(guest_id: @guest.id))
    else
      @guest = Guest.where(email: reservation[:guest_email]).first_or_create do |guest|
        guest.first_name = reservation[:guest_first_name]
        guest.last_name = reservation[:guest_last_name]
        guest.service_id = reservation[:guest_id]
        guest.phone = reservation[:guest_phone_numbers].join(", ")
      end
      @reservation = Reservation.new(parse_reservation(reservation).merge(guest_id: @guest.id))
    end
  end

  def call
    @reservation
  end

  def parse_reservation(reservation)
    {
      start_date: Date.parse(reservation[:start_date]),
      end_date: Date.parse(reservation[:end_date]),
      payout_price: reservation[:expected_payout_amount],
      security_price: reservation[:listing_security_price_accurate],
      adults: reservation[:guest_details][:number_of_adults],
      children: reservation[:guest_details][:number_of_children],
      infants: reservation[:guest_details][:number_of_infants],
      currency: reservation[:host_currency],
      status: reservation[:status_type],
      total_price: reservation[:total_paid_amount_accurate]
    }
  end

end
