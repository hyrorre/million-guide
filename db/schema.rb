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

ActiveRecord::Schema.define(version: 20171101104000) do

  create_table "musics", force: :cascade do |t|
    t.string "idstr"
    t.string "title"
    t.string "kana"
    t.integer "musictype"
    t.integer "order"
    t.date "added_on"
    t.date "updated_on"
    t.integer "level_2m"
    t.integer "level_2mp"
    t.integer "level_4m"
    t.integer "level_6m"
    t.integer "level_mm"
    t.integer "level_mmp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
