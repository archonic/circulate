require "application_system_test_case"

class MemberPaymentTest < ApplicationSystemTestCase
  def setup
    sign_in_as_admin
  end

  test "re-sends a member's confirmation email"
end
