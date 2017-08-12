# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kaninchen::DataStructure::Set do
  describe 'initialization' do
    it 'can initialize as an empty set'
    it 'can initialize with multiple items'
  end

  describe 'set properties' do
    context '#elements' do
      it 'returns the elements in set as a array'
    end

    context '#size' do
      it 'returns the count of the elements in a set'
    end
  end

  describe 'instance methods' do
    describe 'element insertion' do
      context '#<<' do
        it 'should append an input element in a set'
        it 'should append a series of input elements with chained #<<'
      end

      context 'alias #<< methods: #insert, #append' do
        it 'should append an input element in a set with alias method #insert, #append'
        it 'should append a series of input elements with multiple value assigned in #insert and #append'
        it 'should append a series of input elements with chained alias method #insert, #append'
      end
    end

    describe 'element deletion' do
      context '#remove and #remove!' do
        it 'should remove the value in the receiver set'
        it 'should remove a series of elements if specified multiple arguments'
        it 'should remove a series of elements with chained method #remove'
        it 'mutates the receiver set which removes the value with the bang method #remove!'

        context 'alias method #delete and bang method #delete!' do
          it 'should perform similar operation like #remove method'
          it 'should perform similar operation like bang #remove! method'
        end
      end
    end

    describe 'logical operations' do
      context '#union and #union!' do
        it 'returns the united set with the argument set'
        it 'can union with multiple sets as input arguments'
        it 'can accept multiple sets union with chained #union'
        it 'mutates the receiver set union with the argument with the bang method #union!'
        it 'mutates the receiver set union with multiple sets as argument with the bang method #union!'

        context 'alias method #+' do
          it 'can union with the :+ method'
          it 'can union with the chained :+ method'
        end
      end

      context '#intersect and #intersect!' do
        it 'returns the intersection of the set'
        it 'can intersect with multiple sets as input arguments'
        it 'can accept multiple sets intersect with chained #intersect'
        it 'mutates the receiver set intersect with the argument with the bang method #intersect!'
        it 'mutates the receiver set intersect with multiple sets as argument with the bang method #intersect!'

        context 'alias method #*' do
          it 'can intersect with the :* method'
          it 'can intersect with the chained :* method'
        end
      end

      context '#difference and #difference!' do
        it 'returns the difference set with the argument set'
        it 'can difference with multiple sets as input arguments'
        it 'can accept multiple sets difference with chained #difference'
        it 'mutates the receiver set difference with the argument with the bang method #difference!'
        it 'mutates the receiver set difference with multiple sets as argument with the bang method #difference!'

        context 'alias method #-' do
          it 'can difference with the :- method'
          it 'can difference with the chained :- method'
        end
      end

      context '#union, #intersect and #difference operation' do
        it 'can perform different chained methods around logical operations'
        it 'can perform different chained methods around arithmetic operations: #+, #- and #*'
      end
    end

    describe 'distinct set' do
      context '#distinct and #distinct!' do
        it 'returns the distincted set which removes the duplicated value'
        it 'mutates the receiver set which removes the duplicated value'
      end

      context 'behave_distinct!' do
        it 'sets the set data structure to be a kind of distinct set'
        it 'should also make the set distinct before behaving like a distinct set'
      end

      context '#distinct?' do
        it 'returns true if it is a distinct set'
      end

      describe 'distinct set logical operation' do
        context '#union and #union!' do
          it 'will return a distinct set if it is a receiver'
          it 'will not return a distinct set if receiver is not a distinct set'
        end

        context '#intersect and #intersect!' do
          it 'will return a distinct set if it is a receiver'
          it 'will not return a distinct set if receiver is not a distinct set'
        end
      end
    end

    describe 'looping methods' do
      context '#each_element' do
        it 'loops throught the elements in a set'
      end

      context '#filter and #filter!' do
        it 'returns the filtered set with given block as a filter'
        it 'mutated the receiver set with given block with the bang method #filter!'
      end

      context '#map and #map!' do
        it 'returns the mapped set with given block as a map'
        it 'mutated the receiver set with given block with the bang method #map!'
      end

      context '#reduce' do
        it 'returns the reduced or converged set value with the given block operation'
      end
    end

    context '#accept_only' do
      it 'should enables the set to accept specific data type of value'
      it 'should enables the set to accept specific data types of value with array'
    end

    context '#freeze' do
      it 'can transform to frozen set which is immutable (including not able to append and delete)'
    end

    context '#frozen?' do
      it 'returns true if it is a frozen set'
    end
  end
end
