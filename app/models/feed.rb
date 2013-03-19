class Feed < NanoStore::Model
  attribute :title
  attribute :author
  attribute :link
  attribute :pubDate
  attribute :description
  attribute :text
  attribute :created_at

  class << self
    def create_new title, author, link, pubDate, description, text
      obj = new(
        title:        title,
        author:       author,
        link:         link,
        pubDate:      pubDate,
        description:  description,
        text:         text, 
        created_at:   Time.now
      )
      obj.save unless Feed.find(title: title)
    end
  end
end
