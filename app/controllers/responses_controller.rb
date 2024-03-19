class ResponsesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_survey, :set_response, only: [:new, :create]

  def new; end

  def create
    @response = @survey.response_for_user(current_user)
    @response ||= @survey.build_response_for_user(current_user)

    if @response.update(response_params)
      redirect_to surveys_path, notice: 'Response was successfully submitted.'
    else
      render :new
    end
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_response
    @response = @survey.response_for_user(current_user)
    @response ||= @survey.build_response_for_user(current_user)
  end

  def response_params
    params.require(:response).permit(:answer)
  end
end
