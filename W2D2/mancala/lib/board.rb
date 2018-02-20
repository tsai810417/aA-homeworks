require "byebug"
class Board
  attr_accessor :cups
  attr_reader :player1, :player2, :current_player

  def initialize(name1, name2)
    @cups = Array.new(14){[:stone,:stone,:stone,:stone]}
    @player1, @player2 = name1, name2
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
    current_player = current_player_name
    stone_count = cups[start_pos].count
    ending_cup_idx = (start_pos + stone_count) % 13
    cups[start_pos] = []
    i = 1
    while i <= stone_count
      if (start_pos + i) % 13 == 13 && current_player_name == player1
        ending_cup_idx = (ending_cup_idx + 1) % 13
        cups[ending_cup_idx] << :stone
        next
      elsif (start_pos + i) % 13 == 6 && current_player_name == player2
        ending_cup_idx = (ending_cup_idx + 1) % 13
        cups[ending_cup_idx] << :stone
        next
      else
        cups[(start_pos + i) % 13] << :stone
      end

      i += 1
    end

    render

    next_turn(ending_cup_idx)
    # if cups[ending_cup_idx].length <= 1
    #   return :switch
    # else
    #   return :prompt
    # end

  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
    # make_move(ending_cup_idx, current_player) if cups[ending_cup_idx].length > 1
    # debugger
    if cups[ending_cup_idx].length < 1
      return :switch
    elsif cups[ending_cup_idx].empty?
      return :switch
    else
      return :prompt
    end
    # if cups[ending_cup_idx].length <= 1
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
    case cups[6].length <=> cups[13].length
    when 1
      player1
    when -1
      player2
    when 0
      :draw
    end
    # return player1 if cups[6].count > cups[13].count
    # return player2 if cups[13].count > cups[6].count
    # return :draw if cups[6].count == cups[13].count
  end
end
