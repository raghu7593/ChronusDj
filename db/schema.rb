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

ActiveRecord::Schema.define(version: 20150419121910) do

  create_table "delayed_job_sites", force: :cascade do |t|
    t.string   "environment",    limit: 255
    t.string   "url",            limit: 255
    t.boolean  "active",         limit: 1,   default: true
    t.string   "user_name",      limit: 255
    t.string   "password",       limit: 255
    t.string   "lastpass_match", limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "delayed_job_site_id", limit: 4
    t.integer  "dj_id",               limit: 4
    t.string   "dj_function_name",    limit: 255
    t.integer  "dj_priority",         limit: 4
    t.integer  "dj_attempts",         limit: 4
    t.text     "dj_handler",          limit: 65535
    t.string   "dj_last_error",       limit: 255
    t.text     "dj_backtrace",        limit: 65535
    t.datetime "dj_run_at"
    t.datetime "dj_locked_at"
    t.string   "dj_locked_by",        limit: 255
    t.datetime "dj_failed_at"
    t.datetime "dj_created_at"
    t.boolean  "dj_resolved",         limit: 1,     default: false
    t.boolean  "dj_valid",            limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["dj_id"], name: "index_delayed_jobs_on_dj_id", unique: true, using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "provider",    limit: 255
    t.string   "uid",         limit: 255
    t.string   "name",        limit: 255
    t.string   "profile_pic", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

end
