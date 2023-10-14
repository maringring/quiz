require "test_helper"

class MypageControllerTest < ActionDispatch::IntegrationTest
  test "should get admin" do
    get mypage_admin_url
    assert_response :success
  end
end
