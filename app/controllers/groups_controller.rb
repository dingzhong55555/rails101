class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy, :join, :quit]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @group.destroy

    redirect_to groups_path
    flash[:warning] = "Delete Success"
  end

  def join
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      flash[:notice] = "你已经加入群组"
    else
    current_user.join!(@group)
    flash[:notice] = "成功加入群组！"
    end

    redirect_to :back
  end



  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
       current_user.quit!(@group)
       flash[:notice] = "成功退出群组！"
    else
       flash[:notice] = "不是群组成员，无法退出！"
    end

    redirect_to :back

  end

  private

  def find_group_and_check_permission
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path
      flash[:notice] = "You have no permission"
    end
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end

end
