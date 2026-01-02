class AddForeignKeysToTables < ActiveRecord::Migration[8.1]
  def change
    add_reference :employees, :department, null: true, foreign_key: true
    add_reference :leave_balances, :employee, null: false, foreign_key: true
    add_reference :leave_balances, :leave_type, null: false, foreign_key: true
    add_reference :leave_requests, :employee, null: false, foreign_key: true
    add_reference :leave_requests, :leave_type, null: false, foreign_key: true
  end
end
