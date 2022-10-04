class TeamMembersController < ApplicationController


    def create
        team_member = current_user.team_members.create(team_id: params[:team_id])
        redirect_to teams_path, notice: "#{team_member.team.name}に加わりました"
    end

    def destroy
        team_member = current_user.team_members.find_by(id: params[:id]).destroy
        redirect_to teams_path, notice: "#{team_member.team.name}から外れました"
    end

    def index
        @team_members = current_user.team_member_teams.all
    end

end
