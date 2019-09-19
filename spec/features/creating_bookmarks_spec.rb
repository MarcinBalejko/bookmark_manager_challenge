feature 'Adding a new bookmark' do
  scenario 'A user can add a bookmark to Bookmark Manager' do
    visit('/')
    click_button('Sign up')
    fill_in('email', with: 'user@gmail.com')
    fill_in('password', with: 'testpassword')
    click_button('Submit')
    #adding a bookmark stage
    click_button('Add Bookmark')
    fill_in('url', with: 'http://www.testbookmark.com')
    fill_in('title', with: 'Test Bookmark')
    click_button('Submit')

    expect(page).to have_link('Test Bookmark', href: 'http://www.testbookmark.com')
  end
  scenario 'The bookmark must be a valid URL' do
    visit('/')
    click_button('Sign up')
    fill_in('email', with: 'user@gmail.com')
    fill_in('password', with: 'testpassword')
    click_button('Submit')
    #adding an incorrect bookmark stage
    click_button('Add Bookmark')
    fill_in('title', with: 'not a real bookmark')
    fill_in('url', with: 'not a real bookmark')
    click_button('Submit')
    
    expect(page).not_to have_content "not a real bookmark"  
    expect(page).to have_content "Please submit a valid URL"
  end
end