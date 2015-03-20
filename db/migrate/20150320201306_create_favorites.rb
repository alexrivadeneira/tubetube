class CreateFavorites < ActiveRecord::Migration
  def up
    create_table :favorites do |t|
    	t.integer "user_id"
    	# same as: t.references :user
    	t.string "title"
    	t.string "url"
    	t.string "image"
      t.timestamps
    end
    add_index("favorites", "user_id")
  end

  def down
    drop_table :favorites
  end

end