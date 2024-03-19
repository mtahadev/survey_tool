class SurveysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_survey, only: [:show, :edit, :update]

  def index
    @surveys = Survey.all
  end

  def show
    @responses = @survey.responses
  end

  def new
    @survey = current_user.surveys.new
  end

  def create
    @survey = current_user.surveys.new(survey_params)
    if @survey.save
      redirect_to surveys_path, notice: 'Survey was successfully created.'
    else
      render :new
    end
  end

  def responses
    @survey = current_user.surveys.find(params[:id])
    @responses = @survey.responses.includes(:user)
  end

  private

  def set_survey
    @survey = current_user.surveys.find(params[:id])
  end

  def survey_params
    params.require(:survey).permit(:question)
  end
end
