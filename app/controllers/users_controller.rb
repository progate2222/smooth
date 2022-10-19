class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if (current_user.admin == true) || (current_user.id == @user.id)
      @teams = @user.team_member_teams.page(params[:page]).per(6)
      tasks = Task.all.order(:completion_flag).order(:time_limit)
      user_tasks = []
      tasks.each do |task|
        if ((task.user.id == @user.id) && (task.requests.length == 0 ))  || (task.requests.last&.successor_id == @user.id)
          user_tasks.push(task)
        end
      end
      @user_tasks = Kaminari.paginate_array(user_tasks).page(params[:page]).per(5)
    else
      redirect_to tasks_path
    end
  end

end
