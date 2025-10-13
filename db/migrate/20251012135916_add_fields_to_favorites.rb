class AddFieldsToFavorites < ActiveRecord::Migration[8.0]
  def change
    add_column :favorites, :memo, :text
    add_column :favorites, :rating, :integer
    add_column :favorites, :personal_notes, :text
  end
end
