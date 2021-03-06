require 'tag'
require 'bookmark'
require 'database_helpers'

describe Tag do
  let(:user) { User.create(email: 'user@gmail.com', password: 'testpassword') }
  describe '.create' do
    it 'creates a new Tag object' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy", owner_id: user.id)
      tag = Tag.create(bookmark_id: bookmark.id, content: 'test tag')

      persisted_data = persisted_data(id: tag.id, table: 'tags')

      expect(tag).to be_a Tag
      expect(tag.id).to eq persisted_data.first['id']
      expect(tag.content).to eq 'test tag'
    end
  end

  describe '.where' do
    it 'returns tags linked to the given bookmark id' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy", owner_id: user.id)
      tag1 = Tag.create(bookmark_id: bookmark.id, content: 'test tag 1')
      tag2 = Tag.create(bookmark_id: bookmark.id, content: 'test tag 2')

      tags = Tag.where(bookmark_id: bookmark.id)
      tag = tags.first

      expect(tags.length).to eq 2
      expect(tag).to be_a Tag
      expect(tag.id).to eq tag1.id
      expect(tag.content).to eq tag1.content
    end
  end

  describe '.all' do
    it 'returns a list of tags' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy", owner_id: user.id)
      tag1 = Tag.create(bookmark_id: bookmark.id, content: 'test tag 1')
      tag2 = Tag.create(bookmark_id: bookmark.id, content: 'test tag 2')

      tags = Tag.all
      
      expect(tags.length).to eq 2
      expect(tags.first).to be_a Tag
      expect(tags.first.content).to eq 'test tag 1'   
    end
  end

  describe '.delete' do
    it 'deletes the given tag' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy", owner_id: user.id)
      tag1 = Tag.create(bookmark_id: bookmark.id, content: 'test tag_1')
      tag2 = Tag.create(bookmark_id: bookmark.id, content: 'test tag_2')

      Tag.delete(id: tag1.id)
      expect(Tag.all.length).to eq(1)
    end
  end
  
end