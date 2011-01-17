require "active_record"

module DatabaseValidation
  def self.included(base)
    @base = base
    Detector.detect_validations(@base)
  end

  # tested with "mysql" and "mysql2" adapters
  module Detector
    def self.detect_validations(base)
      base.columns.each do |field|
        next if field.name == base.primary_key # don"t add validations here
        allow_nil = field.null
        limit = field.limit
        base.send(:validates_length_of, field.name.to_sym, :maximum => limit, :allow_nil => allow_nil) if (limit && limit > 0)
        base.send(:validates_presence_of, field.name.to_sym) unless allow_nil

        if field.name =~ %r%^(.*)_id%
          field_association = $1
          base.send(:belongs_to, field_association)
        end

      end
      ActiveRecord::Base.connection.indexes(base.table_name).each do |key|
        col_syms = key.columns.map(&:to_sym)
        base.send(:validates_uniqueness_of, col_syms.first.to_sym, :scope => col_syms.slice(1, -1)) if key.unique
      end
    end
  end
end
