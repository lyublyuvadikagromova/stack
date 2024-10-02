cake_input = <<~CAKE
  .o......
  ......o.
  ....o...
  ..o.....
CAKE
def get_raisins(cake)
  coords = []
  for i in 0...cake.length
    for j in 0...cake[i].length
      coords << [i, j] if cake[i][j] == 'o'
    end
  end
  coords
end

def split_cake(cake, raisins)
  horizontal = get_horizontal_slices(cake, raisins)
  vertical = get_vertical_slices(cake, raisins)

  if horizontal.first[0].length >= vertical.first[0].length
    horizontal
  else
    vertical
  end
end

def get_horizontal_slices(cake, raisins)
  slices = []
  last_row = 0

  for i in 0...raisins.length
    if i == raisins.length - 1
      next_row = cake.length - 1
    else
      next_row = raisins[i + 1][0] - 1
    end

    slices << cake[last_row..next_row]
    last_row = next_row + 1
  end
  slices
end

def get_vertical_slices(cake, raisins)
  rotated_cake = cake.map { |row| row.chars }.transpose.map(&:join)
  horizontal_cuts = get_horizontal_slices(rotated_cake, raisins.map { |row, col| [col, row] })
  horizontal_cuts.map { |cut| cut.map { |str| str.chars }.transpose.map(&:join) }
end

def solve_cake_problem(cake)
  lines = cake.split("\n")
  raisins = get_raisins(lines)
  split_cake(lines, raisins)
end



result = solve_cake_problem(cake_input)
puts "pieces of cake:"
for idx in 0...result.length
  puts "piece #{idx + 1}:"
  puts result[idx].join("\n")
  puts
end
