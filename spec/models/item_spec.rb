require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { User.create(:user) }

  describe 'not empty' do
    it { is_expected.to validate_presence_of(:key) }
    it { is_expected.to validate_presence_of(:value) }
  end

  describe 'field format characters only' do
    it { is_expected.to_not allow_value('/\A[a-zA-Z]+\z/').for(:key).on(:create) }
    it { is_expected.to_not allow_value('/\A[a-zA-Z]+\z/').for(:value).on(:create) }
  end
end
