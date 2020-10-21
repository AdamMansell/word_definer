describe('Definition') do
  before(:each) do
    Definition.reset
    Word.reset    
  end

  context 'instance methods' do
    describe('#initialize') do
      it("returns initialized definition object's attributes") do
        word = Word.new(name: 'Book', id: 2)
        definition = Definition.new(name: 'blue covers, white pages', id: nil, word_id: 2)
        expect(definition.name).to eq('blue covers, white pages')
        expect(definition.id).to eq(1)
        expect(definition.word_id).to eq(2)
      end
    end

    describe('#save') do
      it('saves definitions') do
        definition1 = Definition.new(name: 'blue covers, white pages', id: nil, word_id: 1)
        definition1.save
        definition2 = Definition.new(name: 'blue covers, white pages', id: nil, word_id: 1)
        definition2.save
        expect(Definition.all).to eq([definition1, definition2])
      end
    end

    describe('#update') do
      it('updates defintion') do
        definition = Definition.new(name: 'blue covers, white pages', id: nil, word_id: 1).save
        definition.update('something you read alone or with family')
        expect(definition.name).to eq('something you read alone or with family')
      end
    end

    describe('#delete') do
      it('deletes defintion') do
        definition1 = Definition.new(name: 'blue covers, white pages', id: nil, word_id: 1).save
        definition2 = Definition.new(name: 'something you read alone or with family', id: nil, word_id: 1).save
        definition1.delete
        expect(Definition.all).to eq([definition2])
      end
    end

    describe('#word') do
      before do
        @word = Word.new(name: 'Book', id: nil).save
      end

      it("finds certain defintion's word") do
        definition1 = Definition.new(name: 'blue covers, white pages', id: nil, word_id: @word.id).save
        definition2 = Definition.new(name: 'something you read alone or with family', id: nil, word_id: @word.id).save
        expect(definition1.word).to eq(@word)
        expect(definition2.word).to eq(@word)
      end
    end
  end

  context 'class methods' do
    describe('.all') do
      it('returns a list of all definitions') do
        expect(Definition.all).to eq([])
        definition1 = Definition.new(name: 'blue covers, white pages', id: nil, word_id: 1).save
        definition2 = Definition.new(name: 'something you read alone or with family', id: nil, word_id: 1).save
        expect(Definition.all).to eq([definition1, definition2])
      end
    end

    describe('.reset') do
      it('resets the @@definitions hash') do
        definition1 = Definition.new(name: 'blue covers, white pages', id: nil, word_id: 1).save
        definition2 = Definition.new(name: 'blue covers, white pages', id: nil, word_id: 1).save
        Definition.reset
        expect(Definition.all).to eq([])
      end
    end

    describe('.find') do
      it('finds the right definition') do
        definition = Definition.new(name: 'blue covers, white pages', id: 100, word_id: 1).save
        expect(Definition.find(100)).to eq(definition)
      end

      it('finds the right definition') do
        definition = Definition.new(name: 'blue covers, white pages', id: 200, word_id: 1).save
        expect(Definition.find(200)).to eq(definition)
      end      
    end

    describe('.find_by_word_id') do
      before do
        @word = Word.new(name: 'Book', id: nil).save
      end

      it("finds certain word's definitions") do
        definition1 = Definition.new(name: 'blue covers, white pages', id: nil, word_id: @word.id).save
        definition2 = Definition.new(name: 'something you read alone or with family', id: nil, word_id: @word.id).save
        expect(Definition.find_by_word_id(@word.id)).to eq([definition1, definition2])
      end
    end
  end
end
