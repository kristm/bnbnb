class ReservationsController < ApplicationController
  def index
    render json: Reservation.all.as_json
  end

  def create
    reservation = ReservationService.call(guest_params, reservation_params)
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
