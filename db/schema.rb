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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130105203253) do

  create_table "interventions", :force => true do |t|
    t.integer  "number",                      :null => false
    t.string   "address",                     :null => false
    t.string   "near_corner"
    t.string   "kind",           :limit => 1, :null => false
    t.string   "kind_notes"
    t.integer  "receptor_id",                 :null => false
    t.integer  "hierarchy_id"
    t.text     "observations"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "truck_id"
    t.datetime "out_at"
    t.datetime "arrive_at"
    t.datetime "back_at"
    t.datetime "in_at"
    t.integer  "out_mileage"
    t.integer  "arrive_mileage"
    t.integer  "back_mileage"
    t.integer  "in_mileage"
  end

  add_index "interventions", ["kind"], :name => "index_interventions_on_kind"
  add_index "interventions", ["number"], :name => "index_interventions_on_number", :unique => true
  add_index "interventions", ["receptor_id"], :name => "index_interventions_on_receptor_id"
  add_index "interventions", ["truck_id"], :name => "index_interventions_on_truck_id"

  create_table "trucks", :force => true do |t|
    t.integer  "number"
    t.integer  "mileage"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "trucks", ["number"], :name => "index_trucks_on_number", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name",                                   :null => false
    t.string   "lastname"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "roles_mask",             :default => 0,  :null => false
    t.integer  "lock_version",           :default => 0,  :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["lastname"], :name => "index_users_on_lastname"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.integer  "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"
  add_index "versions", ["whodunnit"], :name => "index_versions_on_whodunnit"

end
