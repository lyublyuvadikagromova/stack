require 'thread'

class NumProcessor
  def initialize
    @queue = Queue.new
  end

  def generate_numbers(limit = nil)
    count = 0
    loop do
      break if limit && count >= limit
      num = rand(1..100)
      @queue << num
      count += 1
      sleep 0.1
    end
  rescue StandardError => e
    puts "Error in generator: #{e.message}"
  ensure
    @queue << :done unless @queue.closed?
  end

  def process_numbers
    loop do
      num = @queue.pop
      break if num == :done
      puts "Непарне число: #{num}" if num.odd?
    end
  rescue StandardError => e
    puts "Error in processor: #{e.message}"
  end
end

if $PROGRAM_NAME == __FILE__
  processor = NumProcessor.new

  generator_thread = Thread.new { processor.generate_numbers }
  processor_thread = Thread.new { processor.process_numbers }

  generator_thread.join
  processor_thread.join
end


