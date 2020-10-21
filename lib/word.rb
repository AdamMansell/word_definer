class Word
  attr_reader :id, :name

  @@words = {}
  @@total_number_of_words = 0

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id] || @@total_number_of_words += 1
  end

  def ==(other_word)
    name == other_word.name && id == other_word.id
  end

  def save
    @@words[id] = Word.new(name: name, id: id)
  end

  def update(name)
    @name = name
  end

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

    def reset
      @@words = {}
      @@total_number_of_words = 0
    end
  end
end
