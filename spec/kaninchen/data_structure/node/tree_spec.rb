# frozen_string_literal: true

require 'spec_helper'
require 'byebug'

RSpec.describe Kaninchen::DataStructure::Node do
  let(:tree) { Kaninchen::DataStructure::Tree.new('ROOT') }
  let(:node) { described_class.new 'node' }
  1.upto(10) { |index| let(:"node_#{index}") { described_class.new "CHILD#{index}" } }
  let(:sample_tree_struct) do
    {
      node_1 => [node_2, node_3],
      node_4 => nil,
      node_5 => node_6,
      node_7 => [{ node_8 => node_9 }, node_10]
    }
  end

  describe 'tree node properties' do
    before { tree.root << sample_tree_struct }
    context '#degree' do
      it 'should return the degree of the tree node (which is the count of sub-trees of the node)' do
        expect(tree.root.degree).to be 4
        expect(node_1.degree).to be 2
        expect(node_2.degree).to be 0
        expect(node_3.degree).to be 0
        expect(node_4.degree).to be 0
        expect(node_5.degree).to be 1
        expect(node_6.degree).to be 0
        expect(node_7.degree).to be 2
        expect(node_8.degree).to be 1
        expect(node_9.degree).to be 0
        expect(node_10.degree).to be 0
      end
    end

    context '#path' do
      it 'should return array of node to the root node represents the path' do
        expect(tree.root.path).to eq [tree.root]
        expect(node_1.path).to eq [node_1, tree.root]
        expect(node_2.path).to eq [node_2, node_1, tree.root]
        expect(node_3.path).to eq [node_3, node_1, tree.root]
        expect(node_4.path).to eq [node_4, tree.root]
        expect(node_5.path).to eq [node_5, tree.root]
        expect(node_6.path).to eq [node_6, node_5, tree.root]
        expect(node_7.path).to eq [node_7, tree.root]
        expect(node_8.path).to eq [node_8, node_7, tree.root]
        expect(node_9.path).to eq [node_9, node_8, node_7, tree.root]
        expect(node_10.path).to eq [node_10, node_7, tree.root]
      end
    end

    context '#depth' do
      it 'should return the depth of the tree node (which is the distance between root node and the node)' do
        expect(tree.root.depth).to be 0
        expect(node_1.depth).to be 1
        expect(node_2.depth).to be 2
        expect(node_3.depth).to be 2
        expect(node_4.depth).to be 1
        expect(node_5.depth).to be 1
        expect(node_6.depth).to be 2
        expect(node_7.depth).to be 1
        expect(node_8.depth).to be 2
        expect(node_9.depth).to be 3
        expect(node_10.depth).to be 2
      end
    end

    context '#level' do
      it 'should return the level of the tree node (which is defined by node\'s depth + 1)' do
        expect(tree.root.level).to be 1
        expect(node_1.level).to be 2
        expect(node_2.level).to be 3
        expect(node_3.level).to be 3
        expect(node_4.level).to be 2
        expect(node_5.level).to be 2
        expect(node_6.level).to be 3
        expect(node_7.level).to be 2
        expect(node_8.level).to be 3
        expect(node_9.level).to be 4
        expect(node_10.level).to be 3
      end
    end

    context '#subtree' do
      it 'should return new Tree type object which represents the subtree which root is the node itself' do
        subtree = node_7.subtree
        expect(subtree.root.value).to eq 'CHILD7'
        expect(subtree.root.children.size).to eq 2
        expect(subtree.root.children[0].value).to eq 'CHILD8'
        expect(subtree.root.children[1].value).to eq 'CHILD10'
        expect(subtree.root.children[0].children.size).to eq 1
        expect(subtree.root.children[1].children.size).to eq 0
        expect(subtree.root.children[0].children[0].value).to eq 'CHILD9'
      end
    end

    context '#height' do
      it 'should return the height of the tree node (which is the distance between node and the node)' do
        expect(tree.root.height).to be 4
        expect(node_1.height).to be 2
        expect(node_2.height).to be 1
        expect(node_3.height).to be 1
        expect(node_4.height).to be 1
        expect(node_5.height).to be 2
        expect(node_6.height).to be 1
        expect(node_7.height).to be 3
        expect(node_8.height).to be 2
        expect(node_9.height).to be 1
        expect(node_10.height).to be 1
      end
    end

    context '#left_child' do
      it 'should return the left child of the node' do
        expect(tree.root.left_child).to be node_1
        expect(node_1.left_child).to be node_2
        expect(node_2.left_child).to be nil
        expect(node_3.left_child).to be nil
        expect(node_4.left_child).to be nil
        expect(node_5.left_child).to be node_6
        expect(node_6.left_child).to be nil
        expect(node_7.left_child).to be node_8
        expect(node_8.left_child).to be node_9
        expect(node_9.left_child).to be nil
        expect(node_10.left_child).to be nil
      end
    end

    context '#right_child' do
      it 'should return the right child of the node' do
        expect(tree.root.right_child).to be node_4
        expect(node_1.right_child).to be node_3
        expect(node_2.right_child).to be nil
        expect(node_3.right_child).to be nil
        expect(node_4.right_child).to be nil
        expect(node_5.right_child).to be nil
        expect(node_6.right_child).to be nil
        expect(node_7.right_child).to be node_10
        expect(node_8.right_child).to be nil
        expect(node_9.right_child).to be nil
        expect(node_10.right_child).to be nil
      end
    end
  end

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
