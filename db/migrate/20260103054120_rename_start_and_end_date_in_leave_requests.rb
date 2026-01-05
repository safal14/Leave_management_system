class RenameStartAndEndDateInLeaveRequests < ActiveRecord::Migration[8.1]
  def change
    rename_column :leave_requests, :Start_Date, :start_date
    rename_column :leave_requests, :End_Date, :end_date
  end
end
