class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :phone_numbers
      t.timestamps
    end

    create_table :reservations do |t|
      t.belongs_to :guest
      t.date :start_date
      t.date :end_date
      t.integer :number_of_guests
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.integer :status
      t.string :currency, default: "AUD" 
      t.integer :list_price
      t.integer :security_price

      t.timestamps
    end
  end
end
