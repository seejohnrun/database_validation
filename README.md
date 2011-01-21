## DatabaseValidation

We write a lot of validations in our ActiveRecord models that already exist inside of our database.  This gem automatically creates those validations.

### Usage

We need more tools that use tools we already have

    class Thing < ActiveRecord::Base
      include DatabaseValidation
    end

### What's automatically created

For now:

* validates_uniquness_of (with scope)
* validates_presence_of
* validates_length_of :maximum, :allow_nil
* validates_numericality_of :greater_than, :less_than, :allow_nil

In the future:

* all associations

### Tested Adapters (probably others)

* mysql
* mysql2

### Installation

    # in your Gemfile
    gem 'database_validation'

### Author

John Crepezzi <john.crepezzi@gmail.com>
