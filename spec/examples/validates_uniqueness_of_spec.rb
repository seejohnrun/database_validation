require File.dirname(__FILE__) + '/../spec_helper'

describe DatabaseValidation do

  before(:all) do
    execute 'create table unique1s (id int(11) auto_increment primary key, name varchar(10))'
    execute 'create unique index name_unique on unique1s (name)'
  end

  before(:all) do
    class Unique1 < ActiveRecord::Base
      include DatabaseValidation
    end
  end

  after(:all) do
    execute 'drop table unique1s'
  end

  it 'should not allow two of the same record when validates_uniqueness_of is around' do
    Unique1.create!(:name => 'john')
    lambda do
      Unique1.create!(:name => 'john')
    end.should raise_error(ActiveRecord::RecordInvalid)
  end

end

