class Feed < NanoStore::Model
  attribute :title
  attribute :author
  attribute :link
  attribute :pubDate
  attribute :description
  attribute :text
  attribute :type
  attribute :guid
  attribute :enclosure
  attribute :created_at

  class << self
    def create_new title, author, link, pubDate, description, text, type
      obj = new(
        title:        title,
        author:       author,
        link:         link,
        pubDate:      pubDate,
        description:  description,
        text:         text, 
        type:         type,
        created_at:   Time.now
      )
      obj.save if Feed.find(title: title).empty?
    end
  end
end
