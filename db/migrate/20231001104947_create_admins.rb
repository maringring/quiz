class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :question
      t.text :description

      t.timestamps
    end
  end
end
