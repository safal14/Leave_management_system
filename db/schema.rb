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

ActiveRecord::Schema[8.1].define(version: 2026_01_03_054120) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "departments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "department_id"
    t.string "email"
    t.date "join_date"
    t.string "name"
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_employees_on_department_id"
  end

  create_table "leave_balances", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "employee_id", null: false
    t.bigint "leave_type_id", null: false
    t.integer "remaining_days"
    t.integer "total_days"
    t.datetime "updated_at", null: false
    t.integer "used_days"
    t.index ["employee_id"], name: "index_leave_balances_on_employee_id"
    t.index ["leave_type_id"], name: "index_leave_balances_on_leave_type_id"
  end

  create_table "leave_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "employee_id", null: false
    t.date "end_date"
    t.bigint "leave_type_id", null: false
    t.date "start_date"
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_leave_requests_on_employee_id"
    t.index ["leave_type_id"], name: "index_leave_requests_on_leave_type_id"
  end

  create_table "leave_types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "employees", "departments"
  add_foreign_key "leave_balances", "employees"
  add_foreign_key "leave_balances", "leave_types"
  add_foreign_key "leave_requests", "employees"
  add_foreign_key "leave_requests", "leave_types"
end
