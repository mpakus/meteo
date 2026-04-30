# frozen_string_literal: true

class CreateWeathers < ActiveRecord::Migration[8.1]
  def change
    create_table :weathers do |t|
      t.string :zip, limit: 16, index: true
      t.jsonb :forecast

      t.timestamps
    end
  end
end
