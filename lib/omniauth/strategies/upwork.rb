require "omniauth/strategies/oauth"

module OmniAuth
  module Strategies

    class Upwork < OmniAuth::Strategies::OAuth
      option :name, "upwork"

      option :client_options, {
        :site => "https://www.upwork.com",
        :request_token_path => "/api/auth/v1/oauth/token/request",
        :access_token_path => "/api/auth/v1/oauth/token/access",
        :authorize_url => "https://www.linkedin.com/services/api/auth"
      }

      uid { raw_info["info"]["ref"] }

      info do
        prune!({
          :name => full_name,
          :first_name => raw_info["auth_user"]["first_name"],
          :last_name => raw_info["auth_user"]["first_name"],
          :image => raw_info["portrait_100_img"],
          :location => location,
          :urls => {
            :public_profile => raw_info["info"]["profile_url"]
          }
        })
      end

      extra do
        prune!({ :raw_info => raw_info })
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get("/api/auth/v1/info.json").body)
      end

      private

      def full_name
        data = raw_info["auth_user"]
        [data["first_name"], data["last_name"]].compact.join(" ").strip
      end

      def location
        data = raw_info["location"]
        [data["country"], data["state"], data["city"]].compact.join(", ").strip
      end

      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end
    end

  end
end
