#scraping most voted hackernews
require 'nokogiri'
require 'open-uri'
require 'pry'

#get all the posts on hackernews
hacker_news = Nokogiri::HTML(open('https://news.ycombinator.com'))

sources = hacker_news.css("span.comhead")

stories = sources.collect do |source_doc|
  title = source_doc.parent.css("a").text
  href = source_doc.parent.css("a").attr("href").to_s
  {:title => title, :href => href}
end

vote_counts = hacker_news.css("td.subtext span").collect 

vote_counts.each_with_index do |vote, i|
  stories[i][:vote_count] = vote
end


# stories.first.parent.css("a").text
# stories.first.parent.css("a").attr("href")

# stories.first.css('a').to_s
# stories.first.css('a').attr('href').value

binding.pry

#figure out 