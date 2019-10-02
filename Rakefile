require 'pg'

task :setup_test_database do
  #p "Cleaning database..."
  connection = PG.connect(dbname: 'bookmark_manager_test')

  connection.exec("TRUNCATE bookmarks, comments, tags, bookmarks_tags, users;")
  
end

task :setup do
  p "Creating databases..."

  ['bookmark_manager', 'bookmark_manager_test'].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{ database };")

    connection = PG.connect(dbname: database)
    connection.exec("CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60), title VARCHAR(60));")  #dodac tags reference number?
    connection.exec("CREATE TABLE tags(id SERIAL PRIMARY KEY, content VARCHAR(60), bookmark_id INTEGER REFERENCES bookmarks (id));")
    connection.exec("CREATE TABLE comments(id SERIAL PRIMARY KEY, text VARCHAR(240), bookmark_id INTEGER REFERENCES bookmarks (id));")
    connection.exec("CREATE TABLE users (id SERIAL PRIMARY KEY, email VARCHAR(60), password VARCHAR(140));")
    connection.exec("ALTER TABLE bookmarks ADD COLUMN owner_id INTEGER REFERENCES users (id);")
  end
end

task :teardown do
  p "Destroying databases...type 'y' to confirm that you want to destroy the Bookmark Manager databases. This will remove all data in those databases!"

  confirm = STDIN.gets.chomp

  return unless confirm == 'y'

  ['bookmark_manager', 'bookmark_manager_test'].each do |database|
    connection = PG.connect
    connection.exec("DROP DATABASE #{ database }")
  end
end