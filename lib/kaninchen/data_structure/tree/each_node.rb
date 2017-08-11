# frozen_string_literal: true

module Kaninchen
  module DataStructure
    class Tree
      def each_node(type = :preorder)
        case
        when %i[preorder depth_first].include?(type)
          yield self.root
          recursive_preorder_loop(self.root) { |node| yield node }
        when type === :inorder
          recursive_inorder_loop(first_leaf, :left_most) { |node| yield node }
        when %i[levelorder breadth_first].include?(type)
          yield self.root
          recursive_levelorder_loop(self.root) { |node| yield node }
        end
      end

      def each_node_with_index(type = :preorder)
        index = 0
        self.each_node(type) do |node|
          yield node, index
          index += 1
        end
      end

      private

      def recursive_preorder_loop(parent_node)
        parent_node.children.each do |child_node|
          yield child_node
          recursive_preorder_loop(child_node) { |node| yield node }
        end
      end

      def recursive_inorder_loop(node, current_role, end_node = nil)
        yield node
        case current_role
        when :left_most
          until node === end_node or node.root?
            recursive_inorder_loop(node.parent, :right_recursive, end_node) { |n| yield n } unless node.parent === end_node
            node = node.parent
          end
        when :right_recursive
          node.send(:right_children).each do |child_node|
            left_most_child = child_node.send(:left_most_child)
            recursive_inorder_loop(left_most_child, :left_most, end_node = node) { |n| yield n }
          end
        end
      end

      def recursive_levelorder_loop(node)
        children = node.children
        children.each { |child_node| yield child_node }
        children.each { |child_node| recursive_levelorder_loop(child_node) { |n| yield n } }
      end
    end
  end
end
