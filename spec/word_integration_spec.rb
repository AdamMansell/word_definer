require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('#app') do
  before(:each) do
    Word.clear
    Definition.clear
  end

  describe('/ route', { type: :feature }) do
    it('shpws the home page') do
      visit('/')
      expect(page).to have_content('Words and Definitons!')
    end
  end

  describe('/words route', { type: :feature }) do
    it('shows the words') do
      visit('/words')
      expect(page).to have_content('Words and Definitons!')
    end
  end


  describe('/words/ post route', { type: :feature }) do
    it('creates word then adds to list') do
      visit('/words')
      click_on('Add a new word!')
      fill_in('new_word', with: 'Book')
      click_on('Submit')
      expect(page).to have_link('Book')
    end
  end

  describe('/words/new route', { type: :feature }) do
    it('creates page to add word') do
      visit('/words/new')
      expect(page).to have_field('new_word')
    end
  end

  describe('/words/:id get route', { type: :feature }) do
    it('creates path for each word') do
      visit('/words')
      click_on('Add a new word!')
      fill_in('new_word', with: 'Animal')
      click_on('Submit')
      click_on('Animal')
      expect(page).to have_content('No definitions found for the word: Animal')
    end
  end

  describe('/words/:id/definitions post route', { type: :feature }) do
    it('posts new definition') do
      visit('/words')
      click_on('Add a new word!')
      fill_in('new_word', with: 'Book')
      click_on('Submit')
      click_on('Book')
      fill_in('definition_name', with: 'has many pages')
      click_on('Add definition')
      expect(page).to have_link('has many pages')
    end
  end

  describe('/words/:id patch route', { type: :feature }) do
    it('update word on word page') do
      visit('/words')
      click_on('Add a new word!')
      fill_in('new_word', with: 'Book')
      click_on('Submit')
      click_on('Book')
      click_on('Edit the word')
      fill_in('edit_word', with: 'Lindsay')
      click_on('Update Word')
      expect(page).to have_content('Lindsay')
    end
  end

  describe('/words/:id/definitions/:definition_id get route', { type: :feature }) do
    it('creates path to definitions') do
      visit('/words')
      click_on('Add a new word!')
      fill_in('new_word', with: 'Book')
      click_on('Submit')
      click_on('Book')
      fill_in('definition_name', with: 'has many pages')
      click_on('Add definition')
      click_on('has many pages')
      expect(page).to have_field('new_definition')
    end
  end

  describe('/words/:id/definitions/:definition_id patch route', { type: :feature }) do
    it('updates word def') do
      visit('/words')
      click_on('Add a new word!')
      fill_in('new_word', with: 'Book')
      click_on('Submit')
      click_on('Book')
      fill_in('definition_name', with: 'has many pages')
      click_on('Add definition')
      click_on('has many pages')
      fill_in('new_definition', with: 'has many words')
      click_on('Update Definition')
      expect(page).to have_link('has many words')
    end
  end

  describe('/words/:id/definitions/:definition_id delete route', { type: :feature }) do
    it('deletes word def') do
      visit('/words')
      click_on('Add a new word!')
      fill_in('new_word', with: 'Book')
      click_on('Submit')
      click_on('Book')
      fill_in('definition_name', with: 'has many pages')
      click_on('Add definition')
      click_on('has many pages')
      click_on('Delete Definition')
      expect(page).to have_no_link('has many pages')
    end
  end

  describe('/words/:id/edit get route', { type: :feature }) do
    it('creates path for word') do
      visit('/words')
      click_on('Add a new word!')
      fill_in('new_word', with: 'Book')
      click_on('Submit')
      click_on('Book')
      click_on('Edit the word')
      expect(page).to have_field('edit_word')
    end
  end


  describe('/words/:id delete route', { type: :feature }) do
    it('delets word on words page') do
      visit('/words')
      click_on('Add a new word!')
      fill_in('new_word', with: 'Book')
      click_on('Submit')
      click_on('Book')
      click_on('Edit the word')
      expect(page).to have_no_link('Book')
    end
  end
end
