# encoding: utf-8
require File.join(File.dirname(__FILE__), "../spec_helper.rb")

describe HerAdvanced::Model::NestedAttributes do
  context "with a belongs_to association" do
    before do
      HerAdvanced::API.setup :url => "https://api.example.com" do |builder|
        builder.use HerAdvanced::Middleware::FirstLevelParseJSON
        builder.use Faraday::Request::UrlEncoded
      end

      spawn_model "Foo::User" do
        belongs_to :company, :path => "/organizations/:id", :foreign_key => :organization_id
        accepts_nested_attributes_for :company
      end

      spawn_model "Foo::Company"

      @user_with_data_through_nested_attributes = Foo::User.new :name => "Test", :company_attributes => { :name => "Example Company" }
    end

    context "when child does not yet exist" do
      it "creates an instance of the associated class" do
        @user_with_data_through_nested_attributes.company.should be_a(Foo::Company)
        @user_with_data_through_nested_attributes.company.name.should == "Example Company"
      end
    end

    context "when child does exist" do
      it "updates the attributes of the associated object" do
        @user_with_data_through_nested_attributes.company_attributes = { :name => "Fünke's Company" }
        @user_with_data_through_nested_attributes.company.should be_a(Foo::Company)
        @user_with_data_through_nested_attributes.company.name.should == "Fünke's Company"
      end
    end
  end

  context "with a has_one association" do
    before do
      HerAdvanced::API.setup :url => "https://api.example.com" do |builder|
        builder.use HerAdvanced::Middleware::FirstLevelParseJSON
        builder.use Faraday::Request::UrlEncoded
      end

      spawn_model "Foo::User" do
        has_one :pet
        accepts_nested_attributes_for :pet
      end

      spawn_model "Foo::Pet"

      @user_with_data_through_nested_attributes = Foo::User.new :name => "Test", :pet_attributes => { :name => "Hasi" }
    end

    context "when child does not yet exist" do
      it "creates an instance of the associated class" do
        @user_with_data_through_nested_attributes.pet.should be_a(Foo::Pet)
        @user_with_data_through_nested_attributes.pet.name.should == "Hasi"
      end
    end

    context "when child does exist" do
      it "updates the attributes of the associated object" do
        @user_with_data_through_nested_attributes.pet_attributes = { :name => "Rodriguez" }
        @user_with_data_through_nested_attributes.pet.should be_a(Foo::Pet)
        @user_with_data_through_nested_attributes.pet.name.should == "Rodriguez"
      end
    end
  end

  context "with a has_many association" do
    before do
      HerAdvanced::API.setup :url => "https://api.example.com" do |builder|
        builder.use HerAdvanced::Middleware::FirstLevelParseJSON
        builder.use Faraday::Request::UrlEncoded
      end

      spawn_model "Foo::User" do
        has_many :pets
        accepts_nested_attributes_for :pets
      end

      spawn_model "Foo::Pet"

      @user_with_data_through_nested_attributes = Foo::User.new :name => "Test", :pets_attributes => [{ :name => "Hasi" }, { :name => "Rodriguez" }]
    end

    context "when children do not yet exist" do
      it "creates an instance of the associated class" do
        @user_with_data_through_nested_attributes.pets.length.should == 2
        @user_with_data_through_nested_attributes.pets[0].should be_a(Foo::Pet)
        @user_with_data_through_nested_attributes.pets[1].should be_a(Foo::Pet)
        @user_with_data_through_nested_attributes.pets[0].name.should == "Hasi"
        @user_with_data_through_nested_attributes.pets[1].name.should == "Rodriguez"
      end
    end
  end

  context "with a has_many association as a Hash" do
    before do
      HerAdvanced::API.setup :url => "https://api.example.com" do |builder|
        builder.use HerAdvanced::Middleware::FirstLevelParseJSON
        builder.use Faraday::Request::UrlEncoded
      end

      spawn_model "Foo::User" do
        has_many :pets
        accepts_nested_attributes_for :pets
      end

      spawn_model "Foo::Pet"

      @user_with_data_through_nested_attributes_as_hash = Foo::User.new :name => "Test", :pets_attributes => { '0' => { :name => "Hasi" }, '1' => { :name => "Rodriguez" }}
    end

    context "when children do not yet exist" do
      it "creates an instance of the associated class" do
        @user_with_data_through_nested_attributes_as_hash.pets.length.should == 2
        @user_with_data_through_nested_attributes_as_hash.pets[0].should be_a(Foo::Pet)
        @user_with_data_through_nested_attributes_as_hash.pets[1].should be_a(Foo::Pet)
        @user_with_data_through_nested_attributes_as_hash.pets[0].name.should == "Hasi"
        @user_with_data_through_nested_attributes_as_hash.pets[1].name.should == "Rodriguez"
      end
    end
  end

  context "with an unknown association" do
    it "raises an error" do
      expect {
        spawn_model("Foo::User") { accepts_nested_attributes_for :company }
      }.to raise_error(HerAdvanced::Errors::AssociationUnknownError, 'Unknown association name :company')
    end
  end
end
