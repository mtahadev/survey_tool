class Response < ApplicationRecord
  belongs_to :user
  belongs_to :survey

  # Validate that each user can respond only once to a survey
  validates :user_id, uniqueness: { scope: :survey_id, message: "has already responded to this survey" }

  # Method to update existing response or create a new one
  def self.create_or_update_response(user, survey, answer)
    response = user.responses.find_by(survey: survey)
    if response
      response.update(answer: answer)
    else
      user.responses.create(survey: survey, answer: answer)
    end
  end
end
