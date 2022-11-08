class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]

  def show; end

  def create
    @answer = question.answers.new(answer_params)
    @answer.author = current_user

    if @answer.save
      redirect_to question_path(question), notice: 'Answer has been created successfully.'
    else
      redirect_to question_path(question)
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to question_path(question), notice: 'Answer has been removed successfully.'
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  helper_method :question

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : question.answers.new
  end

  helper_method :answer
end
