# encoding: utf-8

module Mutant
  class Killer

    # A killer that executes other killer in threaded environemnts
    class Threading < self
      include Equalizer.new(:killer)

      # Return killer
      #
      # @return [Killer]
      #
      # @api private
      #
      attr_reader :killer

      # Initalize killer
      #
      # @param [Killer] killer
      #   the killer that will be used
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(killer)
        @killer = killer
      end

      # Return killer instance
      #
      # @param [Strategy] strategy
      # @param [Mutation] mutation
      #
      # @return [Killer::Threaded]
      #
      # @api private
      #
      def new(strategy, mutation)
        Threaded.new(killer, strategy, mutation)
      end

    end # Threading
  end # Killer
end # Mutant
