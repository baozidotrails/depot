class Product < ActiveRecord::Base

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  scope :recent, -> { order("created_at DESC").limit(2) }

  # validates(:title, :description, :image_url, :price, presence: true)
  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true,
                    length: { minimum: 10,
                              message: "at least 10 characters" }

  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  private
    def self.latest
      order(:updated_at).last
    end

    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        true
      else
        errors.add(:base, 'Line Items present')
        false
      end
    end
end
