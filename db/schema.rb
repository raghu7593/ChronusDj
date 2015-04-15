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

ActiveRecord::Schema.define(version: 20150415153336) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "dj_id",            limit: 4
    t.string   "dj_function_name", limit: 255
    t.integer  "dj_priority",      limit: 4
    t.integer  "dj_attempts",      limit: 4
    t.text     "dj_handler",       limit: 65535
    t.string   "dj_last_error",    limit: 255
    t.text     "dj_backtrace",     limit: 65535
    t.datetime "dj_run_at"
    t.datetime "dj_locked_at"
    t.string   "dj_locked_by",     limit: 255
    t.datetime "dj_failed_at"
    t.datetime "dj_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
