# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kaninchen::DataStructure::Node do
  let(:tree) { Kaninchen::DataStructure::Tree.new('ROOT') }
  let(:node) { Kaninchen::DataStructure::Node.new('node') }

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
      it 'should append the input node as child node' do
        expect(tree.root.children.empty?).to be_truthy
        tree.root << node
        expect(tree.root.children.empty?).to be_falsey
        expect(tree.root.children.size).to be 1
        expect(tree.root.children.first).to eq node
        expect(tree.root.children.first.parent).to eq tree.root
      end

      it 'should append the input nodes as child nodes via chained methods #<<'
      it 'should append an array of nodes as child nodes'
      it 'should append a hash structure of nodes as a subtree of the node'
      it 'should append a tree type data structure as a subtree of the node'
    end
  end
end
