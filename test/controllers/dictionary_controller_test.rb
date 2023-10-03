require "test_helper"

class DictionaryControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get dictionary_new_url
    assert_response :success
  end
end
