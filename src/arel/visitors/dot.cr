# frozen_string_literal: true
require "./visitor"
module Arel
  module Visitors
    class Dot < Arel::Visitors::Visitor
      class Node # :nodoc:
        property :name, :id, :fields

        def initialize(name, id, fields = [] of U) # TODO: Determine Types
          @name   = name
          @id     = id
          @fields = fields
        end
      end

      class Edge # :nodoc:
        ###################################
        # Instead of inheriting from Struct
        property :name, :from, :to 
        include Enumerable(Nil) # TODO: Determine Types (if any)
        ###################################
      end

      def initialize
        super()
        @nodes      = [] of U # TODO: Determine Types
        @edges      = [] of U # TODO: Determine Types
        @node_stack = [] of U # TODO: Determine Types
        @edge_stack = [] of U # TODO: Determine Types
        @seen       = {} of U => U # TODO: Determine Types
      end

      def accept(object, collector)
        visit object
        collector << to_dot
      end

      private def visit_Arel_Nodes_Ordering(o)
        visit_edge o, "expr"
      end

      private def visit_Arel_Nodes_TableAlias(o)
        visit_edge o, "name"
        visit_edge o, "relation"
      end

      private def visit_Arel_Nodes_Count(o)
        visit_edge o, "expressions"
        visit_edge o, "distinct"
      end

      private def visit_Arel_Nodes_Values(o)
        visit_edge o, "expressions"
      end

      private def visit_Arel_Nodes_StringJoin(o)
        visit_edge o, "left"
      end

      private def visit_Arel_Nodes_InnerJoin(o)
        visit_edge o, "left"
        visit_edge o, "right"
      end
      private def visit_Arel_Nodes_FullOuterJoin  ;visit_Arel_Nodes_InnerJoin end
      private def visit_Arel_Nodes_OuterJoin      ;visit_Arel_Nodes_InnerJoin end
      private def visit_Arel_Nodes_RightOuterJoin ;visit_Arel_Nodes_InnerJoin end

      private def visit_Arel_Nodes_DeleteStatement(o)
        visit_edge o, "relation"
        visit_edge o, "wheres"
      end

      private def unary(o)
        visit_edge o, "expr"
      end
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
      private def visit_Arel_Nodes_Top               ;unary end
      private def visit_Arel_Nodes_UnqualifiedColumn ;unary end
      private def visit_Arel_Nodes_Preceding         ;unary end
      private def visit_Arel_Nodes_Following         ;unary end
      private def visit_Arel_Nodes_Rows              ;unary end
      private def visit_Arel_Nodes_Range             ;unary end

      private def window(o)
        visit_edge o, "partitions"
        visit_edge o, "orders"
        visit_edge o, "framing"
      end
      private def visit_Arel_Nodes_Window            ;window end

      private def named_window(o)
        visit_edge o, "partitions"
        visit_edge o, "orders"
        visit_edge o, "framing"
        visit_edge o, "name"
      end
      private def visit_Arel_Nodes_NamedWindow       ;named_window end

      private def function(o)
        visit_edge o, "expressions"
        visit_edge o, "distinct"
        visit_edge o, "alias"
      end
      private def visit_Arel_Nodes_Exists ;function end
      private def visit_Arel_Nodes_Min    ;function end
      private def visit_Arel_Nodes_Max    ;function end
      private def visit_Arel_Nodes_Avg    ;function end
      private def visit_Arel_Nodes_Sum    ;function end

      private def extract(o)
        visit_edge o, "expressions"
        visit_edge o, "alias"
      end
      private def visit_Arel_Nodes_Extract ;extract end

      private def visit_Arel_Nodes_NamedFunction(o)
        visit_edge o, "name"
        visit_edge o, "expressions"
        visit_edge o, "distinct"
        visit_edge o, "alias"
      end

      private def visit_Arel_Nodes_InsertStatement(o)
        visit_edge o, "relation"
        visit_edge o, "columns"
        visit_edge o, "values"
      end

      private def visit_Arel_Nodes_SelectCore(o)
        visit_edge o, "source"
        visit_edge o, "projections"
        visit_edge o, "wheres"
        visit_edge o,  "windows"
      end

      private def visit_Arel_Nodes_SelectStatement(o)
        visit_edge o, "cores"
        visit_edge o, "limit"
        visit_edge o, "orders"
        visit_edge o, "offset"
      end

      private def visit_Arel_Nodes_UpdateStatement(o)
        visit_edge o, "relation"
        visit_edge o, "wheres"
        visit_edge o, "values"
      end

      private def visit_Arel_Table(o)
        visit_edge o, "name"
      end

      private def visit_Arel_Nodes_Casted(o)
        visit_edge o, "val"
        visit_edge o, "attribute"
      end

      private def visit_Arel_Attribute(o)
        visit_edge o, "relation"
        visit_edge o, "name"
      end
      private def visit_Arel_Attributes_Integer   ;visit_Arel_Attribute end 
      private def visit_Arel_Attributes_Float     ;visit_Arel_Attribute end
      private def visit_Arel_Attributes_String    ;visit_Arel_Attribute end
      private def visit_Arel_Attributes_Time      ;visit_Arel_Attribute end
      private def visit_Arel_Attributes_Boolean   ;visit_Arel_Attribute end
      private def visit_Arel_Attributes_Attribute ;visit_Arel_Attribute end

      private def nary(o)
        o.children.each_with_index do |x,i|
          edge(i) { visit x }
        end
      end
      private def visit_Arel_Nodes_And ;nary end

      private def binary(o)
        visit_edge o, "left"
        visit_edge o, "right"
      end
      private def visit_Arel_Nodes_As                 ;binary end 
      private def visit_Arel_Nodes_Assignment         ;binary end
      private def visit_Arel_Nodes_Between            ;binary end
      private def visit_Arel_Nodes_Concat             ;binary end
      private def visit_Arel_Nodes_DoesNotMatch       ;binary end
      private def visit_Arel_Nodes_Equality           ;binary end
      private def visit_Arel_Nodes_GreaterThan        ;binary end
      private def visit_Arel_Nodes_GreaterThanOrEqual ;binary end
      private def visit_Arel_Nodes_In                 ;binary end
      private def visit_Arel_Nodes_JoinSource         ;binary end
      private def visit_Arel_Nodes_LessThan           ;binary end
      private def visit_Arel_Nodes_LessThanOrEqual    ;binary end
      private def visit_Arel_Nodes_Matches            ;binary end
      private def visit_Arel_Nodes_NotEqual           ;binary end
      private def visit_Arel_Nodes_NotIn              ;binary end
      private def visit_Arel_Nodes_Or                 ;binary end
      private def visit_Arel_Nodes_Over               ;binary end

      private def visit_String(o)
        @node_stack.last.fields << o
      end
      private def visit_Time                  ;visit_String end
      private def visit_Date                  ;visit_String end 
      private def visit_DateTime              ;visit_String end
      private def visit_NilClass              ;visit_String end
      private def visit_TrueClass             ;visit_String end
      private def visit_FalseClass            ;visit_String end
      private def visit_Integer               ;visit_String end
      private def visit_Fixnum                ;visit_String end
      private def visit_BigDecimal            ;visit_String end
      private def visit_Float                 ;visit_String end
      private def visit_Symbol                ;visit_String end
      private def visit_Arel_Nodes_SqlLiteral ;visit_String end

      private def visit_Arel_Nodes_BindParam(o); end

      private def visit_Hash(o)
        o.each_with_index do |pair, i|
          edge("pair_#{i}")   { visit pair }
        end
      end

      private def visit_Array(o)
        o.each_with_index do |x,i|
          edge(i) { visit x }
        end
      end
      private def visit_Set ;visit_Array end

      private def visit_edge(o, method)
        edge(method) { visit o.send(method) }
      end

      private def visit(o)
        if node = @seen[o.object_id]
          @edge_stack.last.to = node
          return
        end

        node = Node.new(o.class.name, o.object_id)
        @seen[node.id] = node
        @nodes << node
        with_node node do
          super
        end
      end

      private def edge(name)
        edge = Edge.new(name, @node_stack.last)
        @edge_stack.push edge
        @edges << edge
        yield
        @edge_stack.pop
      end

      private def with_node(node)
        if edge = @edge_stack.last
          edge.to = node
        end

        @node_stack.push node
        yield
        @node_stack.pop
      end

      private def quote(string)
        string.to_s.gsub(%("), %(\"))
      end

      private def to_dot
        "digraph \"Arel\" {\nnode [width=0.375,height=0.25,shape=record];\n" +
          @nodes.map { |node|
            label = "<f0>#{node.name}"

            node.fields.each_with_index do |field, i|
              label += "|<f#{i + 1}>#{quote field}"
            end

            "#{node.id} [label=\"#{label}\"];"
          }.join("\n") + "\n" + @edges.map { |edge|
            "#{edge.from.id} -> #{edge.to.id} [label=\"#{edge.name}\"];"
          }.join("\n") + "\n}"
      end
    end
  end
end
