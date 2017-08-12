# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kaninchen::DataStructure::Queue do
  describe 'initialization' do
    it 'can initialize as an empty queue'
    it 'can initialize with multiple items'
  end

  describe 'queue properties' do
    context '#empty?' do
      it 'should return true if queue is empty'
      it 'should return false if queue is not empty'
    end

    context '#size' do
      it 'should return size of the stack'
    end
  end

  describe 'instance methods' do
    context 'pushing into queue instance' do
      context '#<<' do
        it 'can push new item into queue with an input argument'
        it 'can push multiple items into queue with chained #<<'
      end

      context '#push' do
        it 'can push new item into queue with an input argument'
        it 'can push multiple items into queue with chained #push'
      end

      context 'chained #<< and #push' do
        it 'can chain #<< and #push into queue'
      end
    end

    context 'popping items from queue' do
      context '#pop' do
        it 'can pop out items from stack and returns the popped value'
        it 'should return nil when queue is empty'
      end

      context '#pop!' do
        it 'can pop out items from stack and returns the popped value'
        it 'should raise Kaninchen::PopEmptyQueueError when popping empty queue'
      end
    end

    context 'rotating queue' do
      context '#rotate' do
        it 'rotates the queue array which place the last element to the front'
      end

      context '#rotate!' do
        it 'rotates and modified the queue which place the last element to the front'
      end
    end

    context '#accept_only' do
      it 'should enables the queue to accept specific data type of value'
      it 'should enables the queue to accept specific data types of value with array'
    end
  end
end
