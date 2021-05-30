class ReservationsController < ApplicationController
  def index
    render json: Reservation.all.as_json
  end

  def create
    if !guest_params.empty?
      guest = Guest.where(email: guest_params[:email]).first_or_create do |guest|
        guest.first_name = guest_params[:first_name]
        guest.last_name = guest_params[:last_name]
        guest.service_id = guest_params[:id]
        guest.phone_numbers = guest_params[:phone]
      end

      reservation = Reservation.new(reservation_params.merge(guest_id: guest.id))
    else
      guest = Guest.where(email: reservation_params[:guest_email]).first_or_create do |guest|
        guest.first_name = reservation_params[:guest_first_name]
        guest.last_name = reservation_params[:guest_last_name]
        guest.service_id = reservation_params[:guest_id]
        guest.phone_numbers = reservation_params[:guest_phone_numbers].join(", ")
      end
      reservation = Reservation.new(guest_id: guest.id,
        start_date: Date.parse(reservation_params[:start_date]),
        end_date: Date.parse(reservation_params[:end_date]),
        list_price: reservation_params[:expected_payout_amount],
        security_price: reservation_params[:listing_security_price_accurate],
        adults: reservation_params[:guest_details][:number_of_adults],
        children: reservation_params[:guest_details][:number_of_children],
        infants: reservation_params[:guest_details][:number_of_infants],
        currency: reservation_params[:host_currency],
        status: reservation_params[:status_type],
        paid_amount: reservation_params[:total_paid_amount_accurate])
    end

    if reservation.save
      render json: {success: true, id: reservation.id}, status: :ok
    else
      render json: {success: false}, status: 400
    end

  end

  private
  def reservation_params
    params.require(:reservation).permit!
  end

  def guest_params
    params.fetch(:guest, {}).permit!
  end
end
