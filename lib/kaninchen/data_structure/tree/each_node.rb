# frozen_string_literal: true

module Kaninchen
  module DataStructure
    class Tree
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
  end
end
