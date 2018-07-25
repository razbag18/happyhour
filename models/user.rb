class User < ActiveRecord::Base
  has_secure_password
  # belongs_to :special
  # GIVES ME A METHOD, PASSWORD, THAT ALLOWS ME TO CREATE PASSWORD
  # add a method - password
  # add another method - authenticate
end