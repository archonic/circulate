require "application_system_test_case"

module Account
  class ConfirmationTest < ApplicationSystemTestCase
    def setup
      @user = create(:unconfirmed_user)
      @member = create(:member, user: @user, email: "testuser#{rand(10000000)}@toollibrary.org")

      login_as @user

      ActionMailer::Base.deliveries.clear
    end

    test "new member confirms their email" do
      visit account_home_url

      assert_content "Your email has not been confirmed"

      perform_enqueued_jobs do
        click_on "Resend confirmation instructions"
      end

      assert_content "A confirmation message was sent"

      assert_emails 1
      confirmation_link = assert_singlepart_email(to: @member.email) do |body|
        assert body.has_content?("You can confirm your account email through the link below")

        body.find("a", text: "Confirm my account")
      end

      visit localize_url(confirmation_link[:href])
      assert_content "Your email address has been successfully confirmed."

      @user.reload
      assert @user.confirmed?
    end

    test "confirmed member must confirm their new address after updating their email" do
      @user.confirm

      visit edit_account_member_url
  
      fill_in "Email", with: "updated@example.test"

      perform_enqueued_jobs do
        click_on "Update Member"
      end

      assert_content "Your email has not been confirmed"

      assert_emails 1
      confirmation_link = assert_singlepart_email(to: @user.unconfirmed_email) do |body|
        assert body.has_content?("You can confirm your account email through the link below")

        body.find("a", text: "Confirm my account")
      end

      visit localize_url(confirmation_link[:href])
      assert_content "Your email address has been successfully confirmed."

      @user.reload
      assert @user.confirmed?
      refute @user.pending_reconfirmation?
    end
  end
end