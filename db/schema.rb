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

ActiveRecord::Schema[8.1].define(version: 2025_12_03_230000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "cities", force: :cascade do |t|
    t.boolean "active"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_cities_on_active"
    t.index ["name"], name: "index_cities_on_name", unique: true
  end

  create_table "drivers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "fiscal_number"
    t.string "name"
    t.string "phone"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["fiscal_number", "phone"], name: "index_drivers_on_fiscal_number_and_phone", unique: true
    t.index ["status"], name: "index_drivers_on_status"
  end

  create_table "employees", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "fiscal_number"
    t.string "name"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end

  create_table "employees_roles", id: false, force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "role_id"
    t.index ["employee_id", "role_id"], name: "index_employees_roles_on_employee_id_and_role_id"
    t.index ["employee_id"], name: "index_employees_roles_on_employee_id"
    t.index ["role_id"], name: "index_employees_roles_on_role_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "address_line"
    t.bigint "city_id", null: false
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_locations_on_city_id"
    t.index ["name", "address_line", "city_id"], name: "index_locations_on_name_and_address_line_and_city_id"
  end

  create_table "manifests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "created_by_id", null: false
    t.bigint "destination_location_id", null: false
    t.bigint "driver_id", null: false
    t.datetime "end_at"
    t.bigint "original_location_id", null: false
    t.datetime "scheduled_end_at"
    t.datetime "scheduled_start_at"
    t.datetime "start_at"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id", null: false
    t.index ["created_by_id"], name: "index_manifests_on_created_by_id"
    t.index ["destination_location_id"], name: "index_manifests_on_destination_location_id"
    t.index ["driver_id"], name: "index_manifests_on_driver_id"
    t.index ["original_location_id"], name: "index_manifests_on_original_location_id"
    t.index ["status", "scheduled_start_at", "start_at", "end_at"], name: "idx_on_status_scheduled_start_at_start_at_end_at_65dfd30711"
    t.index ["vehicle_id"], name: "index_manifests_on_vehicle_id"
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "employee_id", null: false
    t.string "session_token"
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_sessions_on_employee_id"
  end

  create_table "stops", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "location_id", null: false
    t.bigint "manifest_id", null: false
    t.string "notes"
    t.integer "position"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_stops_on_location_id"
    t.index ["manifest_id", "position", "status"], name: "index_stops_on_manifest_id_and_position_and_status"
    t.index ["manifest_id"], name: "index_stops_on_manifest_id"
  end

  create_table "vehicle_types", force: :cascade do |t|
    t.boolean "active"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_vehicle_types_on_active"
    t.index ["name"], name: "index_vehicle_types_on_name", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "plate"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_type_id", null: false
    t.index ["plate"], name: "index_vehicles_on_plate", unique: true
    t.index ["status"], name: "index_vehicles_on_status"
    t.index ["vehicle_type_id"], name: "index_vehicles_on_vehicle_type_id"
  end

  add_foreign_key "locations", "cities"
  add_foreign_key "manifests", "drivers"
  add_foreign_key "manifests", "employees", column: "created_by_id"
  add_foreign_key "manifests", "locations", column: "destination_location_id"
  add_foreign_key "manifests", "locations", column: "original_location_id"
  add_foreign_key "manifests", "vehicles"
  add_foreign_key "sessions", "employees"
  add_foreign_key "stops", "locations"
  add_foreign_key "stops", "manifests"
  add_foreign_key "vehicles", "vehicle_types"
end
