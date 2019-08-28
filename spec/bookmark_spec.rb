require 'bookmark'
describe Bookmark do
    describe '#all' do
        it 'returns all bookmarks' do
            bookmarks = Bookmark.all
            expect(bookmarks).to include("https://www.wikipedia.org")
            expect(bookmarks).to include("https://www.youtube.com")
            expect(bookmarks).to include("http://www.google.com")
        end
    end



end
  