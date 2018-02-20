class Board
  attr_accessor :cups
  attr_reader :player1, :player2

  def initialize(name1, name2)
    @cups = Array.new(14){[:stone,:stone,:stone,:stone]}
    player1, player2 = name1, name2
    cups[6] = []
    cups[13] = []
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each

  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos > 13
    raise "Invalid starting cup" if start_pos <= 0
  end

  def make_move(start_pos, current_player_name)
    stone_count = cups[start_pos].count
    cups[start_pos] = []
    stone_count.times do | time |
      if start_pos + 1 + time == 13
        cups[(start_pos + stone_count + 1) % 13] << :stone
        next
      end
      cups[(start_pos + 1 + time) % 13] << :stone
    end
    render
    # next_turn(start_pos + stone_count + 1)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
    make_move(ending_cup_idx) if cups[ending_cup_idx].length > 0
    return :switch if cups[ending_cup_idx].length == 0
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    return true if cups[1..5].any?{ | cup | cup.empty?}
    return true if cups[7..12].any?{ | cup | cup.empty?}

    false
  end

  def winner
    return player1 if cups[6].count > cups[13].count
    return player2 if cups[13].count > cups[6].count
    return :draw if cups[6].count == cups[13].count
  end
end
