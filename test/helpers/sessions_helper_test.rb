require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:kira)
    remember(@user)
  end

  test 'current_user returns the right user with nil session' do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test 'current_user returns nil wiht wrong remember digest' do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end
