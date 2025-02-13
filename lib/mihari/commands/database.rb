# frozen_string_literal: true

module Mihari
  module Commands
    module Database
      def self.included(thor)
        thor.class_eval do
          desc "migrate", "Migrate DB schemas"
          method_option :verbose, type: :boolean, default: true
          #
          # @param [String] direction
          #
          def migrate(direction = "up")
            verbose = options["verbose"]
            ActiveRecord::Migration.verbose = verbose

            Mihari::Database.with_db_connection { Mihari::Database.migrate(direction.to_sym) }
          end
        end
      end
    end
  end
end
