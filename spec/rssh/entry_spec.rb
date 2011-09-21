require 'spec_helper'

describe RSSH::Entry do

  let(:entry) { RSSH::Entry.new }

  describe "initializiation" do

    it "should accept attribute hash" do
      attrs = { :host => '127.0.0.1' }
      entry = RSSH::Entry.new attrs
      entry.host.should == '127.0.0.1'
    end
    

    it "should accept block" do
      entry = RSSH::Entry.new do |e|
        e.host = '127.0.0.1'
      end
      entry.host.should == '127.0.0.1'
    end

  end

  describe "#attributes" do
    
    it "returns attributes hash" do
      args = { :host => 'somedomain.com', :tag => 'foo', :user => 'root' }
      RSSH::Entry.new(args).attributes.should == args
    end

  end

  describe "#to_s" do

    it "returns string with host and tag" do
      entry.host = '192.168.1.1'
      entry.tag  = 'server'
      entry.to_s.should == "192.168.1.1 (server)"
    end

    it "returns string with host" do
      entry.host = '192.168.1.1'
      entry.to_s.should == "192.168.1.1"
    end

  end

end
