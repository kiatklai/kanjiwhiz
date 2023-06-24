class TestsController < ApplicationController
  before_action :authenticate_user!, only: [:answer, :show]

  def show
    if Question.exists?
    # テストの問題をランダムに5問取得する（questionsテーブルからの取得方法は略）
    @questions = Question.order('RANDOM()').limit(6)
    @question_number = 1
  # 最初の問題を表示
    @current_question = @questions.first
    session[:questions] = @questions # セッションに問題を保存
    session[:question_number] = @question_number # セッションに問題番号を保存
    else
      redirect_to root_path, alert: "問題が設定されていません"  # 問題が設定されていない場合はトップページにリダイレクトし、アラートメッセージを表示する
    end
  end

  def answer
    # ユーザーが送信した回答を取得
    user_answer = params[:user_answer][:user_answer]
    
    # 現在の問題の正解を取得
    @questions = session[:questions].map { |question| Question.find(question["id"]) }
    @question_number = session[:question_number]
    @current_question = @questions[@question_number]
    correct_answer = @current_question.correct_answer
  
    # 回答の正誤を判定して結果を保存
    test_result = TestResult.new(user_id: current_user.id, question_id: @current_question.id, user_answer: user_answer, is_correct: (user_answer == correct_answer))

    if test_result.valid?
      test_result.save
    else
    # バリデーションエラーがある場合はエラーメッセージを取得し、適切な処理を行う
      @error_message = test_result.errors.full_messages.first
    # エラーメッセージを適切な場所に表示するなどの処理を行う

    # renderなどを用いて回答画面を再表示する場合
    render 'show'
    return
  end
  
    # 次の問題に遷移
    next_question_index = @question_number + 1
    if next_question_index < @questions.size
      @current_question = @questions[next_question_index]
      @question_number = next_question_index # 問題番号を更新
      session[:question_number] = @question_number # セッションに問題番号を保存
      render 'show' # 同じテスト画面を表示して次の問題に進む
    else
      # テストが終了した場合、合計取得点数と正解を表示
      correct_question_ids = TestResult.where(user: current_user, is_correct: true).pluck(:question_id)
      correct_answers = @questions.select { |question| correct_question_ids.include?(question.id) }

      total_score = TestResult.where(user: current_user, is_correct: true).count

      @result = { total_score: total_score, correct_answers: correct_answers }
      current_user.increment!(:test_attempts)
      @question_number = nil
      session[:question_number] = nil # セッションの問題番号をクリア
      redirect_to  test_results_result_path
    end
  end
end
