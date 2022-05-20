Rails.application.configure do
  # trueで、strong parameters無効
  config.action_controller.permit_all_parameters = true
end