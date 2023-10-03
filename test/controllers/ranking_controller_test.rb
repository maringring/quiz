require "test_helper"

class RankingControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get ranking_new_url
    assert_response :success
  end
end
