class CreateTagRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_relationships do |t|
      t.references :question, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    #동일한 태그 두번 저장 방지
    add_index :tag_relationships, [:question_id, :tag_id], unique: true
  end
end
