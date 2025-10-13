module ApplicationHelper
  def favorite_button(exercise)
    if logged_in?
      if current_user.favorited?(exercise)
        # お気に入り済み - 削除ボタン
        button_to exercise_unfavorite_path(exercise), 
                  method: :delete, 
                  class: "btn btn-warning btn-sm favorite-btn",
                  style: "display: inline-block;",
                  data: { confirm: "お気に入りから削除しますか？" } do
          content_tag(:i, "", class: "fas fa-heart me-1") + "お気に入り済み"
        end
      else
        # 未お気に入り - 追加ボタン
        button_to exercise_favorite_path(exercise), 
                  method: :post, 
                  class: "btn btn-outline-warning btn-sm favorite-btn",
                  style: "display: inline-block;" do
          content_tag(:i, "", class: "far fa-heart me-1") + "お気に入りに追加"
        end
      end
    end
  end
end