class AddContentToSymptoms < ActiveRecord::Migration[8.0]
  def change
    add_column :symptoms, :content, :text
  end
end
