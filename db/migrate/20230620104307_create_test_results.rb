class CreateTestResults < ActiveRecord::Migration[6.0]
  def change
    create_table :test_results do |t|
      t.string :user_answer, null: false
      t.boolean :is_correct
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true 
      t.timestamps
    end
  end
end
