# frozen_string_literal: true

require 'kaninchen/data_structure/tree/nodes'

module Kaninchen
  module DataStructure
    class Tree
      attr_reader :root
      def initialize(value)
        if value.is_a? Kaninchen::DataStructure::Node
          @root = value
        else
          @root = Kaninchen::DataStructure::Node.new value
        end
        @root.send(:set_tree_node_data, tree: self)
      end

      def each_node(type = :preorder)
        case type
        when :preorder
          yield self.root
          recursive_preorder_loop(self.root) { |node| yield node }
        end
      end

      def each_node_with_index(type = :preorder)
        case
        when (type === :preorder or type === :depth_first)
          yield self.root, 0
          index = 1
          recursive_preorder_loop(self.root) do |node|
            yield node, index
            index += 1
          end
        end
      end

      private

      def recursive_preorder_loop(parent_node)
        parent_node.children.each do |child_node|
          yield child_node
          recursive_preorder_loop(child_node) { |node| yield node }
        end
      end

    end

    class Node
      node_type :tree
      tree_node_attr_reader :tree, :parent, :children

      def <<(params)
        case
        when (params.is_a?(Kaninchen::DataStructure::Node) and params.nil?)
          params.send(:set_tree_node_data, tree: self.tree, parent: self)
          set_tree_node_data(children: @children.push(params))
        when params.is_a?(Array) then params.each { |node| self << node }
        when params.is_a?(Hash)
          params.each_pair do |key, value|
            self << key
            key << value if key.is_a? Kaninchen::DataStructure::Node
          end
        end
        self
      end

      def root?
        @parent.nil?
      end

      private

      def set_tree_node_data(params)
        @type     = :tree
        @tree     ||= params[:tree]
        @parent   ||= params[:parent]
        @children ||= params[:children] || []
      end
    end
  end
end