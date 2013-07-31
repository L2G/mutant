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
        pid = fork do
          killer = @killer.new(strategy, mutation)
          exit(killer.killed? ? CLI::EXIT_SUCCESS : CLI::EXIT_FAILURE)
        end

        status = Process.wait2(pid).last
        status.exited? && status.success?
      end

    end # Threaded
  end # Killer
end # Mutant
