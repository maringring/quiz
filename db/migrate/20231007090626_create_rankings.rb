class CreateRankings < ActiveRecord::Migration[7.0]
  def change
    create_table :rankings do |t|
      t.string :name
      t.integer :correct_answers
      t.integer :incorrect_answers
      t.float :correct_rate

      t.timestamps
    end
  end
end
