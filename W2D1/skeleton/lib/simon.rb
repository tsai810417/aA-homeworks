class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until game_over
      take_turn
      round_success_message
    end


    self.game_over_message
    self.reset_game

  end

  def take_turn
    round_success_message
    self.show_sequence
    self.require_sequence
    @sequence_length += 1
  end

  def show_sequence
    self.add_random_color
  end

  def require_sequence
    puts "Enter sequence"
    user_input = gets.chomp
  end

  def add_random_color
    @seq.push(COLORS.sample)
  end

  def round_success_message
    puts "You entered right sequence"
  end

  def game_over_message
    puts "You entered wrong sequence"
  end

  def reset_game
    @sequence_length = 1
    @seq = []
    @game_over = false
  end
end
