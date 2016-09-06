# frozen_string_literal: true

module FriendlyRoutes
  class Route
    attr_accessor :method, :params, :prefix

    def initialize(prefix: 'friendly_routes')
      @params = []
      @prefix = prefix
    end

    def path
      FriendlyRoutes::PrefixedParams.new(@params, @prefix).call
    end

    def constraints
      FriendlyRoutes::Constraints.new(dynamic_params, @prefix).call
    end

    def dynamic_params
      @params.select { |param| param.is_a?(FriendlyRoutes::Params::Base) }
    end

    def inspect
      dynamic_params.map(&:name).join(', ')
    end
  end
end
