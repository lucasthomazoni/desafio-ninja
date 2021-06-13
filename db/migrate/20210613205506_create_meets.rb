# frozen_string_literal: true

class CreateMeets < ActiveRecord::Migration[6.1]
  def change
    create_table :meets do |t|
      t.string :name
      t.datetime :scheduled_at
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :status, default: 'scheduled'
      t.datetime :canceled_at
      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
