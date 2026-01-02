class Department < ApplicationRecord
    has_many :employees, dependent: :destroy
    
    scope :with_employees, -> {
    joins(:employees).distinct
  }

    validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 100 }
end
