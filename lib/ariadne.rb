require 'ariadne/version'
require 'ariadne/ariadne_util'
module Ariadne
  class << self
    attr_writer :logger

    def logger
      @logger ||= Logger.new('log/ariadne.log').tap do |log|
        log.progname = self.name
        log.level = :error
      end
    end
  end
end