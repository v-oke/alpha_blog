require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "Tech")
    @admin = User.create(username: "test",
                          email: "test@gmail.com",
                          password: "password",
                          admin: true)
  end
  test "should get categories index" do
    get categories_path, as: :html
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@admin)
    get new_category_path, as: :html
    assert_response :success
  end

  test "should get show" do
    get category_path(@category)
    assert_response :success
  end

  test "should redirect create when admin not logged in" do
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: "tech" } }
    end

    assert_response :redirect
    assert_redirected_to root_path
  end
end
