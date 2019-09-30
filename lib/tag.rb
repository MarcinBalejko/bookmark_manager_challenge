require_relative './database_connection'
require_relative './bookmark'

class Tag
  attr_reader :id, :content

  def initialize(id:, content:)
    @id = id
    @content = content
  end

  def self.create(content:)
    result = DatabaseConnection.query("INSERT INTO tags (content) VALUES('#{content}') RETURNING id, content;")
    Tag.new(id: result[0]['id'], content: result[0]['content'])
  end

  def self.where(bookmark_id:)
    result = DatabaseConnection.query("SELECT id, content FROM bookmarks_tags INNER JOIN tags ON tags.id = bookmarks_tags.tag_id WHERE bookmarks_tags.bookmark_id = '#{bookmark_id}';")
    result.map do |tag|
      Tag.new(id: tag['id'], content: tag['content'])
    end
  end

  def self.all
    tags = DatabaseConnection.query('SELECT * FROM tags;')
    tags.map do |tag|
      Tag.new(id: tag['id'], content: tag['content'])
    end
  end

  def self.delete(id:)  
    DatabaseConnection.query("DELETE FROM bookmarks_tags WHERE tag_id = #{id}")
    DatabaseConnection.query("DELETE FROM tags WHERE id = #{id}")
  end
  
end