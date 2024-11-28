require 'time'

class SystemTimeChecker
  def initialize(log_file: 'system_time.log', interval: 60)
    @log_file = log_file
    @interval = interval
  end

  def start
    @daemon_thread = Thread.new do
      next_time = Time.now
      loop do
        begin
          next_time += @interval
          log_system_time
          sleep_time = next_time - Time.now
          sleep(sleep_time.positive? ? sleep_time : 0)
        rescue StandardError => e
          log_error(e)
        end
      end
    end
    @daemon_thread.abort_on_exception = true
  end

  private

  def log_system_time
    current_time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
    puts "Системний час: #{current_time}"
    File.open(@log_file, 'a') do |file|
      file.puts("Системний час: #{current_time}")
    end
  end

  def log_error(error)
    File.open(@log_file, 'a') do |file|
      file.puts("Помилка: #{error.message} - #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}")
    end
  end
end

checker = SystemTimeChecker.new(interval: 60)
checker.start
loop { sleep 1 }




