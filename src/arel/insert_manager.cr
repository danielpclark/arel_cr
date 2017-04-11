# frozen_string_literal: true
require "./tree_manager"
module Arel
  class InsertManager < Arel::TreeManager
    def initialize
      super
      @ast = Nodes::InsertStatement.new
    end

    def into(table)
      @ast.relation = table
      self
    end

    def columns; @ast.columns end
    def values=(val); @ast.values = val; end

    def select(_select) # WARNING!! TODO: Keyword!
      @ast.select = _select
    end

    def insert(fields)
      return if fields.empty?

      if String === fields
        @ast.values = Nodes::SqlLiteral.new(fields)
      else
        @ast.relation ||= fields.first.first.relation

        values = [] of U # TODO: Determine Kinds

        fields.each do |column, value|
          @ast.columns << column
          values << value
        end
        @ast.values = create_values values, @ast.columns
      end
      self
    end

    def create_values(values, columns)
      Nodes::Values.new values, columns
    end
  end
end
