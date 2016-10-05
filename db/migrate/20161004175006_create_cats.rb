class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.date :birth_date, null: false
      t.string :color
      t.string :name, null: false
      t.string :sex, null: false, limit: 1
      t.text :description
      t.timestamps null: false
    end

    add_index :cats, :name
  end
end
