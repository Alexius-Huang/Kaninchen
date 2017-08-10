# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kaninchen::DataStructure::Tree do
  let(:tree)    { described_class.new 'ROOT' }
  let(:root)    { Kaninchen::DataStructure::Node.new 'ROOT' }
  1.upto(10) { |index| let(:"node_#{index}") { Kaninchen::DataStructure::Node.new "CHILD#{index}" } }
  let(:sample_tree_struct) do
    {
      node_1 => [node_2, node_3],
      node_4 => nil,
      node_5 => node_6,
      node_7 => [{ node_8 => node_9 }, node_10]
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
        let(:preorder) { [tree.root, node_1, node_2, node_3, node_4, node_5, node_6, node_7, node_8, node_9, node_10] }
        let(:inorder)  { [node_2, node_1, node_3, tree.root, node_4, node_6, node_5, node_9, node_8, node_10, node_7] }

        before { tree.root << sample_tree_struct }

        shared_examples '#each_node' do |params|
          it "should loop through tree specified #{params[:input]} as #{params[:type]}-traversal" do
            order = case params[:type]
                    when :preorder then preorder
                    when :inorder  then inorder
                    end

            index = 0
            tree.each_node(params[:input]) do |node|
              expect(node).to eq order[index]
              index += 1
            end

            tree.each_node_with_index(params[:input]) { |node, index| expect(node).to eq order[index] }
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

        it_should_behave_like '#each_node', type: :preorder, input: :preorder
        it_should_behave_like '#each_node', type: :preorder, input: :depth_first

        it 'should loop through tree specified :postorder as postorder-traversal'
        it 'should loop through tree specified :levelorder or :breath_first as levelorder-traversal'
      end

      context '#each_leaf' do
        it 'should loop through leaves of the tree'
      end
    end

    describe 'tree properties' do
      before { tree.root << sample_tree_struct }

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
        let(:hash_struct) do
          {
            tree.root => {
              node_1 => {
                node_2 => nil,
                node_3 => nil
              },
              node_4 => nil,
              node_5 => {
                node_6 => nil
              },
              node_7 => {
                node_8 => {
                  node_9 => nil
                },
                node_10 => nil
              }
            }
          }
        end
        let(:preorder_nodes) { [tree.root, node_1, node_2, node_3, node_4, node_5, node_6, node_7, node_8, node_9, node_10] }

        it 'should return a hash structure of tree nodes by default' do
          expect(tree.nodes).to eq hash_struct
        end

        shared_examples '#nodes in different case' do |params|
          it "should return array of nodes in #{params[:type]} if specified #{params[:input]}" do
            order_array = case params[:type]
                          when :preorder then preorder_nodes
                          end
            expect(tree.nodes(params[:input])).to eq order_array
          end
        end

        it_should_behave_like '#nodes in different case', type: :preorder, input: :preorder
        it_should_behave_like '#nodes in different case', type: :preorder, input: :depth_first
        it 'should return array of nodes inorder if specified :inorder'
        it 'should return array of nodes postorder if specified :postorder'
        it 'should return array of nodes levelorder if specified :levelorder or :breath_first'
      end

      context '#node_values' do
        let(:hash_struct) do
          {
            'ROOT' => {
              'CHILD1' => {
                'CHILD2' => nil,
                'CHILD3' => nil
              },
              'CHILD4' => nil,
              'CHILD5' => {
                'CHILD6' => nil
              },
              'CHILD7' => {
                'CHILD8' => {
                  'CHILD9' => nil
                },
                'CHILD10' => nil
              }
            }
          }
        end
        let(:preorder_values) { ['ROOT', 'CHILD1', 'CHILD2', 'CHILD3', 'CHILD4', 'CHILD5', 'CHILD6', 'CHILD7', 'CHILD8', 'CHILD9', 'CHILD10'] }

        it 'should return a hash structure of tree node values by default' do
          expect(tree.node_values).to eq hash_struct
        end

        shared_examples '#node_values in different case' do |params|
          it "should return array of nodes in #{params[:type]} if specified #{params[:input]}" do
            order_array = case params[:type]
                          when :preorder then preorder_values
                          end
            expect(tree.node_values(params[:input])).to eq order_array
          end
        end

        it_should_behave_like '#node_values in different case', type: :preorder, input: :preorder
        it_should_behave_like '#node_values in different case', type: :preorder, input: :depth_first
        it 'should return array of nodes inorder if specified :inorder'
        it 'should return array of nodes postorder if specified :postorder'
        it 'should return array of nodes levelorder if specified :levelorder or :breath_first'
      end


      context '#leaves' do
        it 'should return an array of leaves of the tree' do
          expect(tree.leaves).to eq [node_2, node_3, node_4, node_6, node_9, node_10]
        end
      end

      context '#height' do
        it 'should return the height of the tree' do
          expect(tree.height).to be 4
        end
      end
    end
  end
end
