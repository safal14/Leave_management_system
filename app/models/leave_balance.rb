class LeaveBalance < ApplicationRecord
  belongs_to :employee
  belongs_to :leave_type

  # By employee
  scope :for_employee, ->(employee_id) { where(employee_id: employee_id) }

  # By leave type
  scope :for_leave_type, ->(leave_type_id) { where(leave_type_id: leave_type_id) }

  # Low balance (example threshold)
  scope :low_balance, ->(threshold = 2) {
    where("remaining_days <= ?", threshold)
  }

  validates :total_days, :used_days, :remaining_days,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :leave_type_id, uniqueness: { scope: :employee_id }

  validate :remaining_days_correct

  before_validation :set_remaining_days

  private

  def remaining_days_correct
    return if total_days.blank? || used_days.blank? || remaining_days.blank?

    if remaining_days != total_days - used_days
      errors.add(:remaining_days, "must equal total_days - used_days")
    end
  end
end
