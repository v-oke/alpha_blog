require "test_helper"

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @admin = User.create(username: "test",
                          email: "test@gmail.com",
                          password: "password",
                          admin: true)
  end

  test "get new category form and create category" do
    sign_in_as(@admin)
    # Visit the new form
    get new_category_path
    assert_response :success
    assert_select "h1", "New Category"   # assuming your form page has this title

    # Submit the form
    assert_difference "Category.count", 1 do
      post categories_path, params: { category: { name: "tech" } }
    end

    # Follow redirect after create
    follow_redirect!
    assert_response :success

    # Verify category appears on index page
    assert_match "tech", response.body
  end

  test "invalid category submission results in failure" do
    sign_in_as(@admin)
    # Visit the new form
    get new_category_path
    assert_response :success
    assert_select "h1", "New Category"   # assuming your form page has this title

    # Submit the form
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: " " } }
    end

    # Assert the form is re-rendered
    assert_response :unprocessable_entity

    # Verify errors appear on the re-rendered page
    assert_select "div.alert"
  end
end
