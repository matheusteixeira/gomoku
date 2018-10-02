require 'set'

class Calculator
  attr_accessor :vertical_black, :horizontal_black, :vertical_white, :horizontal_white
  attr_reader :board

  def initialize(board)
    @board = board

    @vertical_black = {
      0 => Set.new,
      1 => Set.new,
      2 => Set.new,
      3 => Set.new,
      4 => Set.new,
      5 => Set.new,
      6 => Set.new,
      7 => Set.new,
      8 => Set.new,
      9 => Set.new,
      10 => Set.new,
      11 => Set.new,
      12 => Set.new,
      13 => Set.new,
      14 => Set.new
    }

    @horizontal_black = {
      0 => Set.new,
      1 => Set.new,
      2 => Set.new,
      3 => Set.new,
      4 => Set.new,
      5 => Set.new,
      6 => Set.new,
      7 => Set.new,
      8 => Set.new,
      9 => Set.new,
      10 => Set.new,
      11 => Set.new,
      12 => Set.new,
      13 => Set.new,
      14 => Set.new
    }

    @vertical_white = {
      0 => Set.new,
      1 => Set.new,
      2 => Set.new,
      3 => Set.new,
      4 => Set.new,
      5 => Set.new,
      6 => Set.new,
      7 => Set.new,
      8 => Set.new,
      9 => Set.new,
      10 => Set.new,
      11 => Set.new,
      12 => Set.new,
      13 => Set.new,
      14 => Set.new
    }

    @horizontal_white = {
      0 => Set.new,
      1 => Set.new,
      2 => Set.new,
      3 => Set.new,
      4 => Set.new,
      5 => Set.new,
      6 => Set.new,
      7 => Set.new,
      8 => Set.new,
      9 => Set.new,
      10 => Set.new,
      11 => Set.new,
      12 => Set.new,
      13 => Set.new,
      14 => Set.new
    }
  end

  def count_white
    count_vertical_white + count_horizontal_white
  end

  def count_black
    count_vertical_black + count_horizontal_black
  end

  def add_black(piece)
    board.board["black"].each do |piece|
      vertical_black[piece[1]].add(piece)
    end

    board.board["black"].each do |piece|
      horizontal_black[piece[0]].add(piece)
    end
  end

  def add_white(piece)
    board.board["black"].each do |piece|
      vertical_white[piece[1]].add(piece)
    end

    board.board["black"].each do |piece|
      horizontal_white[piece[0]].add(piece)
    end
  end

  def horizontal_win?(color_horizontal_hash)
    counters = []

    (0..14).each do |i|
      count = 0
      c = color_horizontal_hash[i].to_a
      c = c.sort_by{|x| x[1] }

      c.each_with_index do |y, i|
        break if i + 1 >= c.size
        if (c[i][1] - c[i+1][1]) == -1
          count = count + 1
        end
      end
      counters << count
    end
    counters.any? { |count| count == 4 }
  end

  def vertical_win?(color_vertical_hash)
    counters = []

    (0..14).each do |i|
      count = 0
      c = color_vertical_hash[i].to_a
      c = c.sort_by{|x| x[0] }

      c.each_with_index do |y, i|
        break if i + 1 >= c.size
        if (c[i][0] - c[i+1][0]) == -1
          count = count + 1
        end
      end
      counters << count
    end
    counters.any? { |count| count == 4 }
  end

  def count_vertical_black
    unities, doubles, triples, quads, quint = Array.new(5, 0)
    vertical_black.values.map(&:size).each do |x|
      case x
      when 1
        unities += 1
      when 2
        doubles += 1
      when 3
        triples += 1
      when 4
        quads += 1
      when 5
        quint += 1
      end
    end

    2048*quint + 512*quads + 64*triples + 4*doubles + 2*unities
  end

  def count_horizontal_black
    unities, doubles, triples, quads, quint = Array.new(5, 0)
    horizontal_black.values.map(&:size).each do |x|
      case x
      when 1
        unities += 1
      when 2
        doubles += 1
      when 3
        triples += 1
      when 4
        quads += 1
      when 5
        quint += 1
      end
    end

    2048*quint + 512*quads + 64*triples + 4*doubles + 2*unities
  end

  def count_vertical_white
    unities, doubles, triples, quads, quint = Array.new(5, 0)
    vertical_white.values.map(&:size).each do |x|
      case x
      when 1
        unities += 1
      when 2
        doubles += 1
      when 3
        triples += 1
      when 4
        quads += 1
      when 5
        quint += 1
      end
    end

    2048*quint + 512*quads + 64*triples + 4*doubles + 2*unities
  end

  def count_horizontal_white
    unities, doubles, triples, quads, quint = Array.new(5, 0)
    horizontal_white.values.map(&:size).each do |x|
      case x
      when 1
        unities += 1
      when 2
        doubles += 1
      when 3
        triples += 1
      when 4
        quads += 1
      when 5
        quint += 1
      end
    end

    2048*quint + 512*quads + 64*triples + 4*doubles + 2*unities
  end
end