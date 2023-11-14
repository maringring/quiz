
ActiveRecord::Schema[7.0].define(version: 2023_10_23_053617) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "question"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_similar_words", force: :cascade do |t|
    t.integer "question_id"
    t.string "similar_word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rankings", force: :cascade do |t|
    t.string "name"
    t.integer "correct_answers"
    t.integer "incorrect_answers"
    t.float "correct_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "record_rankings", force: :cascade do |t|
    t.string "name"
    t.integer "correct_answers"
    t.float "correct_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tag_relationships", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id", "tag_id"], name: "index_tag_relationships_on_question_id_and_tag_id", unique: true
    t.index ["question_id"], name: "index_tag_relationships_on_question_id"
    t.index ["tag_id"], name: "index_tag_relationships_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "tag_relationships", "questions"
  add_foreign_key "tag_relationships", "tags"
end
