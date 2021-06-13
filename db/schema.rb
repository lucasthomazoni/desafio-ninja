# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_613_205_506) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'meets', force: :cascade do |t|
    t.string 'name'
    t.datetime 'scheduled_at'
    t.datetime 'starts_at'
    t.datetime 'ends_at'
    t.string 'status', default: 'scheduled'
    t.datetime 'canceled_at'
    t.bigint 'created_by_id'
    t.bigint 'room_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['created_by_id'], name: 'index_meets_on_created_by_id'
    t.index ['room_id'], name: 'index_meets_on_room_id'
  end

  create_table 'rooms', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'meets', 'rooms'
  add_foreign_key 'meets', 'users', column: 'created_by_id'
end
