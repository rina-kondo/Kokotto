require "test_helper"

class Admin::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_comments_show_url
    assert_response :success
  end
end
