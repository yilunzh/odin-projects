require 'flickraw'

module FlickrHelper

	def cat_search(tag)
		return flickr.photos.search(tags: tag)
	end

	def cat_photo(photo_id)
		info = flickr.photos.getInfo(photo_id: photo_id)
		return FlickRaw.url_b(info)
	end
end