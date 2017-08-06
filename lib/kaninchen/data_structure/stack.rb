# frozen_string_literal: true

module Kaninchen
  module DataStructure
    class Stack
      def initialize(*items)
        @stack ||= items
      end

      def push(item)
        @stack.push item
        self
      end
      alias :<< :push

      def pop
       @stack.pop
      end

      def pop!
        popped = self.pop
        raise Kaninchen::PopEmptyStackError, 'Popping out empty stack' if popped.nil?
        popped
      end

      def empty?
        @stack.size.zero?
      end

      def size
        @stack.size
      end
    end
  end
end
