require 'spec_helper'
require 'fortnox/api/repositories/contexts/environment'
require 'fortnox/api/repositories/customer'
require 'fortnox/api/repositories/examples/all'
require 'fortnox/api/repositories/examples/find'
require 'fortnox/api/repositories/examples/save'

describe Fortnox::API::Repository::Customer, order: :defined do
  include_context 'environment'

  include_examples '.save', :name

  # It is not yet possible to delete Customers. Therefore, expected nr of
  # Customers when running .all will continue to increase.
  include_examples '.all', 39

  include_examples '.find'
end
