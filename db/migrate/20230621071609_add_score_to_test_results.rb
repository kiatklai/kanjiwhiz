class AddScoreToTestResults < ActiveRecord::Migration[6.0]
  def change
    add_column :test_results, :score, :integer
  end
end
