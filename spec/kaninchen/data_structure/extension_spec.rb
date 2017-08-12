# frozen_string_literal: true

require 'spec_helper'

Kaninchen::DataStructure.enable_extension!

RSpec.describe Kaninchen::DataStructure::Extension do
  describe 'Object instance methods' do
    context '#to_node' do
      it 'can transform any object data as a value to Node type data as a NilNode'
    end

    context '#to_tree' do
      it 'can transform any object data as a value of the tree root'
      it 'return two values which include a tree type data and a node type data represent as the root of the tree'
    end
  end

  describe 'Array instance methods' do
    context '#to_stack' do
      it 'can transform the array to Stack type value'
    end

    context '#to_queue' do
      it 'can transform the array to Queue type value'
    end

    context '#to_set' do
      it 'can transform the array to Set type value'
    end
  end
end
