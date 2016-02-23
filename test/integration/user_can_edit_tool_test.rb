require 'test_helper'

class DoesthisworkTest < ActionDispatch::IntegrationTest
  test "user can edit an existing tool" do
    tool = Tool.create(name: "screwdriver", quantity: 10, price: 1000)

    # visit edit_tool_path(tool.id)

    visit "/tools/#{tool.id}/edit"

    fill_in "Name", with: "wrench"
    fill_in "tool[quantity]", with: 11
    fill_in "Price", with: "2000"

    click_button "Update Tool"

    assert_equal current_path, tool_path(tool.id)

    within(".tool_info") do
      assert page.has_content?("wrench")
      assert page.has_content?("11")
      assert page.has_content?("20.0")
    end
  end
end
