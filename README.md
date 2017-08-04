### Why did I bother to make this?

Have you ever added a YouTube video to a playlist, then it got deleted? Then you try to find the song name but YouTube only displays: [Deleted video]. If you know what I'm talking about then you know my frustration. I lost a playlist with over 85 Nightcore songs after YouTube took down the channel owner due DMCA claims.

### What I discovered?

I realized that there is an easy way to get the video names:

1. Get the video id of the [Deleted Video]
2. Search on Google for the id and some other sites cached the title, description and sometimes even the whole video
3. Use the Google search to easily figure out what the title is

It works almost all the time. Probably if the video is too old then no one has it cached anymore.

### What this actually is?

So, I did this for a few videos, but it became really tedious. Plus, YouTube auto redirects after a few seconds when on a [Deleted video] page.

This script makes it a bit easier:

Here's what it does:
1. It uses the YouTube api to retrieve video ids for all the videos in the playlist
2. Searches Google for each video id
3. Uses Nokogiri to parse the page and retrieve all the search result titles
4. Writes it all to a file titled "youtube-playlist-<your playlist id>.rb"

It's brute force, not smart, and very slow (think a minute for 80 videos), but it got the job done.

### How can we make it better?
    
If one day the Nightcore channel I follow gets taken down again, I may come back to make this better - or if I need to work on something

1. Develop an algorithm to figure out which substrings of the search results are likely to be the title
	- I was thinking something along the lines of finding the largest common substring between all the results
    - And output 3 potential candidate titles per video id
2. Write test cases (Yes, we need tests for any robust system, but it's ok for just a hack)
3. Improve performance (It's really slow probably due to so many requests to Google search)
