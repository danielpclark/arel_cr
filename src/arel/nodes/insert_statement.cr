# frozen_string_literal: true
require "./node"
module Arel
  module Nodes
    class InsertStatement < Arel::Nodes::Node
      property :relation, :columns, :values, :_select

      def initialize
        super()
        @relation = nil : Nil | Arel::Nodes::InsertStatement
        @columns  = [] of U # TODO: Determine Types!
        @values   = nil : Nil | Arel::Nodes::InsertStatement
        @_select   = nil : Nil | Arel::Nodes::InsertStatement
      end

      def initialize_copy(other)
        super
        @columns = @columns.clone
        @values =  @values.clone if @values
        @_select =  @_select.clone if @_select
      end

      def hash
        [@relation, @columns, @values, @_select].hash
      end

      def eql?(other)
        self.class == other.class &&
          self.relation == other.relation &&
          self.columns == other.columns &&
          self._select == other._select &&
          self.values == other.values
      end
      private def ==(o); eql? o end
    end
  end
end
