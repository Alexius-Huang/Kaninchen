# frozen_string_literal: true

module Kaninchen
  module DataStructure
    class Tree
      def nodes(type = nil)
        case type
        when nil then { self.root => recursive_get_struct(self.root) }
        end
      end

      def node_values(type = nil)
        case type
        when nil
          { self.root.value => recursive_get_struct_value(self.root) }
        end
      end

      private

      def recursive_get_struct(node)
        result = {}
        node.children.each do |child_node|
          result[child_node] = recursive_get_struct(child_node)
        end
        result.empty? ? nil : result 
      end

      def recursive_get_struct_value(node)
        result = {}
        node.children.each do |child_node|
          result[child_node.value] = recursive_get_struct_value(child_node)
        end
        result.empty? ? nil : result
      end
    end
  end
end
