# frozen_string_literal: true

require 'cgi'

module Fortnox
  module API
    module Repository
      module Loaders
        def all
          response_hash = get(self.class::URI)
          instantiate_collection_response(response_hash)
        end

        def only(filter)
          response_hash = get("#{self.class::URI}?filter=#{filter}")
          instantiate_collection_response(response_hash)
        end

        def search(hash)
          attribute, value = hash.first
          uri_encoded_value = CGI.escape(value)
          uri = "#{self.class::URI}?#{attribute}=#{uri_encoded_value}"
          response_hash = get(uri)
          instantiate_collection_response(response_hash)
        end

        def find(id_or_hash)
          return find_all_by(id_or_hash) if id_or_hash.is_a? Hash

          find_one_by(id_or_hash)
        end

        def find_one_by(id)
          response_hash = get("#{self.class::URI}#{id}")
          instantiate(@mapper.wrapped_json_hash_to_entity_hash(response_hash))
        end

        def find_all_by(hash)
          response_hash = get("#{self.class::URI}?#{to_query(hash)}")
          instantiate_collection_response(response_hash)
        end

        def to_query(hash)
          hash.collect do |key, value|
            escape(key, value)
          end.sort * '&'
        end

        def escape(key, value)
          "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
        end

        private

        def instantiate_collection_response(response_hash)
          metadata_hash = @metadata_mapper.wrapped_json_hash_to_entity_hash(response_hash)
          @metadata = Model::Metadata.new(metadata_hash)

          entities_hash = @mapper.wrapped_json_collection_to_entities_hash(response_hash)
          entities_hash.map do |entity_hash|
            instantiate(entity_hash)
          end
        end
      end
    end
  end
end
