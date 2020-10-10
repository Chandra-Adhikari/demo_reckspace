class User < ApplicationRecord
	# before_save :short_website_url
	after_save :add_headings

	has_many :headings, dependent: :destroy



	def add_headings
		web_url = self.website_url
		title = Nokogiri::HTML::Document.parse(HTTParty.get("#{web_url}").body).css('h1, h2, h3').children.to_s
		self.headings.find_or_create_by(title: title)
	end

	def friendships
		Friendship.where("user_id = ? OR friend_id = ?", self.id, self.id)
	end

	def friend_ids
		self.friendships.pluck(:user_id, :friend_id).flatten.uniq
	end
end
