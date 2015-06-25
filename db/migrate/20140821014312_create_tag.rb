class CreateTag < ActiveRecord::Migration
  def change
    create_table :tags do |t|
		t.string :name
		t.integer :blog_count
    end
  end
end
