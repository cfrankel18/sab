class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
		t.string	:title
		t.string	:content
		t.integer	:duser_id
      t.timestamps
    end
  end
end
