require File.dirname(__FILE__) + '/../test_helper'
require 'request_controller'

# Re-raise errors caught by the controller.
class RequestController; def rescue_action(e) raise e end; end

class RequestControllerTest < Test::Unit::TestCase
  fixtures :requests, :songs

  def setup
    @controller = RequestController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    assert @controller.request
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
