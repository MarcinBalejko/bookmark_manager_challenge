feature 'Adding and viewing tags' do
    feature 'a user can add and then view a tag' do
      scenario 'a tag is added to a bookmark' do
        sign_up
        add_one_bookmark
        # adding a tag stage
        first('.bookmark').click_button 'Add Tag'
        fill_in 'tag', with: 'test tag'
        click_button 'Submit'
        
        expect(current_path).to eq '/bookmarks'
        expect(first('.bookmark')).to have_content 'test tag'
      end
    end
  end