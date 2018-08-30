# frozen_string_literal: true

JWTSessions.algorithm = 'HS256'
JWTSessions.access_exp_time = 600 # Access token expiry after 10 mins
JWTSessions.encryption_key = Rails.application.secrets.secret_key_base
