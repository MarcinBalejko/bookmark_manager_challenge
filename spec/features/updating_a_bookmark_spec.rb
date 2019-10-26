feature 'Updating a bookmark' do
  scenario 'A user can update a bookmark' do
    sign_up
    add_one_bookmark
    # editing bookmark stage
    click_button 'Edit'
    fill_in('url', with: "http://www.snakersacademy.com")
    fill_in('title', with: "Snakers Academy")
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Test Bookmark', href: 'http://www.testbookmark.com')
    expect(page).to have_link('Snakers Academy', href: 'http://www.snakersacademy.com')
  end
end