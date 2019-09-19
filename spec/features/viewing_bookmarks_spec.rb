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
      visit('/')
      click_button 'Sign up'
      fill_in('email', with: 'user@gmail.com')
      fill_in('password', with: 'testpassword')
      click_button 'Submit'
      #adding a bookmark stage
      click_button 'Add Bookmark'
      fill_in('url', with: 'http://www.testbookmark.com')
      fill_in('title', with: 'Test Bookmark')
      click_button('Submit')
      #adding the second bookmark
      click_button 'Add Bookmark'
      fill_in('url', with: 'http://www.destroyallsoftware.com')
      fill_in('title', with: 'Destroy All Software')
      click_button('Submit')
      #adding the third bookmark
      click_button 'Add Bookmark'
      fill_in('url', with: 'http://www.google.com')
      fill_in('title', with: 'Google')
      click_button('Submit')
  
      expect(page).to have_link('Test Bookmark', href: 'http://www.testbookmark.com')
      expect(page).to have_link('Destroy All Software',  href: 'http://www.destroyallsoftware.com')
      expect(page).to have_link('Google', href: 'http://www.google.com')
    end
  end
end