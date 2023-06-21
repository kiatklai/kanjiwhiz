class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :destroy]
  before_action :user_admin, only: [:new, :destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    if Question.create(question_params)
      redirect_to questions_path
    else
      render :new
    end
  end

  def destroy
    question = Question.find(params[:id])
    if question.destroy
      redirect_to questions_path
    end
  end

  private
  def question_params
    params.require(:question).permit(:question_text, :correct_answer)
  end

  def user_admin
    @users = User.all
    if  current_user.admin == false
        redirect_to root_path
    end
  end
end
