class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
		t.string	:first
		t.string	:last
		t.string	:email
		t.string	:password
		t.string	:password_confirmation
		t.string	:password_digest
		t.boolean	:is_member
      t.timestamps
    end
  end
end
