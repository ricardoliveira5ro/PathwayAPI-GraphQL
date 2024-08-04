class Roadmap < ApplicationRecord
  belongs_to :user, required: false
  has_many :roadmap_categories, dependent: :destroy
  has_many :categories, through: :roadmap_categories
  has_many :steps, -> { order(:order) }, dependent: :destroy

  validates :title, :description, :categories, presence: true
end
