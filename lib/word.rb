class Word
  attr_reader :id, :name

  @@words = {}
  @@total_number_of_words = 0

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id] || @@total_number_of_words += 1
  end

  # word1 = Word.new(name; 'Book', id: 1)
  # word2 = Word.new(name; 'Book 2', id: 2)
  # word1 == word2
  # word1.==(word2)
  def ==(other_word)
    name == other_word.name && id == other_word.id
  end

  def save
    @@words[id] = Word.new(name: name, id: id)
  end

  def update(name)
    @name = name
  end

  # @word = Word.find(1)
  # @word.delete

  def delete
    @@words.delete(id)
  end

  def definitions
    Definition.find_by_word_id(id)
  end

  class << self
    def all
      @@words.values
    end

    def find(id)
      @@words[id]
    end

    def clear
      @@words = {}
      @@total_number_of_words = 0
    end
  end
end
