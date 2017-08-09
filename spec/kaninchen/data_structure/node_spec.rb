# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kaninchen::DataStructure::Node do
  let(:empty_node)    { described_class.new }
  let(:sample_string) { 'sample node' }
  let(:sample_node)   { described_class.new sample_string }
  let(:tree_node)     { described_class.new type: :tree, value: sample_string }

  describe 'initialization' do
    it 'can initialize as an empty node data' do
      expect(empty_node.class).to eq described_class
    end

    it 'can initialize as a node with data' do
      expect(sample_node.class).to eq described_class
      expect(sample_node.value).to eq sample_string
    end

    it 'can explicitly initialized as a tree type node' do
      expect(tree_node.class).to eq described_class
      expect(tree_node.value).to eq sample_string
      expect(tree_node.type).to eq :tree
    end
  end

  describe 'instance methods' do
    describe 'node properties' do
      context '#value' do
        it 'can get the value of the node' do
          expect(sample_node.value).to eq sample_string
        end
      end

      context '#type' do
        it 'can get the type of the node' do
          expect(tree_node.type).to eq :tree
        end
      end

      context '#nil?' do
        it 'returns true if node is nil type' do
          expect(sample_node.nil?).to be_truthy
        end
      end
    end

    describe 'tree type nodes' do
      context '#root?' do
        it 'should returns true if it is tree root node' do
          root = Kaninchen::DataStructure::Tree.new('ROOT').root
          expect(root.root?).to be_truthy
        end
      end

      context '#tree_node?' do
        it 'should returns true if it is tree node type' do
          expect(tree_node.tree_node?).to be_truthy
        end
      end

      context '#<<' do
        it 'should append the input node as child node'
        it 'should append the input nodes as child nodes via chained methods #<<'
        it 'should append an array of nodes as child nodes'
        it 'should append a hash structure of nodes as a subtree of the node'
        it 'should append a tree type data structure as a subtree of the node'
      end
    end
  end
end
