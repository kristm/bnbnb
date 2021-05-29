class AddServiceIdToGuest < ActiveRecord::Migration[6.1]
  def change
    add_column :guests, :service_id, :integer #third-party user id
  end
end
