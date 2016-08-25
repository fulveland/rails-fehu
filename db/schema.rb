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

ActiveRecord::Schema.define(version: 1) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "addresses", force: :cascade do |t|
    t.integer  "merchant_id"
    t.text     "name",        null: false
    t.text     "email",       null: false
    t.text     "line1",       null: false
    t.text     "line2"
    t.text     "city",        null: false
    t.text     "code",        null: false
    t.text     "region",      null: false
    t.text     "country",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["merchant_id"], name: "index_addresses_on_merchant_id", using: :btree
  end

  create_table "builds", force: :cascade do |t|
    t.integer  "variation_id"
    t.integer  "size_id"
    t.text     "model"
    t.integer  "stock",          default: 0
    t.boolean  "show_retail",    default: true, null: false
    t.boolean  "show_wholesale", default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["size_id"], name: "index_builds_on_size_id", using: :btree
    t.index ["stock"], name: "index_builds_on_stock", using: :btree
    t.index ["variation_id"], name: "index_builds_on_variation_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.text     "name",        null: false
    t.text     "date",        null: false
    t.text     "location",    null: false
    t.text     "website"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kingdoms", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_kingdoms_on_name", unique: true, using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.text     "name",                      null: false
    t.text     "url"
    t.text     "phone"
    t.text     "address"
    t.text     "city"
    t.text     "province"
    t.text     "postal"
    t.text     "country"
    t.boolean  "visible",    default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merchants", force: :cascade do |t|
    t.integer  "current_order_id"
    t.text     "email",            null: false
    t.text     "phone_number",     null: false
    t.text     "store_name",       null: false
    t.text     "your_name",        null: false
    t.text     "secret_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_merchants_on_email", unique: true, using: :btree
    t.index ["store_name"], name: "index_merchants_on_store_name", unique: true, using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.string   "order_type"
    t.integer  "order_id"
    t.integer  "build_id"
    t.text     "build_name",                     null: false
    t.text     "product_name",                   null: false
    t.integer  "price_cents",    default: 0,     null: false
    t.string   "price_currency", default: "CAD", null: false
    t.integer  "quantity",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["build_id"], name: "index_order_items_on_build_id", using: :btree
    t.index ["order_type", "order_id"], name: "index_order_items_on_order_type_and_order_id", using: :btree
  end

  create_table "product_infos", force: :cascade do |t|
    t.integer  "product_id"
    t.text     "name",                          null: false
    t.text     "content",                       null: false
    t.boolean  "show_retail",    default: true, null: false
    t.boolean  "show_wholesale", default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_product_infos_on_name", using: :btree
    t.index ["product_id"], name: "index_product_infos_on_product_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.integer  "kingdom_id"
    t.text     "name",                                     null: false
    t.boolean  "made_to_order",            default: false, null: false
    t.text     "wholesale_description"
    t.integer  "price_retail_cents",       default: 0,     null: false
    t.string   "price_retail_currency",    default: "CAD", null: false
    t.integer  "price_wholesale_cents",    default: 0,     null: false
    t.string   "price_wholesale_currency", default: "CAD", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["kingdom_id"], name: "index_products_on_kingdom_id", using: :btree
    t.index ["name"], name: "index_products_on_name", unique: true, using: :btree
  end

  create_table "retail_orders", force: :cascade do |t|
    t.integer  "address_id"
    t.uuid     "uuid",       default: -> { "uuid_generate_v4()" }
    t.text     "notes"
    t.text     "payment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sizes", force: :cascade do |t|
    t.integer  "product_id"
    t.text     "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_sizes_on_name", using: :btree
    t.index ["product_id"], name: "index_sizes_on_product_id", using: :btree
  end

  create_table "totem_items", force: :cascade do |t|
    t.integer  "totem_row_id"
    t.integer  "variation_id"
    t.text     "name"
    t.text     "image"
    t.text     "content"
    t.integer  "index",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["index"], name: "index_totem_items_on_index", using: :btree
    t.index ["totem_row_id"], name: "index_totem_items_on_totem_row_id", using: :btree
  end

  create_table "totem_rows", force: :cascade do |t|
    t.integer  "index",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["index"], name: "index_totem_rows_on_index", using: :btree
  end

  create_table "variations", force: :cascade do |t|
    t.integer  "product_id"
    t.text     "name",                                      null: false
    t.text     "model"
    t.text     "description"
    t.text     "totem_image"
    t.text     "wholesale_image"
    t.integer  "adjust_retail_cents",       default: 0,     null: false
    t.string   "adjust_retail_currency",    default: "CAD", null: false
    t.integer  "adjust_wholesale_cents",    default: 0,     null: false
    t.string   "adjust_wholesale_currency", default: "CAD", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_variations_on_name", using: :btree
    t.index ["product_id"], name: "index_variations_on_product_id", using: :btree
  end

  create_table "wholesale_orders", force: :cascade do |t|
    t.integer  "merchant_id"
    t.integer  "address_id"
    t.uuid     "uuid",        default: -> { "uuid_generate_v4()" }
    t.text     "notes"
    t.text     "payment_id"
    t.datetime "submitted"
    t.datetime "paid"
    t.datetime "shipped"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["merchant_id"], name: "index_wholesale_orders_on_merchant_id", using: :btree
  end

end
