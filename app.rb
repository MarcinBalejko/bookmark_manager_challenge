require 'sinatra/base'
class BookmarkManager < Sinatra::Base

    get '/' do
        'Bookmark Manager'
    end

    get '/bookmarks' do
        @bookmarks = [
            "https://www.wikipedia.org",
            "https://www.youtube.com",
            "http://www.google.com"
            ]
      
        erb :'bookmarks/index'
    end



    run! if app_file == $0
end