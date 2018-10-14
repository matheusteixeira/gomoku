class State
  attr_reader :board, :current_player, :move

  def initialize(board, current_player)
    @board = board
    @current_player = current_player
    @move = nil
  end

  def current_state
    @board.board
  end

  def children_states
    children.each_with_object([]) do |child, boards|
      b = Marshal.load(Marshal.dump(board))
      @move = [child[0], child[1]]
      add_piece_to_calculate(@move)
      b.play(@move[0], @move[1], current_player.color)

      boards << State.new(b, opponent)
    end
  end

  def state_value
    if current_player.name == 'pc' && current_player.color == 'black'
      calculator.count_black - calculator.count_white
    else
      calculator.count_white - calculator.count_black
    end
  end

  def end_game?
    if current_player.color == 'black'
      calculator.horizontal_win?(calculator.horizontal_black) ||
       calculator.vertical_win?(calculator.vertical_black)
    else
      calculator.horizontal_win?(calculator.horizontal_white) ||
       calculator.vertical_win?(calculator.vertical_white)
    end
  end

  def opponent
    return board.second_player if current_player.name == board.starting_player.name

    board.starting_player
  end

  private

  def children
    return [[7,7]] if board.board[opponent_color].empty?
    boundaries = []

    board.board[opponent_color].each do |position|
      boundaries << [position[0] + 4, position[1] + 4]
      boundaries << [position[0] - 4, position[1] - 4]
    end

    board.free.each_with_object([]) do |f, r|
      r << f if between_interval?(f, boundaries)
    end
  end

  def between_interval?(piece, boundaries)
    piece[0].between?(boundaries.min[0], boundaries.max[0]) &&
      piece[1].between?(boundaries.min[1], boundaries.max[1])
  end

  def opponent_color
    opponent.color
  end

  def calculator
    Calculator.new(board)
  end

  def add_piece_to_calculate(piece)
    calculator.add_black(piece) if current_player.color == 'black'
    calculator.add_white(piece) if current_player.color == 'white'
  end
end
