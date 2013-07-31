# encoding: utf-8

module Mutant
  class Killer

    # Killer that executes other killer in a thread
    class Threaded < self

      # Initialize object
      #
      # @param [Killer] killer
      # @param [Strategy] strategy
      # @param [Mutation] mutation
      #
      # @api private
      #
      def initialize(killer, strategy, mutation)
        @killer = killer
        super(strategy, mutation)
      end

    private

      # Run killer
      #
      # @return [true]
      #   if mutant was killed
      #
      # @return [false]
      #   otherwise
      #
      # @api private
      #
      def run
        killer = nil
        th = ::Thread.new do
          killer = @killer.new(strategy, mutation)
        end

        status = th.join
        !status.nil? && killer.killed?
      end

    end # Threaded
  end # Killer
end # Mutant
