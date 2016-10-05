class Cat < ActiveRecord::Base
  CAT_COLORS = %w{red black white purple}

  validates :birth_date, :name, :sex, presence: true
  validates :color, inclusion: { in: CAT_COLORS,
    message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: %w{F M},
      message: "%{value} is not a valid sex" }

  has_many :cat_rental_requests, dependent: :destroy

  def age
    (Date.today - self.birth_date)/365.to_f
  end

  
end
