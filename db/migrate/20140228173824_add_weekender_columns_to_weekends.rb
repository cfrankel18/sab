class AddWeekenderColumnsToWeekends < ActiveRecord::Migration
  def self.up
	add_attachment :weekends, :weekender
  end

  def self.down
	remove_attachment :weekends, :weekender
  end
end
