require 'multi_json'

module Protobuf 
  class Message
    def to_json
      MultiJson.encode self.to_hash
    end
  end
end
