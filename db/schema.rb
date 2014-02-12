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

ActiveRecord::Schema.define(:version => 20140212042302) do

  create_table "admins", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "notifications", :force => true do |t|
    t.text     "message"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "preference_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
    t.integer  "sort_order"
    t.boolean  "qualitative_criteria",                :default => true
    t.boolean  "include_in_special_needs_dialog_box", :default => false
    t.text     "description"
    t.string   "select_type",                         :default => "check_mark"
    t.string   "glyph_id"
    t.string   "glyph_class"
    t.boolean  "include_in_preferences_panel",        :default => true
  end

  create_table "preferences", :force => true do |t|
    t.integer  "preference_category_id"
    t.string   "name"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "sort_order"
    t.boolean  "grade_k0",               :default => false
    t.boolean  "grade_k1",               :default => false
    t.boolean  "grade_k2",               :default => false
    t.boolean  "grade_1",                :default => false
    t.boolean  "grade_2",                :default => false
    t.boolean  "grade_3",                :default => false
    t.boolean  "grade_4",                :default => false
    t.boolean  "grade_5",                :default => false
    t.boolean  "grade_6",                :default => false
    t.boolean  "grade_7",                :default => false
    t.boolean  "grade_8",                :default => false
    t.boolean  "grade_9",                :default => false
    t.boolean  "grade_10",               :default => false
    t.boolean  "grade_11",               :default => false
    t.boolean  "grade_12",               :default => false
    t.string   "api_table_name"
    t.string   "api_table_key"
    t.string   "api_table_value"
  end

  add_index "preferences", ["preference_category_id"], :name => "index_preferences_on_preference_category_id"

  create_table "preferences_students", :id => false, :force => true do |t|
    t.integer "student_id",    :null => false
    t.integer "preference_id", :null => false
  end

  add_index "preferences_students", ["preference_id"], :name => "index_preferences_students_on_preference_id"
  add_index "preferences_students", ["student_id"], :name => "index_preferences_students_on_student_id"

  create_table "schools", :force => true do |t|
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.text     "api_basic_info"
    t.text     "api_awards"
    t.text     "api_calendar"
    t.text     "api_description"
    t.text     "api_extra_curricular"
    t.text     "api_facilities"
    t.text     "api_grades"
    t.text     "api_hours"
    t.text     "api_languages"
    t.text     "api_partners"
    t.text     "api_photos"
    t.string   "name"
    t.string   "bps_id"
    t.string   "slug"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "api_sports"
  end

  add_index "schools", ["slug"], :name => "index_schools_on_slug", :unique => true

  create_table "searches", :force => true do |t|
    t.string   "street_number"
    t.string   "street_name"
    t.string   "zipcode"
    t.string   "iep"
    t.string   "primary_language"
    t.text     "session_key"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "sibling_school_name"
    t.integer  "sibling_school_id"
    t.string   "student_1_first_name"
    t.string   "student_1_last_name"
    t.string   "student_1_grade_level"
    t.string   "student_2_first_name"
    t.string   "student_2_last_name"
    t.string   "student_2_grade_level"
    t.string   "student_3_first_name"
    t.string   "student_3_last_name"
    t.string   "student_3_grade_level"
    t.string   "student_4_first_name"
    t.string   "student_4_last_name"
    t.string   "student_4_grade_level"
    t.string   "student_5_first_name"
    t.string   "student_5_last_name"
    t.string   "student_5_grade_level"
  end

  create_table "student_schools", :force => true do |t|
    t.integer  "student_id"
    t.integer  "school_id"
    t.string   "tier"
    t.string   "walk_zone_eligibility"
    t.string   "transportation_eligibility"
    t.string   "distance"
    t.string   "walk_time"
    t.string   "drive_time"
    t.integer  "sort_order"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "bps_id"
    t.boolean  "ranked",                     :default => false
    t.boolean  "exam_school",                :default => false
    t.string   "eligibility"
  end

  add_index "student_schools", ["bps_id"], :name => "index_student_schools_on_bps_id"
  add_index "student_schools", ["school_id"], :name => "index_student_schools_on_school_id"
  add_index "student_schools", ["student_id"], :name => "index_student_schools_on_student_id"

  create_table "students", :force => true do |t|
    t.integer  "user_id"
    t.string   "session_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "grade_level"
    t.string   "street_number"
    t.string   "street_name"
    t.string   "zipcode"
    t.string   "iep"
    t.string   "primary_language"
    t.text     "sibling_school_names"
    t.text     "sibling_school_ids"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "neighborhood"
    t.boolean  "iep_needs",               :default => false
    t.boolean  "ell_needs",               :default => false
    t.time     "schools_last_updated_at"
    t.float    "x_coordinate"
    t.float    "y_coordinate"
    t.datetime "deleted_at"
    t.boolean  "address_verified",        :default => false
    t.string   "geo_code"
  end

  add_index "students", ["session_id"], :name => "index_students_on_session_id"
  add_index "students", ["user_id"], :name => "index_students_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => ""
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
