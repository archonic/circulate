class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_enum :reservation_status, %w[requested approved rejected]

    create_table :reservations do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.enum :status, enum_type: :reservation_status
      t.references :reserved_by, null: false, foreign_key: {to_table: :users}
      t.references :parent_reservation, foreign_key: {to_table: :reservations}

      t.timestamps
    end
  end
end
