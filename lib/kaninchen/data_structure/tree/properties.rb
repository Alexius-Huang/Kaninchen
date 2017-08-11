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

      def path
        node = self
        arr = [node]
        until node.root?
          node = node.parent
          arr << node
        end
        arr
      end

      def left_child
        self.degree.zero? ? nil : self.children[0]
      end

      def right_child
        self.degree < 2 ? nil : self.children[1]
      end

      def depth
        count = 0
        current_node = self
        until current_node.root?
          count += 1
          current_node = current_node.parent          
        end
        count
      end

      def level
        depth + 1
      end

      def subtree
        tree = Kaninchen::DataStructure::Tree.new(self.value)
        recursive_attach_subtree_nodes(tree.root, self)
        tree
      end

      def height
        self.subtree.height
      end

      def leaf?
        self.children.empty?
      end

      private

      def recursive_attach_subtree_nodes(new_node, origin_node)
        origin_node.children.each do |origin_child_node|
          new_child_node = self.class.new(origin_child_node.value)
          new_node << new_child_node
          recursive_attach_subtree_nodes(new_child_node, origin_child_node)
        end
      end

      # Right children is for the n-ary but not for the binary-tree system
      # which will be served as private method due to the needs of the
      # implementation of traversal
      def right_children
        self.degree < 2 ? [] : self.children[1..-1]
      end

      def left_most_child(node = self)
        node = node.left_child until node.left_child.nil?
        node
      end
    end
  end
end
