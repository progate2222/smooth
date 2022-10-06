class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.datetime :time_limit
      t.integer :importance
      t.boolean :completion_flag
      t.text :memo

      t.timestamps
    end
  end
end
