class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @teams = @user.team_member_teams
    @tasks = Task.all
  end

  def index
    @users = User.all
  end
  
end
