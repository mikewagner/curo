require 'spec_helper'

describe RSSH::Runner do

  let(:runner) { RSSH::Runner.new ['add', 'localhost', '--tag', 'TEST'] }

  describe "initialization" do

    it "should parse options from args" do
      runner.options.should == { :tag => "TEST", :action => "add", :entry => "localhost" }  
    end

  end
 
  describe "#run" do
    
    it "should raise error for missing action" do
      lambda {
        runner = RSSH::Runner.new ['--tag', 'TEST']
        runner.run 
      }.should raise_error
    end
 
    it "should invoke action" do
      action = RSSH::Action::Add.new
      runner.stub(:action => action)
      action.should_receive(:invoke).once
      runner.run
    end


  end
 
  describe "#action" do

    context "for valid action" do
      it "should return instance of 'Action' class" do
        runner.action.should be_instance_of RSSH::Action::Add  
      end
    end
    
    context "for invalid action" do
      it "should raise error" do
        lambda {
          runner = RSSH::Runner.new [ 'BAD', 'localhost' ]
          runner.action
        }.should raise_error
      end
    end

  end

end
