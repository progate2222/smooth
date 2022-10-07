class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @teams = @user.team_member_teams
  end
end
