feature 'Updating a bookmark' do
  scenario 'A user can update a bookmark' do
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
    # editing bookmark stage
    first('.bookmark').click_button 'Edit'
    fill_in('url', with: "http://www.snakersacademy.com")
    fill_in('title', with: "Snakers Academy")
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Test Bookmark', href: 'http://www.testbookmark.com')
    expect(page).to have_link('Snakers Academy', href: 'http://www.snakersacademy.com')
  end
end