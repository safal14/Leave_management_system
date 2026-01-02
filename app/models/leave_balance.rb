class LeaveBalance < ApplicationRecord
  belongs_to :employee
  belongs_to :leave_type

  validates :total_days, :used_days, :remaining_days,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :leave_type_id, uniqueness: { scope: :employee_id }

  validate :remaining_days_correct

  private

  def remaining_days_correct
    return if total_days.blank? || used_days.blank? || remaining_days.blank?

    if remaining_days != total_days - used_days
      errors.add(:remaining_days, "must equal total_days - used_days")
    end
  end
end
