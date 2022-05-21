require 'rails_helper'

describe Admin::Authenticator do
  describe '#authenticator' do
    example 'Returns true if the password is correct' do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example 'Returns false if the password is incorrect' do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate('xy')).to be_falsey
    end

    example 'Returns false if password is not set' do
      m = build(:administrator, password: nil)
      expect(Admin::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    example 'Returns true if he stop flag is set' do
      m = build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end
  end
end
