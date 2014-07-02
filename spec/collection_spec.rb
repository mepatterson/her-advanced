require 'spec_helper'

describe HerAdvanced::Collection do

  let(:items) { [1, 2, 3, 4] }
  let(:metadata) { { :name => 'Testname' } }
  let(:errors) { { :name => ['not_present'] } }

  describe "#new" do
    context "without parameters" do
      subject { HerAdvanced::Collection.new }

      it { should eq([]) }
      its(:metadata) { should eq({}) }
      its(:errors) { should eq({}) }
    end

    context "with parameters" do
      subject { HerAdvanced::Collection.new(items, metadata, errors) }

      it { should eq([1,2,3,4]) }
      its(:metadata) { should eq({ :name => 'Testname' }) }
      its(:errors) { should eq({ :name => ['not_present'] }) }
    end
  end
end
