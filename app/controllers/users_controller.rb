class UsersController < ApplicationController
  before_action :find_member, only: [:member_list, :add_friend]

  def index
  	@users = User.all
  end

  def new
  end

  def create
  	@user = User.create(user_params)
  	if @user
  		redirect_to users_path
  		flash[:notice] = 'Member Added.'
  	else
  		flash[:error] = @user.errors.full_messages
  	end
  end

  def show
  end

  def member_list
    @members = User.where.not(id: (@member.friend_ids.push(@member.id)))
  end

  def add_friend
    binding.pry
  end

  private

  def user_params
  	params.require(:user).permit(:name, :website_url)
  end

  def find_member
    @member = User.find_by(id: params[:id])
    redirect_to users_path unless @member
  end
end
