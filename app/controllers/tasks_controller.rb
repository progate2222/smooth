class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :set_q, only: [:index, :search]

  # GET /tasks or /tasks.json
  def index
    @tasks = @q.result.order(:completion_flag).order(:time_limit)
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    @requests = @task.requests
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @task.requests.new
    @users = User.all
    @teams = Team.all
  end

  # GET /tasks/1/edit
  def edit
    @users = User.all
    @teams = Team.all
    @task.requests.build
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @teams = Team.all
    @users = User.all
    @task = current_user.tasks.build(task_params)
    @task.requests.last.user_id = current_user.id if @task.requests.present?

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
      respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @results = @q.result
  end

  private

  def set_q
    @q = Task.ransack(params[:q])
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :time_limit, :importance, :completion_flag, :memo, :team_id,
                                                    requests_attributes: [:id, :message, :user_id, :successor_id])
    end
end
