class FindExpertPath
  def initialize(member)
    @member = member
    @visited = []
    @connected = {}

    traverse(member)
  end

  def path_to(expert)
    return unless has_path_to?(expert)
    path = []
    current_user_id = expert

    while(current_user_id != @member) do
      add_user_to_path(path, current_user_id)
      current_user_id = @connected[current_user_id]
    end

    add_user_to_path(path, @member)
  end

  private
  def traverse(expert)
    @visited << expert

    expert_obj = find_user(expert)
    expert_obj.friend_ids.each do |friend_id|
      next if @visited.include?(friend_id)

      traverse(friend_id)
      @connected[friend_id] = expert
    end
  end

  def has_path_to?(expert)
    @visited.include?(expert)
  end

  def add_user_to_path(path, user_id)
    user = find_user(user_id).name
    path.unshift(user)
  end

  def find_user(user_id)
    User.find_by(id: user_id)
  end
end
