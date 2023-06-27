class TestResultsController < ApplicationController
  before_action :authenticate_user!, only: :result
  before_action :check_test_completed, only: :result
  def result
    @test_results = current_user.test_results.includes(:question).order(created_at: :desc).limit(5)

    # 合計点数の初期化
    total_score = 0

    # テスト結果の処理
    @test_results.each do |result|
      # 正解の比較と点数の加算
      if result.is_correct
        total_score += 1
      end
    end
    # 合計得点をscoreカラムに保存
    @test_results.first.update(score: total_score)
    @total_score = total_score

    average_score = calculate_and_save_average_score(current_user)
  end

  private
  def calculate_and_save_average_score(user)
    test_attempts = user.test_attempts
    total_score = user.test_results.where(is_correct: true).count
  
    average_score = (test_attempts > 0) ? (total_score.to_f / test_attempts) : 0
  
    user.update(average_score: average_score) # average_scoreをuserテーブルのカラムに保存する
  
    return average_score
  end

  def check_test_completed
    redirect_to root_path unless test_completed?
  end

  def test_completed?
    # テストの回答結果が存在するかどうかで判定できます
    TestResult.exists?(user_id: current_user.id)
  end
    
end
