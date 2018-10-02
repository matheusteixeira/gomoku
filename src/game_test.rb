require_relative 'board'
require_relative 'state'
require_relative 'calculator'
require_relative 'minimax_service'

puts "Who's gonna Start?\n Type H for Human or P for PC"
a = gets.chomp.downcase

while(a != 'h' && a != 'p') do
  puts "Who's gonna Start?\n Type H for Human or P for PC"
  a = gets.chomp.downcase
end

board = if a == 'p'
          Board.new('pc', 'human')
        else
          Board.new('human', 'pc')
        end

judge_calculator = Calculator.new(board)
players = [board.starting_player, board.second_player]

puts "PC pieces: #{board.pc_color} | Human pieces: #{board.human_color}"

puts "New round: \n"

# TODO: Replace count by end of game. Declare winner
count = 0

first_end_game = board.end_game?(board.starting_player, judge_calculator)
second_end_game = board.end_game?(board.second_player, judge_calculator)

while(!(first_end_game && second_end_game))
  current_player = players.first

  if current_player.name == 'pc'
    # minimax to decide
    state = State.new(board, current_player)
    play = MinimaxService.evaluate(state, -Float::INFINITY, Float::INFINITY, 10)

    judge_calculator.add_white(play) if current_player.color == 'white'
    judge_calculator.add_black(play) if current_player.color == 'black'

    board.play(play[1][0], play[1][1], current_player.color)
    puts "PC Played: (#{play[1][0]}, #{play[1][1]})"
  else
    i,j = -1, -1

    while !(board.valid_play?(i, j, current_player.color)) do
      puts 'Select a row to play:'
      i = gets.chomp.to_i
      puts 'Select a column to play:'
      j = gets.chomp.to_i
    end

    judge_calculator.add_white([i, j]) if current_player.color == 'white'
    judge_calculator.add_black([i, j]) if current_player.color == 'black'

    board.play(i, j, current_player.color)
  end

  puts "#{board.print_board}"
  count += 1
  players = players.reverse

  first_end_game = board.end_game?(board.starting_player, judge_calculator)
  second_end_game = board.end_game?(board.second_player, judge_calculator)
end

puts "#{board.print_board}"
