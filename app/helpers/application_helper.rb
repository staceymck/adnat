module ApplicationHelper
  def no_table_records_msg(collection)
    (tag.tr tag.td('No records to display')) if collection.size == 0 
  end

  def no_records_msg(collection)
    'No records to display' if collection.size == 0
  end
end
