class AddItemPoolIdToItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :items, :item_pool, foreign_key: true
  end
end
