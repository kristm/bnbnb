class UpdateReservation < ActiveRecord::Migration[6.1]
  def up
    add_column :reservations, :paid_amount, :float
    remove_column :reservations, :number_of_guests
    change_column :reservations, :list_price, :float
    change_column :reservations, :security_price, :float
  end

  def down
    remove_column :reservations, :paid_amount
    add_column :reservations, :number_of_guests, :integer
    change_column :reservations, :list_price, :integer
    change_column :reservations, :security_price, :integer
  end
end
