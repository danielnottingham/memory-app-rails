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
      email = User.new(email: 'valid@email.com')
      expect(email).to be_valid
    end

    it 'should not be valid email typed like ' do
      email2 = User.new(email: 'invalid@invalid@.com')
      expect(email2).to_not be_valid
    end
  end
end
