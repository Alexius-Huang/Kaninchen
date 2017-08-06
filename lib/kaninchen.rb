require 'kaninchen/version'
require 'kaninchen/data_structure'
require 'kaninchen/algorithm'
require 'kaninchen/errors'

module Kaninchen
  class << self
    def version
      self::VERSION
    end
  end
end
