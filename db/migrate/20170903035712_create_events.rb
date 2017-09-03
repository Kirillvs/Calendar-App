class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :start
      t.boolean :repetitive
      t.integer :repeat_period

      t.timestamps
    end
  end
end
