class CreateWeekends < ActiveRecord::Migration
  def change
    create_table :weekends do |t|

      t.timestamps
    end
  end
end
