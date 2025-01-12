class AddUserIdToBookings < ActiveRecord::Migration[7.2]
  def change
    add_reference :bookings, :user, foreign_key: true
  end
end
