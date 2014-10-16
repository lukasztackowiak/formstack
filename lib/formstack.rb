require 'httparty'
require 'hashie'

require 'formstack/client'
require 'formstack/version'

module Formstack

  class FormstackError < StandardError
    attr_reader :data

    def initialize(data)
      @data = data
      super
    end
  end

end