# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160129030321) do

  create_table "patterns", force: :cascade do |t|
    t.integer "place_id"
    t.integer "truck_id"
    t.string  "type"
    t.string  "value"
  end

  create_table "places", force: :cascade do |t|
    t.float  "latitude"
    t.float  "longitude"
    t.string "city"
    t.string "cross"
    t.string "main"
    t.string "name"
    t.string "neighborhood"
    t.string "number"
    t.string "source"
    t.string "street"
    t.string "type"
  end

  create_table "trucks", force: :cascade do |t|
    t.string "city"
    t.string "name"
    t.string "site"
    t.string "source"
  end

end
