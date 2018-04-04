class HomeController < ApplicationController
	require 'messagebird'
	before_action :authenticate_user!, except: [:index,:test]

	def index
		if cookies[:user].nil? || cookies[:channel].nil?
			time = Time.now.to_i
			cookies[:user] = "user-#{time}"
			cookies[:channel] = "channel-#{time}"
		
			# send sms
			client = MessageBird::Client.new( Rails.application.secrets.messagebird)
			chat_url = "localhost:3000/chat/#{time}"
			client.message_create('FromMe', '+201099181825', "Hello, You have got a new conversation to respond to #{chat_url}")
		end
	end

	def test
	end

	def chat
		cookies[:channel] = "channel-#{params[:id]}"
	end
end
