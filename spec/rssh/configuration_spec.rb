require 'spec_helper'
require 'fileutils'

describe RSSH::Configuration do

  describe "initializiation" do
 
    context "with path parameter" do   
      it "sets path" do
        config = RSSH::Configuration.new '/path/to/.rssh_config'
        config.path.should == '/path/to/.rssh_config'
      end
    end
    
    context "with no path parameter" do
      it "sets default path" do
        config = RSSH::Configuration.new 
        config.path.should == RSSH::Configuration.default_config
      end
    end

  end

  describe "#entries" do

    it "returns empty array by default" do
      config = RSSH::Configuration.new
      config.entries.should == []
    end

    it "returns array of entries" do
      config = RSSH::Configuration.new
      entry  = RSSH::Entry.new :host => 'localhost'
      config << entry
      config.entries.should == [entry]
    end 

  end

  describe "#tags" do

    let(:config) { RSSH::Configuration.new }

    it "returns empty array when no entries" do
      config.tags.should == []
    end 

    it "returns array of tags for entries" do
      config << RSSH::Entry.new( :host => 'localhost', :tag => 'foo' )
      config << RSSH::Entry.new( :host => '127.0.0.1', :tag => 'bar' )
      config << RSSH::Entry.new( :host => '0.0.0.0' )
      config.tags.should == ['foo', 'bar']
    end

  end

  describe "#hosts" do

    let(:config) { RSSH::Configuration.new }

    it "returns empty array when no entries" do
      config.hosts.should == []
    end 

    it "returns array of hosts for entries" do
      config << RSSH::Entry.new( :host => 'localhost', :tag => 'foo' )
      config << RSSH::Entry.new( :host => '127.0.0.1', :tag => 'bar' )
      config << RSSH::Entry.new( :host => '0.0.0.0' )
      config.hosts.should == ['localhost', '127.0.0.1', '0.0.0.0']
    end

  end

  describe "#has_tag?" do

    let(:config) { RSSH::Configuration.new }
    
    it "returns true if tag is found" do
      config << RSSH::Entry.new( :host => 'localhost', :tag => 'foo' )
      config.has_tag?('foo').should be_true
    end
    
    it "returns false if tag is NOT found" do
      config << RSSH::Entry.new( :host => 'localhost', :tag => 'foo' )
      config.has_tag?('bar').should be_false
    end

  end

  describe "#has_host?" do

    let(:config) { RSSH::Configuration.new }
    
    it "returns true if host is found" do
      config << RSSH::Entry.new( :host => 'localhost', :tag => 'foo' )
      config.has_host?('localhost').should be_true
    end
    
    it "returns false if host is NOT found" do
      config << RSSH::Entry.new( :host => 'localhost', :tag => 'foo' )
      config.has_host?('127.0.0.1').should be_false
    end

  end

  describe "#load!" do

    let(:config) { RSSH::Configuration.new }  
      
    it "reads and creates entries" do
      config.path = File.join( File.dirname(__FILE__), '..', 'rssh_test_config' )
      config.load!   
      config.should have(2).entries
    end

  end


end
