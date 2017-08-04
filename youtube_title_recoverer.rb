require 'yt'
require 'nokogiri'
require 'open-uri'

class YouTubeTitleRecoverer

	#Return video ids for a playlist
	def self.return_titles_playlist(playlist_id)
		Yt.configure do |config|
  			#config.api_key = #Your YouTube api key
		end

		playlist = Yt::Playlist.new id: playlist_id
		playlist_items = playlist.playlist_items

		video_ids = Array.new

		playlist_items.each do |playlist_item|
			video_id = get_video_id(playlist_item)
			video_ids.push(video_id)
		end

		video_titles = Hash.new
		video_ids.each do |video_id|
			video_title_candidates = get_title_candidates(video_id)
			video_titles[video_id] = video_title_candidates
		end

		output_file = File.new("youtube-playlist-#{playlist_id}.txt", "w")

		video_titles.each do |key, value|
			output_file.puts(key)
			value.each do |title|
				output_file.puts(title)
			end
		end

		output_file.close
	end

	#Return title candidates for single video
	def self.return_titles_video(video_id)
		candidates = get_title_candidates(video_id)
		return candidates
	end

	def self.get_video_id(playlist_item)
		return playlist_item.video_id
	end

	#Return link text for first page of Google search results for video id
	def self.get_title_candidates(video_id)
		candidates = Array.new
		url = "https://www.google.com/search?q=#{video_id}"
		doc = Nokogiri::HTML(open(url))
		doc.css('h3').each do |result|
			candidates.push(result.text)
		end

		#Rate substrings in the results
		#best_candidates = evaluate_title_candidates(candidates)
		#return best_candidates
		return best_candidates
	end

	#def self.evaluate_title_candidates(candidates)
	#	#Hash for substrings and how many times it appears
	#	substrings = Hash.new
	#	
	#	return best_candidates
	#end

end