require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "should not create new user with form errors" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                               email: "user@invalid",
                               password: "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
  end

  test "should create new user with valid form" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Example",
                                            email: "user@valid.example",
                                            password: "testing",
                                            password_confirmation: "testing" }
    end
    assert_template 'users/show'
  end
end
