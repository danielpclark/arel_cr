# frozen_string_literal: true
require "./to_sql"
module Arel
  module Visitors
    class IBM_DB < Arel::Visitors::ToSql

      private def visit_Arel_Nodes_Limit(o, collector)
        collector << "FETCH FIRST "
        collector = visit o.expr, collector
        collector << " ROWS ONLY"
      end

    end
  end
end
