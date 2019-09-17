require 'pg'

task :setup_test_database do
  p "Cleaning database..."

  connection = PG.connect(dbname: 'bookmark_manager_test')

  # Clear the database
  connection.exec("TRUNCATE bookmarks, comments, tags, bookmarks_tags, users;")

  # Add the test data
  #connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://www.makersacademy.com', 'Makers Academy');")
  #connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://www.google.com', 'Google');")
  #connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://www.facebook.com', 'Facebook');")

end

task :setup do
  p "Creating databases..."

  ['bookmark_manager', 'bookmark_manager_test'].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{ database };")
    connection = PG.connect(dbname: database)
    connection.exec("CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60));")
  end
end 