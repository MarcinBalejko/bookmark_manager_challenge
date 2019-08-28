feature 'Viewing bookmarks' do
    scenario 'User can see the bookmarks' do
        visit('/bookmarks')
        expect(page).to have_content "https://www.wikipedia.org"
        expect(page).to have_content "https://www.youtube.com"
        expect(page).to have_content "http://www.google.com"
    end
end