class ApplicationHelperTest < ActionView::TestCase
  test "should return 'No records to display' in table row if collection size is zero" do
    collection = []
    assert_dom_equal %{<tr><td>No records to display</td></tr>}, no_table_records_msg(collection)
  end

  test "should return 'No records to display' if collection size is zero" do
    collection = []
    assert_dom_equal %{No records to display}, no_records_msg(collection)
  end
end