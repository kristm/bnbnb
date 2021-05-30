require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  test "nights" do
    @reservation = reservations(:one)
    assert_equal 4, @reservation.nights

    @reservation = reservations(:two)
    assert_equal 31, @reservation.nights
  end

  test "number_of_guests" do
    @reservation = reservations(:one)
    assert_equal 1, @reservation.number_of_guests

    @reservation = reservations(:two)
    assert_equal 3, @reservation.number_of_guests
  end
end
