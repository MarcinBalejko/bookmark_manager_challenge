feature 'Adding and viewing tags' do
    feature 'a user can add and then view a tag' do
      scenario 'a tag is added to a bookmark' do
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
        # adding a tag stage
        first('.bookmark').click_button 'Add Tag'
        fill_in 'tag', with: 'test tag'
        click_button 'Submit'
        expect(current_path).to eq '/bookmarks'
        expect(first('.bookmark')).to have_content 'test tag'
      end
    end
  end