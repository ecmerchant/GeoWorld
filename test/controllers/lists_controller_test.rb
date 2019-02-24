require 'test_helper'

class ListsControllerTest < ActionDispatch::IntegrationTest
  test "should get setup" do
    get lists_setup_url
    assert_response :success
  end

end
