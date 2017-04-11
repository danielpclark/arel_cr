# frozen_string_literal: true
require "./node"
module Arel
  module Nodes
    class UpdateStatement < Arel::Nodes::Node
      property :relation, :wheres, :values, :orders, :limit
      property :key

      def initialize
        @relation = nil : Nil | Arel::Nodes::UpdateStatement
        @wheres   = [] of U # TODO: Determine Types!
        @values   = [] of U # TODO: Determine Types!
        @orders   = [] of U # TODO: Determine Types!
        @limit    = nil : Nil | Arel::Nodes::UpdateStatement
        @key      = nil : Nil | Arel::Nodes::UpdateStatement
      end

      def initialize_copy(other)
        super
        @wheres = @wheres.clone
        @values = @values.clone
      end

      def hash
        [@relation, @wheres, @values, @orders, @limit, @key].hash
      end

      def eql?(other)
        self.class == other.class &&
          self.relation == other.relation &&
          self.wheres == other.wheres &&
          self.values == other.values &&
          self.orders == other.orders &&
          self.limit == other.limit &&
          self.key == other.key
      end
      private def ==(o) ; eql?(o) end
    end
  end
end
