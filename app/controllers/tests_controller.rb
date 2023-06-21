class TestsController < ApplicationController
  before_action :authenticate_user!, only: [:answer, :show]

  def show
    # テストの問題をランダムに5問取得する（questionsテーブルからの取得方法は略）
    @questions = Question.order('RAND()').limit(5)
    @question_number = 1
    # 最初の問題を表示
    @current_question = @questions.first
  end

  def answer
    # ユーザーが送信した回答を取得
    user_answer = params[:user_answer]
    # 問題番号を更新
    @question_number += 1
  
    # 現在の問題の正解を取得
    correct_answer = @current_question.correct_answer
  
    # 回答の正誤を判定して結果を保存
    is_correct = (user_answer == correct_answer)
    TestResult.create(user: current_user, question: @current_question, user_answer: user_answer, is_correct: is_correct)
  
    # 次の問題に遷移
    next_question_index = @questions.index(@current_question) + 1
    if next_question_index < @questions.size
      @current_question = @questions[next_question_index]
      render 'show' # 同じテスト画面を表示して次の問題に進む
    else
      # テストが終了した場合、合計取得点数と正解を表示
      total_score = TestResult.where(user: current_user, is_correct: true).count
      @result = { total_score: total_score, correct_answers: @questions.where(id: TestResult.where(user: current_user, is_correct: true).pluck(:question_id)) }
      @question_number = 1
      redirect_to test_results_result_path # テスト結果画面にリダイレクト
    end
  end
end
