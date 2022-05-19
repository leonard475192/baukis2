require 'rails_helper'

RSpec.describe StaffMember, type: :model do
  describe '#password=' do
    example 'Given a string, the hashed_password will be a string of length 60' do
      member = StaffMember.new
      member.password = 'baukis'
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end

    example 'Given the nil, the hashed_password will be the nil' do
      member = StaffMember.new(
        hashed_password: 'x'
      )
      member.password = nil
      expect(member.hashed_password).to be_nil
    end
  end
end
