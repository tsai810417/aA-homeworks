require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :title, :year, :playwright_id

  def self.find_by_title(title)

  end

  def self.find_by_playwright(name)

  end

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end

class Playwright
  attr_accessor :title, :year, :playwright_id

  def self.find_by_name(name)

  end

  def self.all
    data = PlaywrightDBConnection.instance.execute("SELECT * FROM playwright")
    data.map { |datum| Playwright.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create
    raise "#{self} already in database" if @id
    PlaywrightDBConnection.instance.execute(<<-SQL, @name, @birth_year)
      INSERT INTO
        plays (name, birth_year)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlaywrightDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlaywrightDBConnection.instance.execute(<<-SQL, @name, @birth_year, @id)
      UPDATE
        plays
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end
end
