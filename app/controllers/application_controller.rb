class ApplicationController < ActionController::API
  def index
    render json: { "hello": "BNB" }
  end
end
