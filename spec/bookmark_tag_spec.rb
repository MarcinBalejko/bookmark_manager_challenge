require 'bookmark_tag'

describe BookmarkTag do
  let(:user) { User.create(email: 'user@gmail.com', password: 'testpassword') }
  describe '.create' do
    it 'creates a link between a bookmark and a tag' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy", owner_id: user.id)
      tag = Tag.create(content: 'test tag')

      bookmark_tag = BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag.id)

      expect(bookmark_tag).to be_a BookmarkTag
      expect(bookmark_tag.tag_id).to eq tag.id
      expect(bookmark_tag.bookmark_id).to eq bookmark.id
    end
  end
end