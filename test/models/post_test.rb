require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Post must have title and body" do
    p = Post.new
    assert_not p.valid?
    p.title = "title"
    assert_not p.valid?
    p.body = "body"
    assert p.valid?
    p.title = ""
    assert_not p.valid?
  end
end
