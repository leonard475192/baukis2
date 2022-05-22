require 'rails_helper'

RSpec.describe "Staff::Accounts", "before login", type: :request do
  include_examples "a protrected singular staff controller", "staff/accounts"
end

RSpec.describe "Staff::Accounts", type: :request do
  before do
    post staff_sesion_url,
    params: {
      staff_login_form: {
        email: staff_member.email,
        password: "pw"
      }
    }
  end

  describe "Show" do
    let(:staff_member) { create(:staff_member) }

    example "Success" do
      get staff_account_url
      expect(response.status).to eq(200)
    end

    example "Forced logout if suspended flag is true" do
      staff_member.update_colimn(:suspended, true)
      get staff_account_url
      expect(response).to redirect_to(staff_login_url)
    end

    example "Session timeout" do
      travel_to Staff::Base::TIMEOUT.from_now.advance(seconds: 1)
      get staff_account_url
      expect(response).to redirect_to(staff_login_url)
    end
  end


  describe "Update" do
    let(:params_hash) { attributes_for(:staff_member) }
    let(:staff_member) { create(:staff_member) }

    example "Change my email" do
      params_hash.merge!(email: "test@example.com")
      patch staff_account_url,
      params: {
        id: staff_member.id,
        staff_member: params_hash,
      }
      staff_member.reload
      expect(staff_member.email).to eq("test@example.com")
    end

    example "Exception ActionController::ParameterMissing occurs" do
      expect {
        patch staff_account_url,
        params: {
          id: staff_member.id
        }
      }.to raise_error(AccountController::ParameterMissing)
    end

    example "End_date cannot be rewritten." do
      params_hash.merge!(end_date: Date.tomorrow)
      expect {
        patch staff_account_url,
        params: {
          id: staff_member.id,
          staff_member: params_hash
        }
      }.not_to change { staff_member.end_date }
    end
  end
end
