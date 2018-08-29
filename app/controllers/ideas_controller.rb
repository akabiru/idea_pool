class IdeasController < ApplicationController
  before_action :set_idea, only: %i[show update destroy]

  def index
    ideas = current_user.ideas.paginate(page: params[:page], per_page: 10)
    json_response(ideas)
  end

  def create
    idea = current_user.ideas.create!(idea_params)
    idea_avg = ScoreCalc.avg(idea)
    idea.update(average_score: idea_avg)
    json_response(idea, :created)
  end

  def show
    json_response(@idea)
  end

  def update
    @idea.update(idea_params)
    head :no_content
  end

  def destroy
    @idea.destroy
    head :no_content
  end

  private

  def idea_params
    params.permit(:content, :impact, :ease, :confidence)
  end

  def set_idea
    @idea = Idea.find(params[:id])
  end
end
