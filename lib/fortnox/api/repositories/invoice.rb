require "fortnox/api/repositories/base"
require "fortnox/api/models/invoice"

module Fortnox
  module API
    module Repository
      class Invoice < Fortnox::API::Repository::Base

        def initialize
          super(
            base_uri: '/invoices/',
            json_list_wrapper: 'Invoices',
            json_unit_wrapper: 'Invoice',
            key_map: {
              administration_fee_vat: "AdministrationFeeVAT ",
              edi_information: "EDIInformation",
              eu_quarterly_report: "EUQuarterlyReport",
              freight_vat: "FreightVAT",
              ocr: "OCR",
              total_vat: "TotalVAT",
              vat_included: "VATIncluded"
            }
          )
        end

      private

        def instansiate( hash )
          Fortnox::API::Model::Invoice.new( hash )
        end

      end
    end
  end
end
