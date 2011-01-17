require "active_record"

module DatabaseValidation
  module ClassMethods
    def detect_validations
      add_check_for_presence_length_and_belongs_to
      add_check_for_uniqueness
    end

    private
    def add_check_for_presence_length_and_belongs_to
      self.columns.each do |field|
        next if field.name == self.primary_key # don"t add validations here
        allow_nil = field.null
        limit = field.limit
        self.send(:validates_length_of, field.name.to_sym, :maximum => limit, :allow_nil => allow_nil) if (limit && limit > 0)
        self.send(:validates_presence_of, field.name.to_sym) unless allow_nil

        if field.name =~ %r%^(.*)_id%
          field_association = $1.to_sym
          self.send(:belongs_to, field_association)
        end
      end
    end

    def add_check_for_uniqueness
      ActiveRecord::Base.connection.indexes(self.table_name).each do |key|
        col_syms = key.columns.map(&:to_sym)
        self.send(:validates_uniqueness_of, col_syms.first.to_sym, :scope => col_syms.slice(1, -1)) if key.unique
      end
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.detect_validations
  end
end
