# frozen_string_literal: true

module Kaninchen
  module DataStructure
    class Tree
      def leaves
        self.nodes(:preorder).select { |node| node.children.empty? }
      end

      def height
        self.nodes(:preorder).map do |node|
          count = 1
          until node.parent.nil?
            count += 1
            node = node.parent
          end
          count
        end.max
      end

      private

      def first_leaf
        self.each_node(:preorder) { |node| return node if node.children.empty? }
      end
    end

    class Node
      def degree
        self.children.size
      end

      def depth
        count = 1
        current_node = self
        until current_node.root?
          count += 1
          current_node = current_node.parent          
        end
        count
      end

      def subtree
        tree = Kaninchen::DataStructure::Tree.new(self.value)
        recursive_attach_subtree_nodes(tree.root, self)
        tree
      end

      def height
        self.subtree.height
      end

      private

      def recursive_attach_subtree_nodes(new_node, origin_node)
        origin_node.children.each do |origin_child_node|
          new_child_node = self.class.new(origin_child_node.value)
          new_node << new_child_node
          recursive_attach_subtree_nodes(new_child_node, origin_child_node)
        end
      end
    end
  end
end
