module Users
  class ConfirmationsController < Devise::ConfirmationsController
    def create
      self.resource = resource_class.send_confirmation_instructions(resource_params)
      yield resource if block_given?

      if successfully_sent?(resource)
        redirect_back(fallback_location: account_home_path, flash: { success: "A confirmation message was sent to #{resource.email_for_reconfirmation_instructions}"})
      else
        redirect_back(fallback_location: account_home_path, flash: { error: "Confirmation instructions could not be sent."})
      end
    end

    def show
      super
      if resource.errors.empty?
        set_flash_message!(:success, :confirmed)
      end
    end
  end
end