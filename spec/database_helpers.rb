require 'pg'
def persisted_data(id:)
  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.query("SELECT * FROM bookmarks WHERE id = '#{id}';")
end