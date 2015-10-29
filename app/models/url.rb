require_relative '../../config/environments/init'  # model has to require from the configuration folder 
require 'securerandom'
require 'byebug'

class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	before_create :shorten

	validates :long_url, presence: true, :format =>{:with => URI.regexp}
	validates :short_url, uniqueness: true

	def shorten #using before_create callback to call out to the shorten method 
		self.short_url = SecureRandom.urlsafe_base64(7)
	end

	def counter
		self.click_count += 1
		self.save 
	end
end
