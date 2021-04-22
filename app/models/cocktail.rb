class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_many :reviews, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true, uniqueness: true

  include PgSearch::Model
  pg_search_scope :pg_search,
                  associated_against: {
                    cocktail: [:name],
                    ingredient: [:name]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end
