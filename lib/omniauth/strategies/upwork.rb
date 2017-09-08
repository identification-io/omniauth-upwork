require "omniauth/strategies/oauth"

module OmniAuth
  module Strategies

    class Upwork < OmniAuth::Strategies::OAuth
      option :name, "upwork"

      option :client_options, {
        site: "https://www.upwork.com",
        request_token_path: "/api/auth/v1/oauth/token/request",
        access_token_path: "/api/auth/v1/oauth/token/access",
        authorize_path: "/services/api/auth"
      }

      uid { raw_info["info"]["ref"] }

      info do
        prune!(
          name: full_name,
          first_name: raw_info["auth_user"]["first_name"],
          last_name: raw_info["auth_user"]["first_name"],
          email: user_info["user"]["email"],
          # Try to extract username from profile URL: https://odesk-prod-portraits.s3.amazonaws.com/Users:username:PortraitUrl_100
          nickname: user_info["user"]["id"] || raw_info["info"]["portrait_100_img"].scan(/Users:([^:]+):/).flatten.first,
          image: raw_info["info"]["portrait_100_img"],
          location: location,
          urls: {
            public_profile: raw_info["info"]["profile_url"],
            company: raw_info["info"]["company_url"]
          }
        )
      end

      extra do
        prune!(raw_info: raw_info, user_info: user_info)
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get("/api/auth/v1/info.json").body)
      end

      def user_info
        @user_info ||= MultiJson.decode(access_token.get("/api/hr/v2/users/me.json").body)
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
