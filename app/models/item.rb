class Item < ApplicationRecord
  validates :key, :value, presence: true
  validates :key, :value, format: { with: /\A[a-zA-Z]+\z/ }
  scope :search_by_key, ->(query) { where('key ilike ?', "%#{query}%") }
end
