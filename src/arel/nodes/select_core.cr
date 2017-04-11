# frozen_string_literal: true
require "./node"
module Arel
  module Nodes
    class SelectCore < Arel::Nodes::Node
      property :top, :projections, :wheres, :groups, :windows
      property :havings, :source, :set_quantifier

      def initialize
        super()
        @source         = JoinSource.new nil
        @top            = nil : Nil | Arel::Nodes::SelectCore

        # http://savage.net.au/SQL/sql-92.bnf.html#set%20quantifier
        @set_quantifier = nil : Nil | Arel::Nodes::SelectCore
        @projections    = [] of U # TODO: Figure Types! 
        @wheres         = [] of U # TODO: Figure Types!
        @groups         = [] of U # TODO: Figure Types!
        @havings        = [] of U # TODO: Figure Types!
        @windows        = [] of U # TODO: Figure Types!
      end

      def from
        @source.left
      end

      def from=(value)
        @source.left = value
      end

      def froms=(v) ; from= v end
      def froms     ; from    end

      def initialize_copy(other)
        super
        @source      = @source.clone if @source
        @projections = @projections.clone
        @wheres      = @wheres.clone
        @groups      = @groups.clone
        @havings     = @havings.clone
        @windows     = @windows.clone
      end

      def hash
        [
          @source, @top, @set_quantifier, @projections,
          @wheres, @groups, @havings, @windows
        ].hash
      end

      def eql?(other)
        self.class == other.class &&
          self.source == other.source &&
          self.top == other.top &&
          self.set_quantifier == other.set_quantifier &&
          self.projections == other.projections &&
          self.wheres == other.wheres &&
          self.groups == other.groups &&
          self.havings == other.havings &&
          self.windows == other.windows
      end
      def ==(other) ; eql? other end
    end
  end
end
