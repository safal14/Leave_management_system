class CreateLeaveRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :leave_requests do |t|
      t.date :Start_Date
      t.date :End_Date
      t.string :status

      t.timestamps
    end
  end
end
