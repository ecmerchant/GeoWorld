require 'test_helper'

class SchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get setup" do
    get schedules_setup_url
    assert_response :success
  end

end
