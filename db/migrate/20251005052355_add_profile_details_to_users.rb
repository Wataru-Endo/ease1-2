class AddProfileDetailsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :birth_date, :date
    add_column :users, :age, :integer
    add_column :users, :gender, :string
    add_column :users, :height, :float
    add_column :users, :weight, :float
    add_column :users, :primary_symptom, :string
  end
end
