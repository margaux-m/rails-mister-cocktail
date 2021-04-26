class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_many :reviews, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true, uniqueness: true

  after_commit :set_default_picture, on: [:create]

  include PgSearch::Model
  pg_search_scope :cocktail_search,
                  against: [:name],
                  using: {
                    tsearch: { prefix: true }
                  }

  private

  def set_default_picture
    return if photo.attached?

    photo.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'cocktail-default-home.svg')),
      filename: 'cocktail-default-home.svg',
      content_type: 'image/svg'
    )
  end
end
