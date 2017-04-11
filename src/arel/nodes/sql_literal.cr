# frozen_string_literal: true
require "../expressions"
require "../predications"
require "../alias_predication"
require "../order_predications"
module Arel
  module Nodes
    # TODO: Replace String inheritence
    class SqlLiteral # < String
      include Arel::Expressions
      include Arel::Predications
      include Arel::AliasPredication
      include Arel::OrderPredications

      def encode_with(coder)
        coder.scalar = self.to_s
      end
    end
  end
end
