class AddTaskRefToRequests < ActiveRecord::Migration[6.1]
  def change
    add_reference :requests, :task, null: false, foreign_key: true
  end
end
