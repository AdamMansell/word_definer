class Definition
  attr_reader :id, :name, :word_id

  @@definitions = {}
  @@total_number_of_definitions = 0

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id] || @@total_number_of_definitions += 1
    @word_id = attributes[:word_id]
  end

  def ==(other_definition)
    name == other_definition.name &&
      id == other_definition.id &&
      word_id == other_definition.word_id
  end

  def save
    @@definitions[id] = Definition.new(name: name, id: id, word_id: word_id)
  end

  def update(name)
    @name = name
  end

  def delete
    @@definitions.delete(id)
  end

  def word
    Word.find(word_id)
  end

  class << self
    def all
      @@definitions.values
    end

    def find(id)
      @@definitions[id]
    end

    def find_by_word_id(word_id)
      @@definitions.values.select { |definition| definition.word_id == word_id }
    end

    def reset
      @@definitions = {}
      @@total_number_of_definitions = 0
    end
  end
end
