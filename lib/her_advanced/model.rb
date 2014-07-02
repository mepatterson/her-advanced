require "her_advanced/model/base"
require "her_advanced/model/deprecated_methods"
require "her_advanced/model/http"
require "her_advanced/model/attributes"
require "her_advanced/model/relation"
require "her_advanced/model/orm"
require "her_advanced/model/parse"
require "her_advanced/model/associations"
require "her_advanced/model/introspection"
require "her_advanced/model/paths"
require "her_advanced/model/nested_attributes"
require "active_model"

module HerAdvanced
  # This module is the main element of HerAdvanced. After creating a HerAdvanced::API object,
  # include this module in your models to get a few magic methods defined in them.
  #
  # @example
  #   class User
  #     include HerAdvanced::Model
  #   end
  #
  #   @user = User.new(:name => "Rémi")
  #   @user.save
  module Model
    extend ActiveSupport::Concern

    # HerAdvanced modules
    include HerAdvanced::Model::Base
    include HerAdvanced::Model::DeprecatedMethods
    include HerAdvanced::Model::Attributes
    include HerAdvanced::Model::ORM
    include HerAdvanced::Model::HTTP
    include HerAdvanced::Model::Parse
    include HerAdvanced::Model::Introspection
    include HerAdvanced::Model::Paths
    include HerAdvanced::Model::Associations
    include HerAdvanced::Model::NestedAttributes

    # Supported ActiveModel modules
    include ActiveModel::AttributeMethods
    include ActiveModel::Validations
    include ActiveModel::Validations::Callbacks
    include ActiveModel::Conversion
    include ActiveModel::Dirty

    # Class methods
    included do
      # Assign the default API
      use_api HerAdvanced::API.default_api
      method_for :create, :post
      method_for :update, :put
      method_for :find, :get
      method_for :destroy, :delete
      method_for :new, :get

      # Define the default primary key
      primary_key :id

      # Define default storage accessors for errors and metadata
      store_response_errors :response_errors
      store_metadata :metadata

      # Include ActiveModel naming methods
      extend ActiveModel::Translation

      # Configure ActiveModel callbacks
      extend ActiveModel::Callbacks
      define_model_callbacks :create, :update, :save, :find, :destroy, :initialize
    end
  end
end
