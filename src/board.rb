require_relative 'player'
require_relative 'position'

class Board
  attr_reader :board, :starting_player, :second_player

  def initialize(starting_player, second_player)
    @starting_player = ::Player.new(starting_player, 'black')
    @second_player = ::Player.new(second_player, 'white')
    @board = set_board
  end

  def free
    board['board'] - (board['white'] + board['black'])
  end

  def play(i, j, value)
    board[value] << ::Position.new(i, j).vector
    itself
  end

  def pc_color
    return starting_player.color if starting_player.name == 'pc'
    second_player.color
  end

  def human_color
    return starting_player.color if starting_player.name == 'human'
    second_player.color
  end

  def valid_play?(i, j, value)
    return false if value != 'black' && value != 'white'
    return false unless free.include? [i, j]
    true
  end

  def copy
    new_board = Board.new(starting_player, second_player)
    new_board.board = board.dup
    new_board
  end

  def print_board
    str = "\n\t0\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\t11\t12\t13\t14\n  #{"\e[0;35;49m-\e[0m"*120}\n"

    board["board"].each do |piece|
      if board['white'].include?(piece)
        str.gsub(/^\t/, '')
        str += " \e[1;37;49mO\e[0m\t \e[0;35;49m|\e[0m"
      elsif board['black'].include?(piece)
        str.gsub(/^\t/, '')
        str += " \e[1;30;49mO\e[0m\t \e[0;35;49m|\e[0m"
      else
        str += "\t \e[0;35;49m|\e[0m"
      end
      if piece[1] == 14
        str += "\n#{piece[0]} #{"\e[0;35;49m-\e[0m"*120}\n"
      end
    end
    str += "\n"
  end

  def end_game?(current_player, calculator)
    if current_player.color == 'black'
      calculator.horizontal_win?(calculator.horizontal_black) ||
       calculator.vertical_win?(calculator.vertical_black)
    else
      calculator.horizontal_win?(calculator.horizontal_white) ||
       calculator.vertical_win?(calculator.vertical_white)
    end
  end

  private

  def set_board
    temp_board = { 'board' => [], 'white' => [], 'black' => [] }
    (0..14).each do |i|
      (0..14).each do |j|
        temp_board['board'] << ::Position.new(i, j).vector
      end
    end

    temp_board
  end
end
