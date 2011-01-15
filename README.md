## DatabaseValidation

We write a lot of validations in our ActiveRecord models that already exist inside of our database.  This gem seeks to automatically create those validations.

### Usage

    class Thing < ActiveRecord::Base
      include DatabaseValidation
    end

### What's automatically created

For now:

* validates_uniquness_of (with scope)
* validates_presence_of 
* validates_length_of :maximum

In the future:

* all associations

### Installation

    gem 'database_validation'

### Author

John Crepezzi <john.crepezzi@gmail.com>
