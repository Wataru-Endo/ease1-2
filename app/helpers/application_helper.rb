module ApplicationHelper
  # お気に入りボタンヘルパー
  def favorite_button(exercise, options = {})
    return unless current_user

    css_class = options[:class] || "btn btn-sm"

    if current_user.favorited?(exercise)
      link_to exercise_favorite_path(exercise), method: :delete,
              class: "#{css_class} btn-danger favorite-btn" do
        content_tag :i, "", class: "fas fa-heart"
      end
    else
      link_to exercise_favorites_path(exercise), method: :post,
              class: "#{css_class} btn-outline-danger favorite-btn" do
        content_tag :i, "", class: "far fa-heart"
      end
    end
  end

  # 症状バッジカラー
  def symptom_badge_color(symptom_name)
    case symptom_name
    when "腰痛"
      "danger"
    when "肩こり"
      "warning"
    when "首の痛み"
      "info"
    when "膝の痛み"
      "success"
    when "頭痛"
      "secondary"
    when "眼精疲労"
      "primary"
    else
      "light"
    end
  end

  # エクササイズタイプバッジ
  def exercise_type_badge(exercise)
    if exercise.selfcare?
      content_tag :span, "🌸 セルフケア", class: "badge bg-success"
    else
      content_tag :span, "💪 エクササイズ", class: "badge bg-primary"
    end
  end
end
