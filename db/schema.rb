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

ActiveRecord::Schema[7.0].define(version: 2023_12_26_125028) do
  create_table "actions", force: :cascade do |t|
    t.string "service"
    t.json "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "series_id"
    t.index ["series_id"], name: "index_actions_on_series_id"
  end

  create_table "pins", force: :cascade do |t|
    t.integer "gpio"
    t.integer "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "series", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timers", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "schedulable_type"
    t.integer "schedulable_id"
    t.index ["schedulable_type", "schedulable_id"], name: "index_timers_on_schedulable"
  end

  add_foreign_key "actions", "series"
end
