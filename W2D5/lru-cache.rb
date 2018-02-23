class LRUCache
  def initialize(size)
    @size = size
    @cache = []
  end

  def count
    @cache.count
  end

  def add(el)
    @cache << el 
  end

  def show
    @cache
  end

end
