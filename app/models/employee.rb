class Employee < ApplicationRecord
  belongs_to :department
 
  has_many :leave_requests, dependent: :destroy
  has_many :leave_balances, dependent: :destroy
  has_many :leave_types, through: :leave_balances

   # Status-based
  scope :active,   -> { where(status: 'active') }
  scope :inactive, -> { where(status: 'inactive') }

  # Department-based
  scope :in_department, ->(department_id) {
    where(department_id: department_id)
  }

  # Recently joined
  scope :recent_joins, -> { order(join_date: :desc) }

  validates :name, presence: true, length: { maximum: 100 }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }
            

  validates :join_date, presence: true

  validates :status, presence: true,
            
end
