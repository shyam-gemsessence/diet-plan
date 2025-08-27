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

ActiveRecord::Schema[7.1].define(version: 2025_08_27_115545) do
  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shop_id"
    t.index ["shop_id"], name: "index_products_on_shop_id"
  end

  create_table "selected_products", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "product_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shop_id", null: false
    t.index ["customer_id"], name: "index_selected_products_on_customer_id"
    t.index ["product_id"], name: "index_selected_products_on_product_id"
    t.index ["shop_id"], name: "index_selected_products_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_shops_on_owner_id"
  end

  create_table "shops_users", id: false, force: :cascade do |t|
    t.integer "shop_id", null: false
    t.integer "user_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "role"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weekly_plans", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "product_id", null: false
    t.integer "quantity"
    t.date "delivery_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.integer "shop_id", null: false
    t.index ["customer_id"], name: "index_weekly_plans_on_customer_id"
    t.index ["product_id"], name: "index_weekly_plans_on_product_id"
    t.index ["shop_id"], name: "index_weekly_plans_on_shop_id"
  end

  add_foreign_key "products", "shops"
  add_foreign_key "selected_products", "products"
  add_foreign_key "selected_products", "shops"
  add_foreign_key "selected_products", "users", column: "customer_id"
  add_foreign_key "shops", "users", column: "owner_id"
  add_foreign_key "weekly_plans", "products"
  add_foreign_key "weekly_plans", "shops"
  add_foreign_key "weekly_plans", "users", column: "customer_id"
end
