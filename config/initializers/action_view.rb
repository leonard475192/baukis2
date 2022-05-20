Rails.application.configure do
  # trueで、form_withで生成されるformのsubmitをajaxで行う
  config.action_view.form_with_generates_remote_forms = false
end