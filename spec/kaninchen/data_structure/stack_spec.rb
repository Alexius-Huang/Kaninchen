# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kaninchen::DataStructure::Stack do
  let(:stack) { described_class.new }

  describe 'initialization' do
    it 'can initialize as an empty stack' do
      expect(stack.class).to eq described_class
      expect(stack.empty?).to be_truthy
      expect(stack.size).to be_zero
    end

    it 'can initialize with multiple items' do
      stack = described_class.new(123, 'abc', true)
      expect(stack.class).to eq described_class
      expect(stack.empty?).to be_falsey
      expect(stack.size).to eq 3
    end
  end

  describe 'instance methods' do
    context 'pushing into stack instance' do
      context '#<<' do
        it 'can push new item into stack with an input argument' do
          stack << 123
          stack << 'abc'
          stack << true
          expect(stack.empty?).to be_falsey
          expect(stack.size).to eq 3
        end

        it 'can push multiple items into stack with chained #<<' do
          stack << 123 << 'abc' << true
          expect(stack.empty?).to be_falsey
          expect(stack.size).to eq 3
        end
      end

      context '#push' do
        it 'can push new item into stack with an input argument' do
          stack.push 123
          stack.push 'abc'
          stack.push true
          expect(stack.empty?).to be_falsey
          expect(stack.size).to eq 3
        end

        it 'can push multiple items into stack with chained #push' do
          stack.push(123).push('abc').push(true)
          expect(stack.empty?).to be_falsey
          expect(stack.size).to eq 3
        end
      end

      context 'chained #<< and #push' do
        it 'can chain #<< and #push into stack' do
          (stack.push(123) << 'abc').push(true) << 'stack_test'
          expect(stack.empty?).to be_falsey
          expect(stack.size).to eq 4
        end
      end
    end

    context 'poping items from stack' do
      context '#pop' do
        it 'can pop out items from stack and returns the popped value' do
          stack << 123 << 'abc' << true
          expect(stack.size).to eq 3
          expect(stack.pop).to eq true
          expect(stack.size).to eq 2
          expect(stack.pop).to eq 'abc'
          expect(stack.size).to eq 1
          expect(stack.pop).to eq 123
          expect(stack.size).to be_zero
        end

        it 'should return nil when stack is empty' do
          expect(stack.empty?).to be_truthy
          expect(stack.pop).to be_nil
        end
      end

      context '#pop!' do
        it 'can pop out items from stack and returns the popped value' do
          stack << 123 << 'abc' << true
          expect(stack.size).to eq 3
          expect(stack.pop!).to eq true
          expect(stack.size).to eq 2
          expect(stack.pop!).to eq 'abc'
          expect(stack.size).to eq 1
          expect(stack.pop!).to eq 123
          expect(stack.size).to be_zero
        end

        it 'should raise Kaninchen::PopEmptyStackError when popping empty stack with bang method' do
          expect(stack.empty?).to be_truthy
          expect { stack.pop! }.to raise_error Kaninchen::PopEmptyStackError, 'Popping out empty stack'
        end
      end
    end

    describe 'stack properties' do
      context '#empty?' do
        it 'should return true if stack is empty' do
          expect(stack.empty?).to be_truthy
        end

        it 'should return false if stack is not empty' do
          stack << 123
          expect(stack.empty?).to be_falsey
        end
      end

      context '#size' do
        it 'should return size of the stack' do
          expect(stack.size).to be_zero
          stack << 1 << 2 << 3
          expect(stack.size).to eq 3
          stack << 4 << 5 << 6
          expect(stack.size).to eq 6
          stack << 7 << 8 << 9 << 10
          expect(stack.size).to eq 10
        end
      end
    end
  end
end
