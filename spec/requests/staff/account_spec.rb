require 'rails_helper'

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

  describe "Update" do
    let(:params_hash) { attributes_for(:staff_member) }
    let(:staff_member) { create(:staff_member) }

    example "" do
      params_hash.merge!(email: "test@example.com")
      patch staff_account_url,
      params: {
        id: staff_member.id,
        staff_member: params_hash,
      }
      staff_member.reload
      expect(staff_member.email).to eq("test@example.com")
    end

    example "" do
      expect {
        patch staff_account_url,
        params: {
          id: staff_member.id
        }
      }.to raise_error(AccountController::ParameterMissing)
    end

    example "" do
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
