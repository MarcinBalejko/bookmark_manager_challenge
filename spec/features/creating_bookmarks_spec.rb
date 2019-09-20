feature 'Adding a new bookmark' do
  scenario 'A user can add a bookmark to Bookmark Manager' do
    sign_up
    add_one_bookmark

    expect(page).to have_link('Test Bookmark', href: 'http://www.testbookmark.com')
  end
  scenario 'The bookmark must be a valid URL' do
    sign_up
    #adding an incorrect bookmark stage
    click_button('Add Bookmark')
    fill_in('title', with: 'not a real bookmark')
    fill_in('url', with: 'not a real bookmark')
    click_button('Submit')
    
    expect(page).not_to have_content "not a real bookmark"  
    expect(page).to have_content "Please submit a valid URL"
  end
end