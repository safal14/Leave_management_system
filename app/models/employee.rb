class Employee < ApplicationRecord
  belongs_to :department

  has_many :leave_requests, dependent: :destroy
  has_many :leave_balances, dependent: :destroy
  has_many :leave_types, through: :leave_balances

  validates :name, presence: true, length: { maximum: 100 }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }
            

  validates :join_date, presence: true

  validates :status, presence: true,
            
end
