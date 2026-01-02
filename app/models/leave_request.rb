class LeaveRequest < ApplicationRecord
  belongs_to :employee
  belongs_to :leave_type
end
