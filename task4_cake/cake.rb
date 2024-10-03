cake_input = <<~Cake
  ........
  ...o....
  ....o...
  ........
Cake

def get_raisins(cake)
  coords = []
  cake.each_with_index do |row, i|
    row.each_char.with_index do |char, j|
      coords << [i, j] if char == 'o'
    end
  end
  coords
end

def split_cake(cake, raisins)
  horizontal = get_horizontal_slices(cake, raisins)
  vertical = get_vertical_slices(cake, raisins)
  if horizontal.empty? && vertical.empty?
    puts "No valid slices can be made from the cake"
    return []
  end


  if !horizontal.empty? && (vertical.empty? || horizontal.first[0].length >= vertical.first[0].length)
    horizontal
  else
    vertical
  end
end

def get_horizontal_slices(cake, raisins)
  slices = []
  last_row = 0
  raisins.each_with_index do |_, i|
    next_row = (i == raisins.length - 1) ? cake.length - 1 : raisins[i + 1][0] - 1
    slices << cake[last_row..next_row]
    last_row = next_row + 1
  end
  slices
end

def get_vertical_slices(cake, raisins)
  rotated_cake = cake.map(&:chars).transpose.map(&:join)
  transformed_raisins = raisins.map { |row, col| [col, row] }
  horizontal_cuts = get_horizontal_slices(rotated_cake, transformed_raisins)
  horizontal_cuts.map { |cut| cut.map(&:chars).transpose.map(&:join) }
end

def solve_cake_problem(cake)
  lines = cake.split("\n")
  raisins = get_raisins(lines)
  horizontal = get_horizontal_slices(lines, raisins)
  vertical = get_vertical_slices(lines, raisins)
  if horizontal.empty? && vertical.empty?
    puts "No valid slices can be made from the cake."
    return []
  end


  if !horizontal.empty? && (vertical.empty? || horizontal.first[0].length >= vertical.first[0].length)
    horizontal
  else
    vertical
  end
end
result = solve_cake_problem(cake_input)
puts "Pieces of cake:"
result.each_with_index do |piece, idx|
  puts "Piece #{idx + 1}:"
  puts piece.join("\n")
  puts
end