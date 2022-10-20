class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :set_q, only: [:index, :search]

  # GET /tasks or /tasks.json
  def index
    @tasks = @q.result.order(:completion_flag).order(:time_limit).page(params[:page]).per(10)
    @time = Time.now()
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    @requests = @task.requests.page(params[:page]).per(5)
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
    @task.requests.last.user_id = current_user.id if @task.requests.present?
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
        if @task.requests.length > 0
          RequestMailer.request_mail(@task).deliver
        end
        format.html { redirect_to task_url(@task), notice: "タスクを登録しました。" }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    @teams = Team.all
    @users = User.all
    # @task.requests.last.user_id = current_user.id if @task.requests.present? これがあると既存のリクエストの依頼者が書き変わってしまう
    @before_requests = @task.requests.length

      respond_to do |format|
      if @task.update(task_params)
        @after_requests = @task.requests.length
        if @after_requests > @before_requests
          RequestMailer.request_mail(@task).deliver
        end
        format.html { redirect_to task_url(@task), notice: "タスクを編集しました。" }
        format.json { render :show, status: :ok, location: @task }
      else
        @task.requests.build
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "タスクを削除しました。" }
      format.json { head :no_content }
    end
  end

  def search
    @results = @q.result.order(:completion_flag).order(:time_limit).page(params[:page]).per(10)
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
