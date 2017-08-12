# frozen_string_literal: true

require 'kaninchen/data_structure/stack'
require 'kaninchen/data_structure/queue'
require 'kaninchen/data_structure/node'
require 'kaninchen/data_structure/tree'
require 'kaninchen/data_structure/set'

module Kaninchen
  module DataStructure
    def self.enable_extension!
      require 'kaninchen/data_structure/extension'
    end
  end
end
