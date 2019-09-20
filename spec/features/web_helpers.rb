def sign_up
    visit('/')
      click_button 'Sign up'
      fill_in('email', with: 'user@gmail.com')
      fill_in('password', with: 'testpassword')
      click_button 'Submit'
end

def add_one_bookmark
    click_button 'Add Bookmark'
    fill_in('url', with: 'http://www.testbookmark.com')
    fill_in('title', with: 'Test Bookmark')
    click_button('Submit')
end

def add_three_bookmarks
     #adding the first bookmark 
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
end