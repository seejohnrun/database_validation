require File.dirname(__FILE__) + '/../spec_helper'

describe DatabaseValidation do

  before(:all) do
    execute 'create table presence1s (id int(11) auto_increment primary key, name varchar(10) NOT NULL, enabled tinyint(1) NOT NULL)'
  end

  before(:all) do
    class Presence1 < ActiveRecord::Base
      include DatabaseValidation
    end
  end

  after(:all) do
    execute 'drop table presence1s'
  end

  it 'should be automatically able to detect null validations' do
    lambda do
      Presence1.create!
    end.should raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should be able to save a false value for a boolean' do
    lambda do
      Presence1.create!(:enabled => false)
    end
  end

end
