# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kaninchen::DataStructure::Tree do
  let(:tree)   { described_class.new 'ROOT' }
  let(:root)   { Kaninchen::DataStructure::Node.new 'ROOT' }
  let(:node_1) { Kaninchen::DataStructure::Node.new 'CHILD1' }
  let(:node_2) { Kaninchen::DataStructure::Node.new 'CHILD2' }
  let(:node_3) { Kaninchen::DataStructure::Node.new 'CHILD3' }
  let(:node_4) { Kaninchen::DataStructure::Node.new 'CHILD4' }
  let(:node_5) { Kaninchen::DataStructure::Node.new 'CHILD5' }
  let(:node_6) { Kaninchen::DataStructure::Node.new 'CHILD6' }
  let(:sample_tree_struct) do
    {
      node_1 => [node_2, node_3],
      node_4 => nil,
      node_5 => node_6
    }
  end

  describe 'initialization' do
    it 'can initialize with a root value' do
      expect(tree.class).to eq described_class
    end

    it 'can initialize with a root value as node' do
      tree = described_class.new root
      expect(tree.class).to eq described_class
    end

    it 'cannot initialize without root specified'
    it 'cannot initialize with a root value as node which is not tree type'
  end

  describe 'class methods' do
    describe 'initialize tree instance from an array of nodes' do
      context 'from_nodes' do
        it 'can initialize a tree instance with a hash of node structure'
      end
    end
  end

  describe 'instance methods' do
    describe 'looping methods' do
      context '#each_node & #each_node_with_index' do
        let(:preorder) { [tree.root, node_1, node_2, node_3, node_4, node_5, node_6] }

        before { tree.root << sample_tree_struct }

        shared_examples 'preorder case' do |params|
          it "should loop through tree specified #{params} as preorder-traversal" do
            index = 0
            tree.each_node(params) do |node|
              expect(node).to eq preorder[index]
              index += 1
            end

            tree.each_node_with_index(params) { |node, index| expect(node).to eq preorder[index] }
          end
        end
        
        it 'should loop through tree default with preorder-traversal' do
          index = 0
          tree.each_node do |node|
            expect(node).to eq preorder[index]
            index += 1
          end

          tree.each_node_with_index { |node, index| expect(node).to eq preorder[index] }
        end

        it_should_behave_like 'preorder case', :preorder
        it_should_behave_like 'preorder case', :depth_first

        it 'should loop through tree specified :inorder as inorder-traversal'
        it 'should loop through tree specified :postorder as postorder-traversal'
        it 'should loop through tree specified :levelorder or :breath_first as levelorder-traversal'
      end

      context '#each_leaf' do
        it 'should loop through leaves of the tree'
      end
    end

    describe 'tree properties' do
      context '#root' do
        it 'returns the root node' do
          root = tree.root
          expect(root.class).to eq Kaninchen::DataStructure::Node
          expect(root.tree_node?).to be_truthy
          expect(root.root?).to be_truthy
          expect(root.value).to eq 'ROOT'
        end
      end

      context '#nodes' do
        it 'should return a hash structure of tree nodes by default'
        it 'should return array of nodes preorder if specified :preorder or :depth_first'
        it 'should return array of nodes inorder if specified :inorder'
        it 'should return array of nodes postorder if specified :postorder'
        it 'should return array of nodes levelorder if specified :levelorder or :breath_first'
      end

      context '#leaves' do
        it 'should return an array of leaves of the tree'
      end

      context '#degree' do
        it 'should return the degree of the tree (which is the degree of root)'
      end

      context '#edges' do
        it 'should return the count of the edges of the tree'
      end

      context '#height' do
        it 'should return the height of the tree'
      end
    end
  end
end
