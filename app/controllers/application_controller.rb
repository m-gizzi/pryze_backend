class ApplicationController < ActionController::API

    def encode_token(payload)
        JWT.encode(payload, PryzeBackend::Application.credentials.jwt_token_secret)
    end

    def decode_token(token)
        JWT.decode(token, PryzeBackend::Application.credentials.jwt_token_secret)[0]
    end

end
