# Базовый класс для словарей из Dicts.
#
class Dict
  attr_reader :id, :index

  def initialize(id, index)
    @id    = id
    @index = index
  end

  def self.all
    constants.select { |const| (const_get const).class != Array }.map { |const| const_get const }                       # пока я не добавил константы типа ALL, работала эта строка: constants.map { |const| const_get const }
  end

  def self.find(id)
    all.select { |const| const.id == id.to_i }.first
  end

  def self.find_by_index(index)
    all.select { |const| const.index == index }.first
  end

  def self.where(ids)
    all.select { |const| ids.include?(const.id) }
  end
end
