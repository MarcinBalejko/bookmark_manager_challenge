feature 'Adding and viewing comments' do
    feature 'a user can add and then view a comment' do
      scenario 'a comment is added to a bookmark' do
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
        #adding a comment stage
        first('.bookmark').click_button 'Add Comment'
        fill_in 'comment', with: 'this is a test comment on this bookmark'
        click_button 'Submit'
        
        expect(current_path).to eq '/bookmarks'
        expect(first('.bookmark')).to have_content 'this is a test comment on this bookmark'
      end
    end
  end