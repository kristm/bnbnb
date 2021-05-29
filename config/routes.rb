Rails.application.routes.draw do
  root to: "application#index"

  resources 'reservations' do
  end
end
