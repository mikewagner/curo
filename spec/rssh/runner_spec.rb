require 'spec_helper'
require 'stringio'

describe RSSH::Runner do

  before { @org_stdout, $stdout = $stdout, StringIO.new }  
  after  { $stdout = @org_stdout }

  before { `touch #{$rssh_config_file.inspect}` }
  after  { `rm -f #{$rssh_config_file.inspect}` }

  let(:options) { { :action => 'add', :entry => 'localhost', :tag => 'test' } }
  let(:config)  { RSSH::Configuration.load $rssh_config_file }
  let(:runner)  { RSSH::Runner.new config }

  describe "#run" do
    
    it "should raise error for missing action" do
      lambda {
        options.delete(:action)
        runner.run options
      }.should raise_error
    end

  end

  describe "#add" do

    context "when entry does not already exist" do
      
      before do
        @entry = RSSH::Entry.new :entry => 'localhost', :tag => 'test'
        runner.add @entry
      end

      it "should add entry to config" do
        runner.config.should have(1).entries
        runner.config.entries.first.should == @entry
      end

      it "should output message" do
        $stdout.string.should == "Saved 'localhost' with tag 'test'\n"
      end
    
    end   

    context "when entry already exists for tag" do
  
      before do
        @runner = RSSH::Runner.new config
        @runner.add RSSH::Entry.new :entry => '127.0.0.1', :tag => 'test'
      end
 
      it "should raise error" do
        lambda {
          @runner.add RSSH::Entry.new :entry => '127.0.0.1', :tag => 'test'
        }.should raise_error
      end

    end

    context "when entry already exists for host" do

      before do
        @runner = RSSH::Runner.new config
        @runner.add RSSH::Entry.new :entry => '10.10.10.10', :tag => 'foo'
      end
 
      it "should raise error" do
        lambda {
          @runner.add RSSH::Entry.new :entry => '10.10.10.10', :tag => 'bar'
        }.should raise_error(RSSH::DuplicateHost, "Host already exists for '10.10.10.10'")
      end

    end

  end

  describe "#remove" do
 
    before do
      config << RSSH::Entry.new( :entry => '1.1.1.1', :tag => 'deleteme' )
      @runner = RSSH::Runner.new config
    end

    it "should remove entry by tag" do
      lambda {
        @runner.remove 'deleteme'
      }.should change( config.entries, :size ).from(1).to(0)
    end
  
    it "should remove entry by host" do
      lambda {
        @runner.remove '1.1.1.1'
      }.should change( config.entries, :size ).from(1).to(0)
    end
       
    it "should output confirmation message" do
      @runner.remove '1.1.1.1'
      $stdout.string.should match "Removed entry for '1.1.1.1'"
    end

  end

  describe "#list" do

    it "should output list of entries" do
      runner = RSSH::Runner.new config
      runner.config << RSSH::Entry.new( :entry => 'localhost', :tag => '1' )
      runner.config << RSSH::Entry.new( :entry => '127.0.0.1', :tag => '2' )
      runner.list
      $stdout.string.should == "localhost (1)\n127.0.0.1 (2)\n"
    end


  end

end
