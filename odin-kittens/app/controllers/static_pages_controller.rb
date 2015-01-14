require 'pry'

class StaticPagesController < ApplicationController

include FlickrHelper
	
	def search
		@tag = params[:keyword]
		if @tag
			FlickRaw.api_key = "130febb7f18e782fd3b1461448969d0d"
			FlickRaw.shared_secret = "d04802d8e91b6d35"
			results = cat_search(@tag)
			index = Random.rand(0...100)
			@url = cat_photo(results[index]["id"])
		end
	end
end
