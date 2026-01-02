class LeaveRequest < ApplicationRecord
  belongs_to :employee
  belongs_to :leave_type

  validates :start_date, :end_date, :status, presence: true

  validates :status,
            inclusion: { in: %w[pending approved rejected cancelled] }

  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?

    errors.add(:end_date, "must be after start date") if end_date < start_date
  end
end
