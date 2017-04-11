# frozen_string_literal: true
require "./visitor"
module Arel
  module Visitors
    class DepthFirst < Arel::Visitors::Visitor
      def initialize(block : Arel::Visitors::DepthFirst? | Proc(Nil) = nil)
        @block = block || Proc.new
        super()
      end

      private def visit(o)
        super
        @block.call o
      end

      private def unary(o)
        visit o.expr
      end
      private def visit_Arel_Nodes_Else              ;unary end
      private def visit_Arel_Nodes_Group             ;unary end
      private def visit_Arel_Nodes_Cube              ;unary end
      private def visit_Arel_Nodes_RollUp            ;unary end
      private def visit_Arel_Nodes_GroupingSet       ;unary end
      private def visit_Arel_Nodes_GroupingElement   ;unary end
      private def visit_Arel_Nodes_Grouping          ;unary end
      private def visit_Arel_Nodes_Having            ;unary end
      private def visit_Arel_Nodes_Limit             ;unary end
      private def visit_Arel_Nodes_Not               ;unary end
      private def visit_Arel_Nodes_Offset            ;unary end
      private def visit_Arel_Nodes_On                ;unary end
      private def visit_Arel_Nodes_Ordering          ;unary end
      private def visit_Arel_Nodes_Ascending         ;unary end
      private def visit_Arel_Nodes_Descending        ;unary end
      private def visit_Arel_Nodes_Top               ;unary end
      private def visit_Arel_Nodes_UnqualifiedColumn ;unary end

      private def function(o)
        visit o.expressions
        visit o.alias
        visit o.distinct
      end
      private def visit_Arel_Nodes_Avg    ;function end
      private def visit_Arel_Nodes_Exists ;function end
      private def visit_Arel_Nodes_Max    ;function end
      private def visit_Arel_Nodes_Min    ;function end
      private def visit_Arel_Nodes_Sum    ;function end

      private def visit_Arel_Nodes_NamedFunction(o)
        visit o.name
        visit o.expressions
        visit o.distinct
        visit o.alias
      end

      private def visit_Arel_Nodes_Count(o)
        visit o.expressions
        visit o.alias
        visit o.distinct
      end

      private def visit_Arel_Nodes_Case(o)
        visit o.case
        visit o.conditions
        visit o.default
      end

      private def nary(o)
        o.children.each { |child| visit child}
      end
      private def visit_Arel_Nodes_And ;nary end

      private def binary(o)
        visit o.left
        visit o.right
      end
      private def visit_Arel_Nodes_As                 ;binary end
      private def visit_Arel_Nodes_Assignment         ;binary end
      private def visit_Arel_Nodes_Between            ;binary end
      private def visit_Arel_Nodes_Concat             ;binary end
      private def visit_Arel_Nodes_DeleteStatement    ;binary end
      private def visit_Arel_Nodes_DoesNotMatch       ;binary end
      private def visit_Arel_Nodes_Equality           ;binary end
      private def visit_Arel_Nodes_FullOuterJoin      ;binary end
      private def visit_Arel_Nodes_GreaterThan        ;binary end
      private def visit_Arel_Nodes_GreaterThanOrEqual ;binary end
      private def visit_Arel_Nodes_In                 ;binary end
      private def visit_Arel_Nodes_InfixOperation     ;binary end
      private def visit_Arel_Nodes_JoinSource         ;binary end
      private def visit_Arel_Nodes_InnerJoin          ;binary end
      private def visit_Arel_Nodes_LessThan           ;binary end
      private def visit_Arel_Nodes_LessThanOrEqual    ;binary end
      private def visit_Arel_Nodes_Matches            ;binary end
      private def visit_Arel_Nodes_NotEqual           ;binary end
      private def visit_Arel_Nodes_NotIn              ;binary end
      private def visit_Arel_Nodes_NotRegexp          ;binary end
      private def visit_Arel_Nodes_Or                 ;binary end
      private def visit_Arel_Nodes_OuterJoin          ;binary end
      private def visit_Arel_Nodes_Regexp             ;binary end
      private def visit_Arel_Nodes_RightOuterJoin     ;binary end
      private def visit_Arel_Nodes_TableAlias         ;binary end
      private def visit_Arel_Nodes_Values             ;binary end
      private def visit_Arel_Nodes_When               ;binary end

      private def visit_Arel_Nodes_StringJoin(o)
        visit o.left
      end

      private def visit_Arel_Attribute(o)
        visit o.relation
        visit o.name
      end
      private def visit_Arel_Attributes_Integer   ;visit_Arel_Attribute end
      private def visit_Arel_Attributes_Float     ;visit_Arel_Attribute end
      private def visit_Arel_Attributes_String    ;visit_Arel_Attribute end
      private def visit_Arel_Attributes_Time      ;visit_Arel_Attribute end
      private def visit_Arel_Attributes_Boolean   ;visit_Arel_Attribute end
      private def visit_Arel_Attributes_Attribute ;visit_Arel_Attribute end
      private def visit_Arel_Attributes_Decimal   ;visit_Arel_Attribute end

      private def visit_Arel_Table(o)
        visit o.name
      end

      private def terminal(o)
      end
      private def visit_ActiveSupport_Multibyte_Chars ;terminal end
      private def visit_ActiveSupport_StringInquirer  ;terminal end
      private def visit_Arel_Nodes_Lock               ;terminal end
      private def visit_Arel_Nodes_Node               ;terminal end
      private def visit_Arel_Nodes_SqlLiteral         ;terminal end
      private def visit_Arel_Nodes_BindParam          ;terminal end
      private def visit_Arel_Nodes_Window             ;terminal end
      private def visit_Arel_Nodes_True               ;terminal end
      private def visit_Arel_Nodes_False              ;terminal end
      private def visit_BigDecimal                    ;terminal end
      private def visit_Bignum                        ;terminal end
      private def visit_Class                         ;terminal end
      private def visit_Date                          ;terminal end
      private def visit_DateTime                      ;terminal end
      private def visit_FalseClass                    ;terminal end
      private def visit_Fixnum                        ;terminal end
      private def visit_Float                         ;terminal end
      private def visit_Integer                       ;terminal end
      private def visit_NilClass                      ;terminal end
      private def visit_String                        ;terminal end
      private def visit_Symbol                        ;terminal end
      private def visit_Time                          ;terminal end
      private def visit_TrueClass                     ;terminal end

      private def visit_Arel_Nodes_InsertStatement(o)
        visit o.relation
        visit o.columns
        visit o.values
      end

      private def visit_Arel_Nodes_SelectCore(o)
        visit o.projections
        visit o.source
        visit o.wheres
        visit o.groups
        visit o.windows
        visit o.havings
      end

      private def visit_Arel_Nodes_SelectStatement(o)
        visit o.cores
        visit o.orders
        visit o.limit
        visit o.lock
        visit o.offset
      end

      private def visit_Arel_Nodes_UpdateStatement(o)
        visit o.relation
        visit o.values
        visit o.wheres
        visit o.orders
        visit o.limit
      end

      private def visit_Array(o)
        o.each { |i| visit i }
      end
      private def visit_Set ;visit_Array end

      def visit_Hash(o)
        o.each { |k,v| visit(k); visit(v) }
      end

      DISPATCH = dispatch_cache

      def get_dispatch_cache
        DISPATCH
      end
    end
  end
end
