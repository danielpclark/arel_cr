# frozen_string_literal: true
require "./node"
module Arel
  module Nodes
    class SelectStatement < Arel::Nodes::Node
      getter :cores
      property :limit, :orders, :lock, :offset, :with

      def initialize(cores = [SelectCore.new])
        super()
        @cores          = cores
        @orders         = [] of U # TODO: Determine Types!
        @limit          = nil : Nil | Arel::Nodes::SelectStatement
        @lock           = nil : Nil | Arel::Nodes::SelectStatement
        @offset         = nil : Nil | Arel::Nodes::SelectStatement
        @with           = nil : Nil | Arel::Nodes::SelectStatement
      end

      def initialize_copy(other)
        super
        @cores  = @cores.map { |x| x.clone }
        @orders = @orders.map { |x| x.clone }
      end

      def hash
        [@cores, @orders, @limit, @lock, @offset, @with].hash
      end

      def eql?(other)
        self.class == other.class &&
          self.cores == other.cores &&
          self.orders == other.orders &&
          self.limit == other.limit &&
          self.lock == other.lock &&
          self.offset == other.offset &&
          self.with == other.with
      end
      def ==(*args); eql?(*args) end
    end
  end
end
