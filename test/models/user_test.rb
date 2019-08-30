require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "User must have name and email" do
    u = User.new
    assert_not u.valid?
    u.name = "Foo"
    assert_not u.valid?
    u.email = "foo@bar.com"
    assert u.valid?
    u.name = ""
    assert_not u.valid?
  end

end
