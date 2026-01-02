class CreateLeaveBalances < ActiveRecord::Migration[8.1]
  def change
    create_table :leave_balances do |t|
      t.integer :Total_Days
      t.integer :Used_Days
      t.integer :Remaining_Days

      t.timestamps
    end
  end
end
