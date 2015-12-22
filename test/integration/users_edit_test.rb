require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:kira)
  end

  test 'unsuccessful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: '',
                                    email: 'invalid@',
                                    password: 'test',
                                    password_confirmation: 'different' }
    assert_template 'users/edit'
  end

  test 'successful_edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Kira'
    email = 'test@example.com'
    patch user_path(@user), user: { name: name,
                                    email: email,
                                    password: '',
                                    password_confirmation: '' }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end

