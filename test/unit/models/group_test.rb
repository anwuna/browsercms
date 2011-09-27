require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  def setup
    given_there_is_a_guest_group
  end

  def test_valid
    assert Factory.build(:group).valid?
  end

  test "Find guest group via method" do
    expected = Cms::Group.find_by_code(Cms::Group::GUEST_CODE)
    assert_not_nil expected
    assert_equal expected, Cms::Group.guest
  end

  test "has_permission?" do
    p1 = Factory(:permission, :name=>"Edit Things")
    p2 = Factory(:permission, :name=>"Delete things")

    group = Factory.build(:group)
    group.permissions << p1

    assert group.has_permission?("Edit Things")
    assert !group.has_permission?("Delete things")
  end
end
