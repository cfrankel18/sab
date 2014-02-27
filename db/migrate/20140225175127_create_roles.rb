class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
		t.boolean :will_setup
		t.boolean :will_cleanup
		t.integer :duser_id
		t.integer :event_id
      t.timestamps
    end
  end
end
