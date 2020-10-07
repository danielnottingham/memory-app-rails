FactoryBot.define do
  factory :user do
    email { 'daniel@gmail.com' }
  end

  factory :item do
    key { 'Dan' }
    value { 'Nottingham' }
    visible { true }
  end
end
