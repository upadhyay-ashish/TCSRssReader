class FeedsParser

  def self.fetch_feeds(type, url)
    return false unless internet_connected?
    feed_parser = BW::RSSParser.new(url)
    feed_parser.parse do |item|
      Feed.create(item.to_hash.merge(type: type))
    end
  end

  def self.internet_connected?
    Reachability.reachabilityForInternetConnection.isReachable
  end

end
