class CreateWeekends < ActiveRecord::Migration
  def change
    create_table :weekends do |t|
		t.date	:date
      t.timestamps
    end
  end
end
