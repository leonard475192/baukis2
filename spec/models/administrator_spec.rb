require 'rails_helper'

RSpec.describe Administrator, type: :model do
  describe '#password=' do
    example 'Given a string, the hashed_password will be a string of length 60' do
      admin = Administrator.new
      admin.password = 'baukis'
      expect(admin.hashed_password).to be_kind_of(String)
      expect(admin.hashed_password.size).to eq(60)
    end

    example 'Given the nil, the hashed_password will be the nil' do
      admin = Administrator.new(
        hashed_password: 'x'
      )
      admin.password = nil
      expect(admin.hashed_password).to be_nil
    end
  end
end
