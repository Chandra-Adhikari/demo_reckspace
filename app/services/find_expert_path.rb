class FindExpertPath
  def initialize(member)
    @member = member
    @visited = []
    @connected = {}

    dfs(member)
  end

  # After the depth-first search is done we can find
  # any vertice connected to "node" in constant time [O(1)]
  # and find a path to this node in linear time [O(n)].
  def path_to(expert)
    return unless has_path_to?(expert)
    path = []
    current_user_id = expert

    while(current_user_id != @member) do
      path.unshift(current_user_id)
      current_user_id = @connected[current_user_id]
    end

    path.unshift(@member)
  end

  private
  def dfs(expert)
    @visited << expert

    expert_obj = User.find_by(id: expert)
    expert_obj.friend_ids.each do |friend_id|
      next if @visited.include?(friend_id)

      dfs(friend_id)
      @connected[friend_id] = expert
    end
  end

  def has_path_to?(expert)
    @visited.include?(expert)
  end
end
