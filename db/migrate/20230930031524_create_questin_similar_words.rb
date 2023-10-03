class CreateQuestinSimilarWords < ActiveRecord::Migration[7.0]
  def change
    create_table :questin_similar_words do |t|
        t.integer :question_id
        t.string :similar_word

      t.timestamps
    end
  end
end
