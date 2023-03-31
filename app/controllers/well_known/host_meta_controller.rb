# frozen_string_literal: true

module WellKnown
  class HostMetaController < ActionController::Base
    include RoutingHelper

    def show
      @webfinger_template = "#{webfinger_url}?resource={uri}"
      expires_in 3.days, public: true
      render content_type: 'application/xrd+xml', formats: [:xml]
    end
  end
end
