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
        end
      end
    end
  end
end