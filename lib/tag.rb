require_relative './database_connection'

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
end
