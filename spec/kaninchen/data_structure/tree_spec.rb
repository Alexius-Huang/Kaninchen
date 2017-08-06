# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kaninchen::DataStructure::Tree do
  describe 'initialization' do
    it 'can initialize with a root value'
    it 'can initialize with a root value as node'
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
      context '#each_node' do
        it 'should loop through tree default with preorder-traversal'
        it 'should loop through tree specified :preorder or :depth_first as preorder-traversal'
        it 'should loop through tree specified :inorder as inorder-traversal'
        it 'should loop through tree specified :postorder as postorder-traversal'
        it 'should loop through tree specified :levelorder or :breath_first as levelorder-traversal'
      end

      context 'each_leaves' do
        it 'should loop through leaves of the tree'
      end
    end

    describe 'tree properties' do
      context '#root' do
        it 'returns the root node'
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

      context 'edges' do
        it 'should return the count of the edges of the tree'
      end

      context 'height' do
        it 'should return the height of the tree'
      end
    end
  end
end
