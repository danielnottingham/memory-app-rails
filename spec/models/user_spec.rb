require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'not empty' do
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'field email format only' do
    it { is_expected.to_not allow_value('/\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/').for(:email).on(:create) }
  end

  describe 'validates uniqueness of email' do
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe 'valid email typed' do
    it 'should be valid email typed like ' do
      user1 = User.new(email: 'valid@email.com')
      expect(user1).to be_valid
    end

    it 'should not be valid email typed like ' do
      user2 = User.new(email: 'invalid@invalid@.com')
      expect(user2).to_not be_valid
      expect(user2.errors[:email]).to include('is invalid')
    end
  end
end
