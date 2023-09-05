class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_enum :reservation_status, %w[requested approved rejected fulfilled cancelled replaced]

    create_table :reservations do |t|
      t.enum :status, enum_type: :reservation_status
      t.references :reserver, null: false, foreign_key: {to_table: :users}
      t.datetime :started_at
      t.datetime :ended_at
      t.string :notes
      t.references :initial_reservation, foreign_key: {to_table: :reservations}

      t.timestamps
    end
  end
end
