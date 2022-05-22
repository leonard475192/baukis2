require "rails_helper"

RSpec.describe "Admin::StaffMembers", type: :request do
  let(:administrator) { create(:administrator) }

  describe "Create" do
    let(:params_hash) { attributes_for(:staff_member) }

    example "Redirect to staff list page" do
      post admin_staff_members_url, params: { staff_member: params_hash }
      expect(response).to redirect_to(admin_staff_members_url)
    end

    example "Exception ActionController::ParameterMissing occurs" do
      expect { post admin_staff_members_url }.to raise_error(ActionController::ParameterMissing)
    end
  end

  describe "Update" do
    let(:staff_member) { create(:staff_member) }
    let(:params_hash) { attributes_for(:staff_member) }

    example "Set the suspended flag " do
      params_hash.merge!(suspended: true)
      patch admin_staff_members_url(staff_member),
      params: { staff_member: params_hash }
      staff_member.reload
      expect(staff_member).to be_suspended
    end

    example "hash_password cannot be rewritten." do
      params_hash.delete(:password)
      params_hash.merge!(hash_password: "x")
      expect {
        patch admin_staff_members_url(staff_member),
        params: { staff_member: params_hash }
      }.not_to change { staff_member.hash_password.to_s }
    end
  end
end