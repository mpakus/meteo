# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses do |t|
      t.string :full
      t.string :lat, limit: 32
      t.string :lng, limit: 32
      t.references :weather, null: false, foreign_key: true

      t.timestamps
    end
  end
end
