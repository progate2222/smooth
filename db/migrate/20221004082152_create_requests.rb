class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.text :message
      t.bigint :successor_id
      t.timestamps
    end
  end
end
