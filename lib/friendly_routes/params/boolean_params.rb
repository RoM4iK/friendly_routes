# frozen_string_literal: true

module FriendlyRoutes
  module Params
    # @attr [String] true value for matching true
    # @attr [String] false value for matching false
    class BooleanParams < Base
      attr_accessor :true, :false

      def initialize(name, options, optional: true)
        check_params(options)
        super(:boolean, name, optional)
        @true = options[:true]
        @false = options[:false]
      end

      def constraints
        Regexp.new "#{@true}|#{@false}"
      end

      # (see Base#parse)
      # @param [String] value request value
      # @return [Boolean]
      def parse(value)
        (value == @true).to_s
      end

      # (see Base#compose)
      # @param [Boolean, String] value boolean, or "True"/"False" strings
      # @return [String] request value
      def compose(value)
        value == true || value == 'true' ? @true : @false
      end

      # (see Base#allowed?)
      # @param [Boolean, String] value boolean, or "True"/"False" strings
      # @return [Boolean]
      def allowed?(value)
        [true, false, 'true', 'false'].include? value
      end

      private

      def check_params(options)
        valid = options.is_a?(Hash) && options[:true] && options[:false]
        raise ArgumentError, 'True and false options is required' unless valid
      end
    end
  end
end
