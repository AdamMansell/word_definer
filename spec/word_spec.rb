describe('Word') do
  # reset the state before each test example
  before(:each) do
    Word.reset
    Definition.reset
  end

  context 'instance methods' do
    describe('#id') do
      it('returns id of word') do
        word = Word.new(name: 'Adam', id: 1)
        expect(word.id).to eq(1)
      end
    end

    describe('#save') do
      it('adds word to words hash') do
        word1 = Word.new(name: 'Elephant', id: nil).save
        word2 = Word.new(name: 'Lion', id: nil).save
        expect(Word.all).to eq([word1, word2])        
      end
    end

    describe('#update') do
      it('updates a word successfully') do
        word = Word.new(name: 'Elephant', id: nil).save
        word.update('Tiger')
        expect(word.name).to eq('Tiger')
      end
    end

    describe('#delete') do
      it('deletes a word successfully') do
        word1 = Word.new(name: 'Elephant', id: nil).save
        word2 = Word.new(name: 'Lion', id: nil).save
        word1.delete
        expect(Word.all).to eq([word2])
      end
    end

    describe('#definitions') do
      it('finds definitions for a given word') do
        word = Word.new(name: 'Book', id: nil)
        definition1 = Definition.new(name: 'blue cover, white pages', id: nil, word_id: word.id).save
        definition2 = Definition.new(name: 'you read with alone or with family', id: nil, word_id: word.id).save
        expect(word.definitions).to eq([definition1, definition2])
      end
    end
  end

  context 'class methods' do
    describe('.find') do
      it('finds word by id') do
        word = Word.new(name: 'Elephant', id: 100).save
        expect(Word.find(100)).to eq(word)
      end
    end

    describe('.reset') do
      it('resets words') do
        word1 = Word.new(name: 'Elephant', id: nil).save
        word2 = Word.new(name: 'Lion', id: nil).save
        Word.reset
        expect(Word.all).to eq([])
      end
    end

    describe('.all') do
      it('returns created words') do
        expect(Word.all).to eq([])
        word1 = Word.new(name: 'Elephant', id: nil).save
        word2 = Word.new(name: 'Lion', id: nil).save
        expect(Word.all).to eq([word1, word2])
      end
    end
  end
end
