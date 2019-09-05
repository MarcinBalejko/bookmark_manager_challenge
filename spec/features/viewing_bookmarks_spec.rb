require 'pg'

feature 'Viewing bookmarks' do
  scenario 'Visiting /bookmarks shows me all the bookmarks' do

    connection = PG.connect(dbname: 'bookmark_manager_test')

    # Add the test data

    connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.destroyallsoftware.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")
    Bookmark.create(url: "http://www.makersacademy.com")
    Bookmark.create(url: "http://www.destroyallsoftware.com")
    Bookmark.create(url: "http://www.google.com")
      
    visit('/bookmarks')
  end

end