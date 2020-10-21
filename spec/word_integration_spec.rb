require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('#app') do
  before(:each) do
    Word.reset
    Definition.reset
  end

  describe('/ route', { type: :feature }) do
    it('shows the home page') do
      visit('/')
      expect(page).to have_content('Words and Definitons!')
    end
  end

  describe('GET /words route', { type: :feature }) do
    before do
      word1 = Word.new(name: 'Elephant', id: nil).save
      word2 = Word.new(name: 'Lion', id: nil).save
    end

    it('shows the words') do      
      visit('/words')
      expect(page).to have_content('Words and Definitons!')
      expect(page).to have_content('Elephant')
      expect(page).to have_content('Lion')
    end
  end

  describe('POST /words route', { type: :feature }) do
    it('creates word then adds to list') do
      visit('/words')
      click_on('Add a new word!')
      fill_in('new_word', with: 'Book')
      click_on('Submit')
      expect(page).to have_link('Book')
      expect(page).to have_content('Book')
    end
  end

  describe('GET /words/new route', { type: :feature }) do
    it('shows the form to add a word') do
      visit('/words/new')
      expect(page).to have_field('new_word')
    end
  end

  describe('GET /words/:id route', { type: :feature }) do
    context 'No definitions present for the word' do
      before do
        @word = Word.new(name: 'Book', id: 1).save        
      end
  
      it('displays the word but no definition') do
        visit("/words/#{@word.id}")
        expect(page).to have_content("Word: #{@word.name}")
        expect(page).to have_content("No definitions found for the word: #{@word.name}")
      end
    end

    context 'Definitions present for the word' do
      before do
        @word = Word.new(name: 'Book', id: 1).save
        @definition = Definition.new(name: 'blue covers, white pages', id: 1, word_id: @word.id).save      
      end
  
      it('displays the word with definition') do
        visit("/words/#{@word.id}")
        expect(page).to have_content("Word: #{@word.name}")
        expect(page).to have_content('blue covers, white pages')
      end
    end   
  end

  describe('POST /words/:id/definitions route', { type: :feature }) do
    it('creates new definition') do
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

  describe('PATCH /words/:id route', { type: :feature }) do
    it('updates word on word show page') do
      visit('/words')
      click_on('Add a new word!')
      fill_in('new_word', with: 'Book')
      click_on('Submit')
      click_on('Book')
      click_on('Edit the word')
      fill_in('edit_word', with: 'New Book')
      click_on('Update Word')
      expect(page).to have_content('New Book')
    end
  end

  describe('GET /words/:id/definitions/:definition_id route', { type: :feature }) do
    before do
      @word = Word.new(name: 'Book', id: 1).save
      @definition = Definition.new(name: 'blue covers, white pages', id: 1, word_id: @word.id).save      
    end

    it('shows the definitions') do
      visit("/words/#{@word.id}/definitions/#{@definition.id}")
      expect(page).to have_content('blue covers, white pages')
    end
  end

  describe('PATCH /words/:id/definitions/:definition_id route', { type: :feature }) do
    before do
      @word = Word.new(name: 'Book', id: 1).save
      @definition = Definition.new(name: 'blue covers, white pages', id: 1, word_id: @word.id).save      
    end

    it('updates the definition') do
      visit("/words/#{@word.id}/definitions/#{@definition.id}")
      fill_in('new_definition', with: 'has many words')
      click_on('Update Definition')
      expect(page).to have_link('has many words')
    end
  end

  describe('DELETE /words/:id/definitions/:definition_id route', { type: :feature }) do
    before do
      @word = Word.new(name: 'Book', id: 1).save
      @definition = Definition.new(name: 'blue covers, white pages', id: 1, word_id: @word.id).save      
    end

    it('deletes the definition successfully') do
      visit("/words/#{@word.id}/definitions/#{@definition.id}")      
      click_on('Delete Definition')
      expect(page).to have_no_link('blue covers, white pages')
    end
  end

  describe('GET /words/:id/edit route', { type: :feature }) do
    before do
      @word = Word.new(name: 'Book', id: 1).save
    end

    it('displays the word edit form') do
      visit("/words/#{@word.id}/edit")
      expect(page).to have_field('edit_word')
    end
  end

  describe('DELETE /words/:id route', { type: :feature }) do
    before do
      @word = Word.new(name: 'Book', id: 1).save
    end

    it('deletes word successfully') do
      visit("/words/#{@word.id}")
      click_on('Delete Word')
      expect(page).to have_no_content('Book')
    end
  end
end
