require 'comment'
require 'bookmark'
require 'database_helpers'

describe Comment do
  let(:user) { User.create(email: 'user@gmail.com', password: 'testpassword') }
  describe '.create' do
    it 'creates a new comment' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy", owner_id: user.id)
      comment = Comment.create(text: 'This is a test comment', bookmark_id: bookmark.id)

      persisted_data = persisted_data(id: comment.id, table: 'comments')

      expect(comment).to be_a Comment
      expect(comment.id).to eq persisted_data.first['id']
      expect(comment.text).to eq 'This is a test comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end
  describe '.where' do
    it 'gets the relevant comments from the databse' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy", owner_id: user.id)
      comment = Comment.create(text: 'This is a test comment', bookmark_id: bookmark.id)
      Comment.create(text: 'This is a second test comment', bookmark_id: bookmark.id)

      comments = Comment.where(bookmark_id: bookmark.id)
      comment = comments.first
      persisted_data = persisted_data(table: 'comments', id: comment.id)

      expect(comments.length).to eq 2
      expect(comment.id).to eq persisted_data.first['id']
      expect(comment.text).to eq 'This is a test comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end

  #describe '.delete' do
    #it 'deletes the given comment' do

     # bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy", owner_id: user.id)
      #comment = Comment.create(text: 'This is a test comment', bookmark_id: bookmark.id)

      #Comment.delete(bookmark_id: bookmark.id)
      #expect(Comment.where(comment.bookmark_id)).not_to eq(bookmark.id)
    #end
  #end

  describe '.all' do
    it 'returns a list of comments' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy", owner_id: user.id)
      comment_1 = Comment.create(text: 'This is a test comment_1', bookmark_id: bookmark.id)
      comment_2 = Comment.create(text: 'This is a test comment_2', bookmark_id: bookmark.id)

      comments = Comment.all
      
      expect(comments.length).to eq 2
      expect(comments.first).to be_a Comment
      expect(comments.first.text).to eq 'This is a test comment_1'
      
    end
  end

  
end