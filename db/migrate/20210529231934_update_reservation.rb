class UpdateReservation < ActiveRecord::Migration[6.1]
  def up
    rename_column :guests, :phone_numbers, :phone
    add_column :reservations, :total_price, :float
    remove_column :reservations, :number_of_guests
    change_column :reservations, :list_price, :float
    rename_column :reservations, :list_price, :payout_price
    change_column :reservations, :security_price, :float
    change_column :reservations, :adults, :integer, default: 0
    change_column :reservations, :children, :integer, default: 0
  end

  def down
    rename_column :guests, :phone, :phone_numbers
    remove_column :reservations, :total_price
    add_column :reservations, :number_of_guests, :integer
    rename_column :reservations, :payout_price, :list_price
    change_column :reservations, :list_price, :integer
    change_column :reservations, :security_price, :integer
  end
end
