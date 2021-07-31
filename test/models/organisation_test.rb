require 'test_helper'

class OrganisationTest < ActiveSupport::TestCase
  def setup
    @org = organisations(:one)
  end

  test "organisation should be valid" do
    assert @org.valid?, "organisation is not valid"
  end

  test "organisation name must be present" do
    @org.name = " "
    assert_not @org.valid?, "name is empty string"
  end

  #should this be nil or " " or check against both?
  test "organisation hourly rate must be present" do
    @org.hourly_rate = nil
    assert_not @org.valid?, "hourly rate is not present"
  end

  #not sure if I need this test
  test "organisation hourly rate must not be empty string" do
    @org.hourly_rate = " "
    assert_not @org.valid?, "hourly rate is not present"
  end

  test "organisation hourly rate must be a decimal" do
    @org.hourly_rate = "1D"
    assert_not @org.valid?, "hourly rate is not a number"
  end 

  test "organisation hourly rate must not be negative" do
    @org.hourly_rate = -1
    assert_not @org.valid?, "hourly rate can't be negative"
  end
end
