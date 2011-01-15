require File.dirname(__FILE__) + '/../spec_helper'

describe DatabaseValidation do

  before(:all) do
    execute 'create table length1s (id int(11) auto_increment primary key, name varchar(10))'
  end

  before(:all) do
    class Length1 < ActiveRecord::Base
      include DatabaseValidation
    end
  end

  after(:all) do
    execute 'drop table length1s'
  end

  it 'should be able to automatically detect validations' do
    lambda do
      Length1.create!(:name => 'this name is too long')
    end.should raise_error(ActiveRecord::RecordInvalid)
  end

end
