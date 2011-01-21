require File.dirname(__FILE__) + '/../spec_helper'

describe DatabaseValidation do

  before(:all) do
    execute 'create table length1s (id int(11) auto_increment primary key, name varchar(10))'
    execute 'create table length2s (id int(11) auto_increment primary key, body text)'
  end

  before(:all) do
    class Length1 < ActiveRecord::Base
      include DatabaseValidation
    end
 end

  after(:all) do
    execute 'drop table length1s'
    execute 'drop table length2s'
  end

  it 'should be able to automatically detect validations' do
    lambda do
      Length1.create!(:name => 'this name is too long')
    end.should raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should work fine with a text field that has no limit' do
    lambda do
      class Length2 < ActiveRecord::Base
        include DatabaseValidation
      end
    end.should_not raise_error(ArgumentError)

  end

end
