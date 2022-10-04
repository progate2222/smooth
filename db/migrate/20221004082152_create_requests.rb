class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.text :message
      t.bigint :predecessor_id
      t.bigint :successor_id
      t.timestamps
    end
  end
end
