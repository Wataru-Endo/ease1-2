require "test_helper"

class ExerciseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get exercise_index_url
    assert_response :success
  end

  test "should get show" do
    get exercise_show_url
    assert_response :success
  end
end
