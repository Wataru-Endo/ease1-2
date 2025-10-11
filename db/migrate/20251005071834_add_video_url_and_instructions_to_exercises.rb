class AddVideoUrlAndInstructionsToExercises < ActiveRecord::Migration[8.0]
  def change
    add_column :exercises, :youtube_url, :string
    add_column :exercises, :instructions, :text
  end
end
