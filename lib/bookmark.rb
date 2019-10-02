require_relative 'database_connection'
require 'uri'
require_relative './comment'
require_relative './tag'
require_relative 'user'

class Bookmark
  attr_reader :id, :title, :url, :owner_id
  def initialize(id:, title:, url:, owner_id:)
    @id = id
    @title = title
    @url = url
    @owner_id = owner_id
  end

  def self.all
    bookmarks = DatabaseConnection.query('SELECT * FROM bookmarks;')
    bookmarks.map do |bookmark|
      Bookmark.new(
        url: bookmark['url'],
        title: bookmark['title'],
        id: bookmark['id'],
        owner_id: bookmark['owner_id']
      )
    end
  end

  def self.create(url:, title:, owner_id:)
    return false unless is_url?(url)
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title, owner_id) VALUES('#{url}', '#{title}', '#{owner_id}') RETURNING id, title, url, owner_id;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'], owner_id: result[0]['owner_id'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(id:, title:, url:, owner_id:)
    result = DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}', title = '#{title}', owner_id = '#{owner_id}' WHERE id = #{id} RETURNING id, url, title, owner_id;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'], owner_id: result[0]['owner_id'])
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id}")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'], owner_id: result[0]['owner_id'])
  end

  def self.where(tag_id:)
    result = DatabaseConnection.query("SELECT id, url, title, owner_id FROM bookmarks_tags INNER JOIN bookmarks ON bookmarks.id = bookmarks_tags.bookmark_id WHERE tag_id = #{tag_id};")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'], owner_id: result[0]['owner_id'])
    end
  end

  def comments(comment_class = Comment)
    comment_class.where(bookmark_id: id)
  end

  def tags(tag_class = Tag)
    tag_class.where(bookmark_id: id)
  end

  
  private

  def self.is_url?(url)
    url =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]
  end
  
end