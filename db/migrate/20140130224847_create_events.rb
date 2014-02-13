class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
		t.string	:title
		t.string	:description
		t.string	:day
		t.string	:time
		t.integer	:weekend_id
      t.timestamps
    end
  end
end
