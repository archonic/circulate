class CreateReservationLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :reservation_line_items do |t|
      t.references :reservable, null: false, polymorphic: true
      t.references :reservation, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1
      t.references :creator, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
