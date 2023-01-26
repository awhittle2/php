require 'spec_helper'

RSpec.describe PHP::Cookbook::Helpers do
  class DummyClass < Chef::Node
    include PHP::Cookbook::Helpers
  end
  
  subject { DummyClass.new }
