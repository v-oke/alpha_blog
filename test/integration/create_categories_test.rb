require "test_helper"

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
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
end
