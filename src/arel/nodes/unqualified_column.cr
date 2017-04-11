# frozen_string_literal: true
require "./unary"
module Arel
  module Nodes
    class UnqualifiedColumn < Arel::Nodes::Unary
      def attribute; expr end
      def attribute=(v); expr=v end

      def relation
        @expr.relation
      end

      def column
        @expr.column
      end

      def name
        @expr.name
      end
    end
  end
end
