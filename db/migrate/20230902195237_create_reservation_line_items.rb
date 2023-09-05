class CreateReservationLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :reservation_line_items do |t|
      t.string :reserveable_type, null: false
      t.references :reservable, null: false
      t.references :reservation, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1
      t.references :created_by, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
