require_relative './database_connection'
require_relative './bookmark'

class Tag
  attr_reader :id, :content, :bookmark_id

  def initialize(id:, content:, bookmark_id:)
    @id = id
    @content = content
    @bookmark_id = bookmark_id
  end

  def self.create(bookmark_id:, content:)
    result = DatabaseConnection.query("INSERT INTO tags (bookmark_id, content) VALUES('#{bookmark_id}','#{content}') RETURNING id, content, bookmark_id;")
    Tag.new(id: result[0]['id'], content: result[0]['content'], bookmark_id: result[0]['bookmark_id'])
  end

  def self.where(bookmark_id:)
    result = DatabaseConnection.query("SELECT * FROM tags WHERE bookmark_id = #{bookmark_id};")
    result.map do |tag|
      Tag.new(id: tag['id'], content: tag['content'], bookmark_id: tag['bookmark_id'])
    end
  end

  def self.all
    tags = DatabaseConnection.query('SELECT * FROM tags;')
    tags.map do |tag|
      Tag.new(id: tag['id'], content: tag['content'], bookmark_id: tag['bookmark_id'])
    end
  end

  def self.delete(id:)   
    DatabaseConnection.query("DELETE FROM tags WHERE id = #{id}")
  end

  def self.delete_with_bookmark(id:)  #?
    DatabaseConnection.query("DELETE FROM tags WHERE bookmark_id = #{id}")
  end
  
end