require "test_helper"

class FindpasswordControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm" do
    get findpassword_confirm_url
    assert_response :success
  end

  test "should get update" do
    get findpassword_update_url
    assert_response :success
  end
end
