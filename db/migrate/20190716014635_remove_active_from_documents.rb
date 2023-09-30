# frozen_string_literal: true

class RemoveActiveFromDocuments < ActiveRecord::Migration[6.0]
  def change
    remove_column :documents, :active
  end
end
