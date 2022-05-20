require 'rails_helper'

describe Staff::Authenticator do
  describe '#authenticator' do
    example 'Returns true if the password is correct' do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example 'Returns false if the password is incorrect' do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate('xy')).to be_falsey
    end

    example 'Returns false if password is not set' do
      m = build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    example 'Returns true if he stop flag is set' do
      m = build(:staff_member, suspended: true)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example 'Returns false if before start' do
      m = build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end

    example 'Returns false if after the end' do
      m = build(:staff_member, end_date: Date.today)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end
  end
end
