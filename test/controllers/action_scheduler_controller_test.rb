require "test_helper"

class ActionSchedulerControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get action_scheduler_create_url
    assert_response :success
  end
end
