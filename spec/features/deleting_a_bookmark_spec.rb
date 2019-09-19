feature 'Deleting a bookmark' do
  scenario 'A user can delete a bookmark' do
    visit('/')
    click_button 'Sign up'
    fill_in('email', with: 'user@gmail.com')
    fill_in('password', with: 'testpassword')
    click_button 'Submit'
    #adding a bookmark stage
    click_button 'Add Bookmark'
    fill_in('url', with: 'http://www.testbookmark.com')
    fill_in('title', with: 'Test Bookmark')
    click_button 'Submit'

    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
  end
end