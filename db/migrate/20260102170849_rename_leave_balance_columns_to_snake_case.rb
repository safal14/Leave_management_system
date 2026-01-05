class RenameLeaveBalanceColumnsToSnakeCase < ActiveRecord::Migration[8.1]
  def change
    rename_column :leave_balances, :Total_Days, :total_days
    rename_column :leave_balances, :Used_Days, :used_days
    rename_column :leave_balances, :Remaining_Days, :remaining_days
  end
end
