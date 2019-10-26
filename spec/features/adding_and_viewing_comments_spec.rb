feature 'Adding and viewing comments' do
    feature 'a user can add and then view a comment' do
      scenario 'a comment is added to a bookmark' do
        sign_up
        add_one_bookmark
        #adding a comment stage
        click_button 'Comment'
        fill_in 'comment', with: 'this is a test comment on this bookmark'
        click_button 'Submit'
        
        expect(current_path).to eq '/bookmarks'
        expect(page).to have_content 'this is a test comment on this bookmark'
      end
    end
  end