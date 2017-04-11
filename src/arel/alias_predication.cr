# frozen_string_literal: true
module Arel
  module AliasPredication
    def _as(other)
      Nodes::As.new self, Nodes::SqlLiteral.new(other)
    end
  end
end
