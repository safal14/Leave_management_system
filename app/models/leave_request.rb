class LeaveRequest < ApplicationRecord
  belongs_to :employee
  belongs_to :leave_type

  
  # Status-based scopes
  scope :pending,   -> { where(status: 'pending') }
  scope :approved,  -> { where(status: 'approved') }
  scope :rejected,  -> { where(status: 'rejected') }
  scope :cancelled, -> { where(status: 'cancelled') }

  # Employee-based
  scope :for_employee, ->(employee_id) { where(employee_id: employee_id) }

  # Leave type-based
  scope :for_leave_type, ->(leave_type_id) { where(leave_type_id: leave_type_id) }

  # Date-based
  scope :starting_from, ->(date) { where("start_date >= ?", date) }
  scope :ending_until,  ->(date) { where("end_date <= ?", date) }

  # Recent leaves
  scope :recent, -> { order(created_at: :desc) }

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
