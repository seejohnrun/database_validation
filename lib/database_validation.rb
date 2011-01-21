require 'active_record'

module DatabaseValidation

  def self.included(base)
    @base = base
    Detector.detect_validations(@base)
  end

  # tested with 'mysql' and 'mysql2' adapters
  module Detector

    def self.detect_validations(base)
      base.columns.each do |field|
        next if field.name == base.primary_key # don't add validations here
        allow_nil = field.null
        
        base.send(:validates_presence_of, field.name.to_sym, :allow_nil => allow_nil) unless allow_nil
        next if field.limit.nil?

        if [:integer, :float].include?(field.type)
          unsigned = field.sql_type.include?('unsigned')
          maximum = unsigned ? 2 ** (8 * field.limit) : 2 ** (8 * field.limit) / 2
          minimum = unsigned ? -(2 ** (8 * field.limit)) - 1 : -(2 ** (8 * field.limit) / 2) - 1
          base.send(:validates_numericality_of, field.name.to_sym, :less_than => maximum, :greater_than => minimum, :allow_nil => allow_nil)
        else
          maximum = field.limit
          base.send(:validates_length_of, field.name.to_sym, :maximum => maximum, :allow_nil => allow_nil)
        end

      end
      ActiveRecord::Base.connection.indexes(base.table_name).each do |key|
        col_syms = key.columns.map(&:to_sym)
        base.send(:validates_uniqueness_of, col_syms.first.to_sym, :scope => col_syms.slice(1, -1)) if key.unique
      end
    end

  end

end
