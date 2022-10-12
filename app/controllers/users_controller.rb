class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @teams = @user.team_member_teams
    @tasks = Task.all.order(:completion_flag).order(:time_limit)
  end

  def index
    @users = User.all
  end
  
end
