require 'rest-client'
class User < ApplicationRecord
	before_save :short_website_url
	after_save :add_headings

	has_many :headings, dependent: :destroy

	def add_headings
		web_url = self.website_url
		title = Nokogiri::HTML::Document.parse(HTTParty.get("#{web_url}").body).css('h1, h2, h3').children.to_s
		self.headings.find_or_create_by(title: title)
	end

	def short_website_url
		payload = { long_url: self.website_url, domain: "bit.ly", group_guid: "BkaabQd2paX" }
		response = RestClient.post('https://api-ssl.bitly.com/v4/shorten', 
			payload.to_json, Authorization: 'Bearer f821e1e45563efa875493770868fd13edcb52573', 
			:content_type => 'application/json')
		self.shortened_url = JSON.parse(response)['link']
	end

	def friendships
		Friendship.where("user_id = ? OR friend_id = ?", self.id, self.id)
	end

	def friend_ids
		self.friendships.pluck(:user_id, :friend_id).flatten.uniq - [self.id]
	end
end
