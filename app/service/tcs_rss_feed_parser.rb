class FeedsParser

  # def self.fetch_feeds(type, url)
  #   return false unless internet_connected?
  #   feed_parser = BW::RSSParser.new(url)
  #   feed_parser.parse do |item|
  #     Feed.create(item.to_hash.merge(type: type))
  #   end
  # end


  def self.sync_fetch_feeds(type, url)
    return false unless internet_connected?
    request = NSURLRequest.requestWithURL(NSURL.URLWithString(url))
    response = nil
    error = nil
    # // Synchronous isn't ideal, but simplifies the code for the Demo
    xmlData = NSURLConnection.sendSynchronousRequest(request, returningResponse:response, error:error)
    # // Parse the XML Data into an NSDictionary
    xmlDictionary = XMLReader.dictionaryForXMLData(xmlData, error:error)
    xmlDictionary['rss']['channel']['item'].each do |feed|
      Feed.create_new (feed['title']['text'],feed['author']['text'],feed['link']['text'],feed['pubDate']['text'],feed['description']['text'],feed['text']['text'], type)
    end
  end

  def self.internet_connected?
    Reachability.reachabilityForInternetConnection.isReachable
  end

end
