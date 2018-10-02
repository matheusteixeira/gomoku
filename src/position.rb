class Position

  attr_reader :row, :column

  def initialize(row, column)
    @row = row
    @column = column
  end

  def vector
    [@row, @column]
  end
end
