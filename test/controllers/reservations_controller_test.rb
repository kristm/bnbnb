require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  payload1 = 
    {
      "reservation": {
        "start_date": "2020-03-12",
        "end_date": "2020-03-16",
        "expected_payout_amount": "3800.00",
        "guest_details": {
          "localized_description": "4 guests",
          "number_of_adults": 2,
          "number_of_children": 2,
          "number_of_infants": 0
        },
        "guest_email": "wayne_woodbridge@bnb.com",
        "guest_first_name": "Wayne",
        "guest_id": 1,
        "guest_last_name": "Woodbridge",
        "guest_phone_numbers": [
          "639123456789",
          "639123456789"
        ],
        "listing_security_price_accurate": "500.00",
        "host_currency": "AUD",
        "nights": 4,
        "number_of_guests": 4,
        "status_type": "accepted",
        "total_paid_amount_accurate": "4500.00"
      }
    }

  payload2 = 
    {
      "start_date": "2020-03-12",
      "end_date": "2020-03-16",
      "nights": 4,
      "guests": 4,
      "adults": 2,
      "children": 2,
      "infants": 0,
      "status": "accepted",
      "guest": {
        "id": 1,
        "first_name": "Wayne",
        "last_name": "Woodbridge",
        "phone": "639123456789",
        "email": "wayne_woodbridge@bnb.com"
      },
      "currency": "AUD",
      "payout_price": "3800.00",
      "security_price": "500",
      "total_price": "4500.00"
    }

  test "should get index" do
    get '/reservations'
    assert_response :success
  end

  test "create reservation from payload" do
    post '/reservations', params: payload1, as: :json
    assert_response :success
  end

  test "create reservation from another payload format" do
    post '/reservations', params: payload2, as: :json
    assert_response :success
  end

  test "creates guest from reservation" do
    post '/reservations', params: payload1, as: :json
    post '/reservations', params: payload2, as: :json
    assert_equal 1, Guest.count
    assert_equal 2, Guest.first.reservations.size
  end
end
