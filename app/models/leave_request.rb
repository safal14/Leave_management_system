class LeaveRequest < ApplicationRecord
  belongs_to :employee
  belongs_to :leave_type

  validates :start_date, :end_date, :status, presence: true

  validates :status,
            inclusion: { in: %w[pending approved rejected cancelled] }

  validate :end_date_after_start_date
  
  after_update :deduct_leave_balance, if: :approved?

  private
  
  def leave_days
    return 0 if start_date.blank? || end_date.blank?
    (end_date - start_date).to_i + 1
  end

  def approved?
    saved_change_to_status? && status == 'approved'
  end

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?

    errors.add(:end_date, "must be after start date") if end_date < start_date
  end
  def sufficient_leave_balance
    return unless approved?

    balance = LeaveBalance.find_by(
      employee_id: employee_id,
      leave_type_id: leave_type_id
    )

    if balance.nil? || balance.remaining_days < leave_days
      errors.add(:base, "Insufficient leave balance")
      throw(:abort)
    end
  end

  def deduct_leave_balance
    balance = LeaveBalance.find_by(
      employee_id: employee_id,
      leave_type_id: leave_type_id
    )

    balance.update!(
      used_days: balance.used_days + leave_days
    )
  end

end
