class Employee < ApplicationRecord
  belongs_to :department

  has_many :leave_requests, dependent: :destroy
  has_many :leave_balances, dependent: :destroy
  has_many :leave_types, through: :leave_balances
end
