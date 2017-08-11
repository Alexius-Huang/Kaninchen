# frozen_string_literal: true

module Kaninchen
  module DataStructure
    class Node
      attr_reader :type, :value
      def initialize(params = {})
        if params.is_a? Hash
          @type  = params[:type]
          @value = params[:value]
        else
          @value = params
          @type  = nil
        end
      end

      def nil?
        @type.nil?
      end

      def to_s
        case @type
        when nil
          "<NilNode value=\"#{value}\">"
        when :tree
          "<TreeNode value=\"#{value}\" depth=\"#{depth}\" level=\"#{level}\" degree=\"#{degree}\">"
        end
      end
      alias :inspect :to_s

      class << self
        def node_type(type)
          define_method "#{type}_node?" do
            @type === type
          end

          define_singleton_method "#{type}_node_attr_reader" do |*attrs|
            attrs.each do |attr|
              define_method attr do
                send("#{type}_node?") ? instance_variable_get("@#{attr}") : nil
              end
            end
          end
        end
      end
    end
  end
end
