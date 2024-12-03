require 'rspec'
require_relative 'exam'

RSpec.describe CharFreq do
  context 'when valid input is provided' do
    it 'calculates frequency correctly for a simple string' do
      frequency = CharFreq.new('hello').calculate_frequency
      expect(frequency).to eq({ 'h' => 1, 'e' => 1, 'l' => 2, 'o' => 1 })
    end

    it 'handles strings with spaces and special characters' do
      frequency = CharFreq.new('hello world!').calculate_frequency
      expect(frequency).to eq({ 'h' => 1, 'e' => 1, 'l' => 3, 'o' => 2, ' ' => 1, 'w' => 1, 'r' => 1, 'd' => 1, '!' => 1 })
    end

    it 'handles strings with numeric characters' do
      frequency = CharFreq.new('123123').calculate_frequency
      expect(frequency).to eq({ '1' => 2, '2' => 2, '3' => 2 })
    end

    it 'returns the correct frequency for a string with repeated characters' do
      frequency = CharFreq.new('aaaa').calculate_frequency
      expect(frequency).to eq({ 'a' => 4 })
    end

    it 'differentiates between uppercase and lowercase characters' do
      frequency = CharFreq.new('AaAa').calculate_frequency
      expect(frequency).to eq({ 'A' => 2, 'a' => 2 })
    end
  end

  context 'when input contains unusual cases' do
    it 'handles an empty string with spaces gracefully' do
      expect { CharFreq.new('   ') }.to raise_error(ArgumentError, 'Input cannot be empty or just whitespace.')
    end

    it 'handles non-ASCII characters' do
      frequency = CharFreq.new('привіт').calculate_frequency
      expect(frequency).to eq({ 'п' => 1, 'р' => 1, 'и' => 1, 'в' => 1, 'і' => 1, 'т' => 1 })
    end

    it 'handles strings with emojis' do
      frequency = CharFreq.new('🙂🙂🙃').calculate_frequency
      expect(frequency).to eq({ '🙂' => 2, '🙃' => 1 })
    end
  end

  context 'when invalid input is provided' do
    it 'raises an error for non-string input' do
      expect { CharFreq.new(123) }.to raise_error(ArgumentError, 'Input must be a valid string.')
    end

    it 'raises an error for nil input' do
      expect { CharFreq.new(nil) }.to raise_error(ArgumentError, 'Input must be a valid string.')
    end

    it 'raises an error for an empty string' do
      expect { CharFreq.new('') }.to raise_error(ArgumentError, 'Input cannot be empty or just whitespace.')
    end
  end
end

