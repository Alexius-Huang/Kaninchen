# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kaninchen::DataStructure::Node do
  let(:tree) { Kaninchen::DataStructure::Tree.new('ROOT') }
  let(:node) { described_class.new('node') }

  describe 'instance methods' do
    context '#root?' do
      it 'should returns true if it is tree root node' do
        root = tree.root
        expect(root.root?).to be_truthy
        root << node
        expect(node.root?).to be_falsey
      end
    end

    context '#tree_node?' do
      it 'should returns true if it is tree node type' do
        expect(node.tree_node?).to be_falsey
        tree.root << node
        expect(node.tree_node?).to be_truthy
      end
    end

    context '#<<' do
      let(:nodes_array) do
        [1, 2, 3].map { |index| described_class.new("node #{index}") }
      end

      it 'should append the input node as child node' do
        expect(tree.root.children.empty?).to be_truthy
        tree.root << node
        expect(tree.root.children.empty?).to be_falsey
        expect(tree.root.children.size).to be 1
        expect(tree.root.children.first).to eq node
        expect(tree.root.children.first.parent).to eq tree.root
      end

      it 'should append the input nodes as child nodes via chained methods #<<' do
        expect(tree.root.children.empty?).to be_truthy
        tree.root << nodes_array[0] << nodes_array[1] << nodes_array[2]
        expect(tree.root.children.empty?).to be_falsey
        expect(tree.root.children.size).to be 3
        0.upto(2) do |index|
          expect(tree.root.children[index]).to eq nodes_array[index]
          expect(tree.root.children[index].parent).to eq tree.root
        end
      end

      it 'should append an array of nodes as child nodes' do
        expect(tree.root.children.empty?).to be_truthy
        tree.root << nodes_array
        expect(tree.root.children.empty?).to be_falsey
        expect(tree.root.children.size).to be 3
        0.upto(2) do |index|
          expect(tree.root.children[index]).to eq nodes_array[index]
          expect(tree.root.children[index].parent).to eq tree.root
        end
      end

      it 'should append a hash structure of nodes as a subtree of the node'
      it 'should append a tree type data structure as a subtree of the node'
    end
  end
end
