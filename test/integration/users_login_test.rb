require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
  	@user = users(:se7enxin)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end


end

#1.访问登录页面；
#2.确认正确渲染了登录表单；
#3.提交无效的params 散列，向登录路径发起post 请求；
#4.确认重新渲染了登录表单，而且显示了一个闪现消息；
#5.访问其他页面（例如首页）；
#6.确认这个页面中没显示前面那个闪现消息。
