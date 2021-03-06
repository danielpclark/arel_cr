# frozen_string_literal: true
require "./binary"
require "../expressions"
require "../predications"
require "../order_predications"
require "../alias_predication"
require "../math"
module Arel
  module Nodes

    class InfixOperation < Binary
      include Arel::Expressions
      include Arel::Predications
      include Arel::OrderPredications
      include Arel::AliasPredication
      include Arel::Math

      getter :operator

      def initialize(operator, left, right)
        super(left, right)
        @operator = operator
      end
    end

    class Multiplication < InfixOperation
      def initialize(left, right)
        super(:*, left, right)
      end
    end

    class Division < InfixOperation
      def initialize(left, right)
        super(:/, left, right)
      end
    end

    class Addition < InfixOperation
      def initialize(left, right)
        super(:+, left, right)
      end
    end

    class Subtraction < InfixOperation
      def initialize(left, right)
        super(:-, left, right)
      end
    end

    class Concat < InfixOperation
      def initialize(left, right)
        super("||", left, right)
      end
    end

    class BitwiseAnd < InfixOperation
      def initialize(left, right)
        super(:&, left, right)
      end
    end

    class BitwiseOr < InfixOperation
      def initialize(left, right)
        super(:|, left, right)
      end
    end

    class BitwiseXor < InfixOperation
      def initialize(left, right)
        super(:^, left, right)
      end
    end

    class BitwiseShiftLeft < InfixOperation
      def initialize(left, right)
        super(:<<, left, right)
      end
    end

    class BitwiseShiftRight < InfixOperation
      def initialize(left, right)
        super(:>>, left, right)
      end
    end
  end
end
