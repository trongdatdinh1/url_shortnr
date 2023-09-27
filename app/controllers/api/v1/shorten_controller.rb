# frozen_string_literal: true

module Api
  module V1
    class ShortenController < Api::V1::ApiController
      skip_after_action :verify_authorized, :verify_policy_scoped

      def create
        @url = ::Shortener.call(url_params[:original])
        render :create
      end

      private

      def url_params
        params.permit(:original, :short)
      end
    end
  end
end
