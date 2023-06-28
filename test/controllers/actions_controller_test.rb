require "test_helper"

class ActionsControllerTest < ActionDispatch::IntegrationTest
  test "should get execute" do
    get actions_execute_url
    assert_response :success
  end
end
