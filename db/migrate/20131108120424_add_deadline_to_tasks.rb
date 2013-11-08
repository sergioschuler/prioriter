class AddDeadlineToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :deadline, :date
    add_index :tasks, :deadline
  end
end
