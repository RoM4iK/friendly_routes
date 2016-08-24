# frozen_string_literal: true
require 'rails_helper'

module FriendlyRoutes
  describe Route do
    before do
      @controller = double('ItemsController')
    end
    describe '#initialize' do
      before do
        @method = 'get'
        @path = '/'
        @action = 'index'
        @to = 'items#index'
        stub_const('ItemsController', @controller)
      end

      def call
        Route.new(@method, @path, @to)
      end

      describe 'should set instance variables' do
        [:method, :path, :controller, :action].each do |variable|
          describe(variable) do
            let(:subject) { call.public_send(variable) }
            let(:value) { instance_variable_get("@#{variable}") }
            it { is_expected.to eq(value) }
          end
        end
      end
    end
  end
end