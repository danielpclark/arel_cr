# frozen_string_literal: true
require "./node"
require "../order_predications"
require "../predications"
require "../alias_predication"
require "./binary"
require "./unary"
module Arel
  module Nodes
    class Case < Arel::Nodes::Node
      include Arel::OrderPredications
      include Arel::Predications
      include Arel::AliasPredication

      property :case, :conditions, :default

      def initialize(expression = nil, default = nil)
        @case = expression : Nil | Arel::Nodes::Case
        @conditions = [] of U # TODO: Determine Types
        @default = default
      end

      def when(condition, expression = nil)
        @conditions << When.new(Nodes.build_quoted(condition), expression)
        self
      end

      def then(expression)
        @conditions.last.right = Nodes.build_quoted(expression)
        self
      end

      def else(expression)
        @default = Else.new Nodes.build_quoted(expression)
        self
      end

      def initialize_copy(other)
        super
        @case = @case.clone if @case
        @conditions = @conditions.map { |x| x.clone }
        @default = @default.clone if @default
      end

      def hash
        [@case, @conditions, @default].hash
      end

      def eql?(other)
        self.class == other.class &&
          self.case == other.case &&
          self.conditions == other.conditions &&
          self.default == other.default
      end
      def ==(o); eql? o end
    end

    class When < Binary # :nodoc:
    end

    class Else < Unary # :nodoc:
    end
  end
end
