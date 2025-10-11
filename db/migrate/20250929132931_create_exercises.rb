class CreateExercises < ActiveRecord::Migration[8.0]
  def change
    create_table :exercises do |t|
      t.string :title
      t.text :description
      t.text :steps
      t.integer :duration
      t.references :symptom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
