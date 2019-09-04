feature 'Viewing bookmarks' do
    scenario 'User can see the bookmarks' do
        visit('/bookmarks')
        expect(page).to have_content "http://www.makersacademy.com"
        expect(page).to have_content "http://www.destroyallsoftware.com"
        expect(page).to have_content "http://www.google.com"
    end
end