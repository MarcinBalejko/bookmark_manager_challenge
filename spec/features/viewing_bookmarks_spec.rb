require 'pg'

feature 'Viewing bookmarks' do
  feature 'visiting the homepage' do
    scenario 'the page title is visible' do
      visit '/'
      expect(page).to have_content 'Bookmark Manager'
    end
  end
  feature 'viewing bookmarks' do
    let(:user) { User.create(email: 'user@gmail.com', password: 'testpassword') }
    scenario 'bookmarks are visible' do
      sign_up
      add_three_bookmarks
  
      expect(page).to have_link('Test Bookmark', href: 'http://www.testbookmark.com')
      expect(page).to have_link('Destroy All Software',  href: 'http://www.destroyallsoftware.com')
      expect(page).to have_link('Google', href: 'http://www.google.com')
    end
  end
end