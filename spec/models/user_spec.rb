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
end
