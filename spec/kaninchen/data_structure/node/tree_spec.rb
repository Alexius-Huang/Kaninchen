# frozen_string_literal: true

require 'spec_helper'
require 'byebug'

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
      let(:nodes_hash) do
        {
          described_class.new('CHILD1') => described_class.new('GRANDCHILD1'),
          described_class.new('CHILD2') => [
            described_class.new('GRANDCHILD2'),
            described_class.new('GRANDCHILD3')
          ],
          described_class.new('CHILD3') => {
            described_class.new('GRANDCHILD4') => nil
          },
          described_class.new('CHILD4') => nil
        }
      end

      it 'should append the input node as child node' do
        expect(tree.root.children.empty?).to be_truthy
        tree.root << node
        expect(node.parent).to be tree.root
        expect(node.tree).to be tree
        expect(tree.root.children.empty?).to be_falsey
        expect(tree.root.children.size).to be 1
        expect(tree.root.children.first).to be node
        expect(tree.root.children.first.parent).to be tree.root
      end

      it 'should append the input nodes as child nodes via chained methods #<<' do
        expect(tree.root.children.empty?).to be_truthy
        tree.root << nodes_array[0] << nodes_array[1] << nodes_array[2]
        expect(tree.root.children.empty?).to be_falsey
        expect(tree.root.children.size).to be 3
        0.upto(2) do |index|
          expect(nodes_array[index].parent).to be tree.root
          expect(nodes_array[index].tree).to be tree
          expect(tree.root.children[index]).to be nodes_array[index]
          expect(tree.root.children[index].parent).to be tree.root
        end
      end

      it 'should append an array of nodes as child nodes' do
        expect(tree.root.children.empty?).to be_truthy
        tree.root << nodes_array
        expect(tree.root.children.empty?).to be_falsey
        expect(tree.root.children.size).to be 3
        0.upto(2) do |index|
          expect(nodes_array[index].parent).to be tree.root
          expect(nodes_array[index].tree).to be tree
          expect(tree.root.children[index]).to be nodes_array[index]
          expect(tree.root.children[index].parent).to be tree.root
        end
      end

      it 'should append a hash structure of nodes as a subtree of the node' do
        expect(tree.root.children.empty?).to be_truthy
        tree.root << nodes_hash
        children = tree.root.children
        expect(children.empty?).to be_falsey
        expect(children.size).to be 4
        expect(children[0].children.size).to be 1
        expect(children[1].children.size).to be 2
        expect(children[2].children.size).to be 1
        expect(children[3].children.size).to be_zero
      end

      it 'should append a tree type data structure as a subtree of the node'
    end
  end
end
