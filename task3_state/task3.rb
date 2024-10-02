class MusicPlayer
  def initialize
    @state = 'stopped'
    puts "Поточний стан: #{@state}."
  end

  def play
    if @state == 'stopped'
      puts 'Плеєр ввімкнуто.'
      @state = 'playing'
    elsif @state == 'paused'
      puts 'Музика продовжує грати.'
      @state = 'playing'
    else
      puts 'Помилка, плеєр уже ввімкнутий.'
    end
  end

  def pause
    if @state == 'playing'
      puts 'Пауза.'
      @state = 'paused'
    else
      puts 'Помилка, плєер вже на паузі.'
    end
  end

  def stop
    if @state == 'playing' || @state == 'paused'
      puts 'Плеєр зупинено.'
      @state = 'stopped'
    else
      puts 'Помилка, плеєр уже зупинений.'
    end
  end

  def show_state
    puts "Поточний стан плеєра: #{@state}"
  end
end

player = MusicPlayer.new

loop do
  puts "\nОберіть дію:"
  puts "1 - Ввімкнути плеєр"
  puts "2 - Пауза"
  puts "3 - Зупинити плеєр"
  puts "4 - Показати поточний стан"
  puts "5 - Вийти"

  choice = gets.chomp.to_i

  case choice
  when 1
    player.play
  when 2
    player.pause
  when 3
    player.stop
  when 4
    player.show_state
  when 5
    puts 'завершено'
    break
  else
    puts 'неправильно'
  end
end

