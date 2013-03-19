class FeedsParser

  def self.fetch_events_feeds
    request = NSURLRequest.requestWithURL(NSURL.URLWithString("http://www.tcs.com/rss_feeds/Pages/feed.aspx?f=e"))
    response = nil
    error = nil
    # // Synchronous isn't ideal, but simplifies the code for the Demo
    xmlData = NSURLConnection.sendSynchronousRequest(request, returningResponse:response, error:error)
    # // Parse the XML Data into an NSDictionary
    xmlDictionary = XMLReader.dictionaryForXMLData(xmlData, error:error)
    titles = []
    xmlDictionary['rss']['channel']['item'].each do |feed|
      titles << feed['title']['text']
      Feed.create_new (feed['title']['text'],feed['author']['text'],feed['link']['text'],feed['pubDate']['text'],feed['description']['text'],feed['text']['text'])
    end
    titles
  end

end