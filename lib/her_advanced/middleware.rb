require "her_advanced/middleware/parse_json"
require "her_advanced/middleware/first_level_parse_json"
require "her_advanced/middleware/second_level_parse_json"
require "her_advanced/middleware/accept_json"

module HerAdvanced
  module Middleware
    DefaultParseJSON = FirstLevelParseJSON
  end
end
