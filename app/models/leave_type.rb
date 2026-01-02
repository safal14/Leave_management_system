class LeaveType < ApplicationRecord
  has_many :leave_requests, dependent: :destroy
  has_many :leave_balances, dependent: :destroy
  has_many :employees, through: :leave_balances

  validates :name, presence: true,
            
  validates :description, length: { maximum: 255 }
end
