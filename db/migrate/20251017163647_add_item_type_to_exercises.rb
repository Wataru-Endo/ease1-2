class AddItemTypeToExercises < ActiveRecord::Migration[8.0]
  def change
    # item_type カラム追加（enumのために必須）
    add_column :exercises, :item_type, :integer, default: 0, null: false

    # published カラム追加
    add_column :exercises, :published, :boolean, default: true, null: false

    # 既存データの更新
    reversible do |dir|
      dir.up do
        # 既存のすべてのExerciseをエクササイズタイプ（0）に設定
        execute "UPDATE exercises SET item_type = 0, published = true WHERE item_type IS NULL"
      end
    end

    # パフォーマンス向上のためインデックス追加
    add_index :exercises, :item_type
    add_index :exercises, :published
  end
end
