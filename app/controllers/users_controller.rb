class UsersController < ApplicationController
  before_action :find_member, only: [:member_list, :add_friend, :show]

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
    if params["search"].present?
      @heading = Heading.where("title ILIKE ?", "%#{params["search"]}%").first
      return if @member.id.eql?(@heading.user_id)
      
      @expert =  @heading.user
      @linked_friend_ids = FindExpertPath.new(@member.id).path_to(@expert.id)
      @linked_friend = User.where(id: @linked_friend_ids).pluck(:name)
    end
  end

  def member_list
    @members = User.where.not(id: (@member.friend_ids.push(@member.id)))
  end

  def add_friend
    Friendship.create(user_id: params["id"], friend_id: params["friend_id"])
    redirect_to member_list_user_path(params["id"])
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
